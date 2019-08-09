#!/bin/bash
set -e

# create a user to login
echo "setup database"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER pwp;
    CREATE DATABASE pwp;
    GRANT ALL PRIVILEGES ON DATABASE pwp TO pwp;
    ALTER USER pwp WITH PASSWORD 'pwp';
EOSQL

# create a table to see something in the master db:
psql -v ON_ERROR_STOP=1 --username "pwp" <<-EOSQL
CREATE TABLE test (
    id integer,
    key varchar(200),
    value varchar(200)
);
EOSQL
