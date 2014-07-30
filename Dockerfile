# zoneminder container
# VERSION               0.1.0

FROM angelrr7702/docker-ubuntu-14.04-sshd

MAINTAINER Angel Rodriguez  "angelrr7702@gmail.com"

# adding nessesary reporsitory
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe" >> /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/iconnor/zoneminder-master/ubuntu trusty main "


# updating & upgrade
RUN (DEBIAN_FRONTEND=noninteractive apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -q )

RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install supervisor cron x264 mysql-server


#RUN make-ssl-cert generate-default-snakeoil --force-overwrite
#RUN a2enmod ssl
#RUN a2ensite default-ssl

ADD start.sh /start.sh
ADD foreground.sh /etc/apache2/foreground.sh

ADD pre-conf.sh /pre-conf.sh


RUN (chmod 750 /start.sh && chmod 750 /etc/apache2/foreground.sh && chmod 750 /pre-conf.sh )
RUN (/bin/bash -c /pre-conf.sh)

RUN mkdir -p /etc/apache2/conf.d
RUN ln -s /etc/zm/apache.conf /etc/apache2/conf.d/zoneminder.conf
RUN ln -s /etc/zm/apache.conf /etc/apache2/conf-enabled/zoneminder.conf
RUN a2enmod cgi
RUN adduser www-data video
RUN cd /usr/src && wget http://www.andywilcock.com/code/cambozola/cambozola-latest.tar.gz
RUN tar -xzvf /usr/src/cambozola-latest.tar.gz
RUN cp cambozola-0.935/dist/cambozola.jar /usr/share/zoneminder
RUN echo "!/bin/sh ntpdate ntp.ubuntu.com" >> /etc/cron.daily/ntpdate
RUN chmod 755 /etc/cron.daily/ntpdate

RUN rm -R /var/www/html

# supervisor configuration
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# for sshd and web access ...
EXPOSE 22 80

#run supervisord
CMD ["/usr/bin/supervisord"]
