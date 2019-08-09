# postgres log shipping

Testsetup for a postgresql database using WAL log shipping, but no streaming replication. First a full backup needs to be fetched, then the wal files are continuously deployed on the standby database.

WAL files are shared by the use of a mounted/shared directory in both docker containers.

following https://wiki.postgresql.org/wiki/Hot_Standby#Start_your_standby_server

```bash
# startup the master and slave database containers
docker-compose up

# login the slave to do the slave configuration using a base backup and wal files
docker exec -u postgres -it postgres_wal_test_slave-ubuntu_1 bash

# full backup from master to directory on slave (manual password input needed!)
chmod -R 750 /var/lib/postgresql/db_master/
rm -rf /var/lib/postgresql/db_master/* 
pg_basebackup -h db-master -U replicator \
  --pgdata=/var/lib/postgresql/db_master \
  --wal-method=stream \
  --verbose 

# not needed on fresh install (no db made yet) - otherwise stop the slave db first:
# /usr/lib/postgresql/11/bin/pg_ctl -D /var/lib/postgresql/data stop

# copy the full backpu data from master over slave:
rm -rf /var/lib/postgresql/data/* \
&& chmod -R 750 /var/lib/postgresql/data/ \
&& cp -R /var/lib/postgresql/db_master/* /var/lib/postgresql/data/ \
&& rm -rf /var/lib/postgresql/data/pg_wal/*

# modify the postgres config (no archiving on slave/standby db)
sed -i.bak -e 's/archive_mode = on/archive_mode = off/' /var/lib/postgresql/data/postgresql.conf
sed -i.bak -e 's/wal_level = replica/#wal_level = replica/' /var/lib/postgresql/data/postgresql.conf
sed -i.bak -e 's/archive_timeout/#archive_timeout/' /var/lib/postgresql/data/postgresql.conf

# create recovery.conf - read all available WAL files and keep doing so for new files:
echo  restore_command = \'cp /mnt/server/archivedir/%f %p\' >> /var/lib/postgresql/data/recovery.conf
echo  standby_mode = \'on\' >> /var/lib/postgresql/data/recovery.conf

# start the slave/standby db:
/usr/lib/postgresql/11/bin/pg_ctl -D /var/lib/postgresql/data  -l logfile start
```

after this, all changes from the master are propagated from the master to the slave (as soon as the wal files are written on the master)