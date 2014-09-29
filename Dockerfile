#name of container: docker-zoneminder
#versison of container: 0.5.1
FROM quantumobject/docker-baseimage
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

# Set correct environment variables.
ENV HOME /root

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe" >> /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/iconnor/zoneminder-master/ubuntu trusty main " >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y -q x264 mysql-server \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*

# to add mysqld deamon to runit
RUN mkdir /etc/service/mysqld
COPY mysqld.sh /etc/service/mysqld/run
RUN chmod +x /etc/service/mysqld/run

# to add apache2 deamon to runit
RUN mkdir /etc/service/apache2
COPY apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run

# to add apache2 deamon to runit
RUN mkdir /etc/service/zm
COPY zm.sh /etc/service/zm/run
RUN chmod +x /etc/service/zm/run

##startup scripts  
#Pre-config scrip that maybe need to be run one time only when the container run the first time .. using a flag to don't 
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

#pre-config scritp for different service that need to be run when container image is create 
#maybe include additional software that need to be installed ... with some service running ... like example mysqld
COPY pre-conf.sh /sbin/pre-conf
RUN chmod +x /sbin/pre-conf \
    && /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf

##scritp that can be running from the outside using docker-bash tool ...
## for example to create backup for database with convitation of VOLUME   dockers-bash container_ID backup_mysql
COPY backup.sh /sbin/backup
RUN chmod +x /sbin/backup
VOLUME /var/backups

#for zoneminder, apache2 configuration and others files ..
#RUN make-ssl-cert generate-default-snakeoil --force-overwrite
#RUN a2enmod ssl
#RUN a2ensite default-ssl
RUN mkdir -p /etc/apache2/conf.d
RUN ln -s /etc/zm/apache.conf /etc/apache2/conf.d/zoneminder.conf
RUN ln -s /etc/zm/apache.conf /etc/apache2/conf-enabled/zoneminder.conf
RUN a2enmod cgi
RUN adduser www-data video
RUN cd /usr/src \
    && wget http://www.andywilcock.com/code/cambozola/cambozola-latest.tar.gz \
    && tar -xzvf /usr/src/cambozola-latest.tar.gz \
    && mv cambozola-0.935/dist/cambozola.jar /usr/share/zoneminder  \
    && rm /usr/src/cambozola-latest.tar.gz
    
RUN echo "!/bin/sh ntpdate ntp.ubuntu.com" >> /etc/cron.daily/ntpdate
RUN chmod 755 /etc/cron.daily/ntpdate
RUN rm -R /var/www/html

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 80

#creatian of volume 
#VOLUME /var/www/zm/

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
