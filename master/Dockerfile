FROM postgres:11.3

ENV ARCHIVE_DIR=/mnt/server/archivedir
#RUN mkdir -p ${ARCHIVE_DIR} \
# && chown postgres:postgres ${ARCHIVE_DIR} \
# && chmod 777 ${ARCHIVE_DIR}

# write configuration, then create demo database user and database
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
RUN chmod 0755 /docker-entrypoint-initdb.d/*
