FROM postgres:11.3

# RUN echo "host all  all    0.0.0.0/0  md5" >> $PG_CONFIG_DIR/pg_hba.conf \
#       && echo "host all  all    ::/0  md5" >> $PG_CONFIG_DIR/pg_hba.conf \
#       && echo "listen_addresses='*'" >> $PG_CONFIG_FILE

# wait to allow connection to allow execution of interactive commands
# (no postgres is started automatically).
CMD ["sleep", "infinity"]