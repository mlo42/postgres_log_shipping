#!/bin/bash

# create replication user for the base backup:
echo "setup pg_hba.conf"
cat >> "$PGDATA/pg_hba.conf" << EOF
# log file shipping configuration:
host replication all 0.0.0.0/0 md5"
EOF

set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
CREATE ROLE $PG_REP_USER REPLICATION LOGIN CONNECTION LIMIT 100 ENCRYPTED PASSWORD '$PG_REP_PASSWORD';
EOSQL

echo "setup postgresql.conf"
cat >> ${PGDATA}/postgresql.conf <<EOF
# log file shipping configuration:
wal_level = replica
archive_mode = on
archive_command = 'test ! -f ${ARCHIVE_DIR}/%f && cp %p ${ARCHIVE_DIR}/%f'
# short archive_timeout for demonstration mode - adapt as needed:
archive_timeout = 20
# max_wal_senders = 8
# wal_keep_segments = 8
hot_standby = on
EOF

echo "ARCHIVE_DIR: $ARCHIVE_DIR"
echo "Version: 1.0"