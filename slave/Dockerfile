FROM postgres:11.3

# RUN echo "host all  all    0.0.0.0/0  md5" >> $PG_CONFIG_DIR/pg_hba.conf \
#       && echo "host all  all    ::/0  md5" >> $PG_CONFIG_DIR/pg_hba.conf \
#       && echo "listen_addresses='*'" >> $PG_CONFIG_FILE

# set password for user postgres
RUN echo 'postgres:newpasswd' | chpasswd

# create ssh demon
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]


#http://www.bojankomazec.com/2019/05/introduction-to-postgresql.html
#From the answer to Trying to create postgis inside docker file gives the error:
#You're getting this error because there is no database cluster created inside the postgres docker image when you're attempting to run the pg_ctl start command.
#The database cluster is created when you run a docker container based on the image, as the initdb binary is called as part of the docker-entrypoint.sh script that is set as the ENTRYPOINT for the postgres container.
#Fix:
#RUN adduser --disabled-password dbuser
#USER postgres
#RUN initdb

#CMD pg_ctl -w start


# wait to allow connection to allow execution of interactive commands
# (no postgres is started automatically).
#CMD ["sleep", "infinity"]