#!/bin/bash

/usr/bin/mysqld_safe &
 sleep 10s

 mysqladmin -u root password mysqlpsswd
 mysqladmin -u root -pmysqlpsswd reload
 mysqladmin -u root -pmysqlpsswd create zm

 echo "grant select,insert,update,delete on zm.* to 'zmuser'@localhost identified by 'zmpass'; flush privileges; " | mysql -u root -pmysqlpsswd

 DEBIAN_FRONTEND=noninteractive apt-get update
 DEBIAN_FRONTEND=noninteractive apt-get install -y -q zoneminder

 mysql -u root -pmysqlpsswd < /usr/share/zoneminder/db/zm_create.sql
 
 #to fix error relate to ip address of container apache2
 echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
 ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf
 
 #to clear some data before saving this layer ...a docker image
 rm -R /var/www/html
 rm /etc/apache2/sites-enabled/000-default.conf
 apt-get clean
 rm -rf /tmp/* /var/tmp/*
 rm -rf /var/lib/apt/lists/*

killall mysqld
sleep 10s
