FROM postgres:11.3

# RUN echo "host all  all    0.0.0.0/0  md5" >> $PG_CONFIG_DIR/pg_hba.conf \
#       && echo "host all  all    ::/0  md5" >> $PG_CONFIG_DIR/pg_hba.conf \
#       && echo "listen_addresses='*'" >> $PG_CONFIG_FILE

# install barman
# ENV LANG de_DE.UTF-8
RUN apt update \ 
 && apt -y install barman

# create /etc/barman.d/master.conf
COPY master.conf /etc/barman.d/master.conf

# create .pgpass file for passwords for replication and barman user and remove access for group and other
COPY pgpass /var/lib/barman/.pgpass
RUN chown barman:barman /var/lib/barman/.pgpass \
 && chmod 600 /var/lib/barman/.pgpass

# wait to allow connection to allow execution of interactive commands
# (no postgres is started automatically).
CMD cron -f
#CMD ["sleep", "infinity"]