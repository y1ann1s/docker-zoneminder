#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else
        #openssl req -new -x509 -days 365 -nodes -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN"  -out /etc/apache2/ssl/owncloud.pem -keyout /etc/apache2/ssl/owncloud.key
        #sed -i 's/ServerName example.com/ServerName $CN/' /etc/apache2/conf.d/owncloud.conf
        #to include the domain to the hosts
        #echo 127.0.0.1 $CN >> /etc/hosts
        # for security change permission of folder and files
        #chown -R www-data:www-data /var/www/owncloud
        #find /var/www/owncloud -type d -exec chmod 750 {} \;
        #find /var/www/owncloud -type f -exec chmod 640 {} \;
        
        #configuration for zoneminder 
        chown -R www-data:www-data /var/cache/zoneminder/events
        chown -R www-data:www-data /var/cache/zoneminder/images
        chown -R www-data:www-data /var/cache/zoneminder/temp
        
        #needed to fix problem with ubuntu ... and cron 
        update-locale
        date > /etc/configured
fi
