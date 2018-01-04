#!/bin/bash


set -e

#trays to fix problem with https://github.com/QuantumObject/docker-zoneminder/issues/22
chown www-data /dev/shm
mkdir -p /var/run/zm
chown www-data:www-data /var/run/zm
#to fix problem with data.timezone that appear at 1.28.108 for some reason
sed  -i "s|\;date.timezone =|date.timezone = \"${TZ:-America/New_York}\"|" /etc/php/7.0/apache2/php.ini
if [ -f /var/cache/zoneminder/configured ]; then
        echo 'already configured'
        
        /sbin/zm.sh&
else
        #wait until MySQL container start
        sleep 45s
        
        #configuration for zoneminder
        #cp /etc/mysql/mysql.conf.d/mysqld.cnf /usr/my.cnf
        #this only happends if -V was used and data was not from another container for that reason need to recreate the db.
        if [ ! -f /var/cache/zoneminder/dbcreated ]; then
          date > /var/cache/zoneminder/dbcreated
          echo "grant select,insert,update,delete on zm.* to 'zmuser'@zm identified by 'zmpass'; flush privileges; " | mysql -u root -pmysqlpsswd -h db
          echo "SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';" | mysql -u root -pmysqlpsswd -h db
          mysql -u root -pmysqlpsswd -h db < /usr/share/zoneminder/db/zm_create.sql
        fi
        
        #check if Directory inside of /var/cache/zoneminder are present.
        if [ ! -d /var/cache/zoneminder/events ]; then
           mkdir -p /var/cache/zoneminder/events
           mkdir -p /var/cache/zoneminder/images
           mkdir -p /var/cache/zoneminder/temp
        fi
        
        chown -R root:www-data /var/cache/zoneminder /etc/zm/zm.conf
        chmod -R 770 /var/cache/zoneminder /etc/zm/zm.conf
        
        #needed to fix problem with ubuntu ... and cron 
        update-locale
        date > /var/cache/zoneminder/configured
        
        /sbin/zm.sh&
fi
