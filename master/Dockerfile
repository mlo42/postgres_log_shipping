FROM postgres:11.3

# write configuration, then create demo database user and database
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
RUN chmod 0755 /docker-entrypoint-initdb.d/*
