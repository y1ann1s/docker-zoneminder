#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
        
        /sbin/zm.sh&
else
        #to fix problem with data.timezone that appear at 1.28.108 for some reason
        sed  -i 's/\;date.timezone =/date.timezone = \"America\/New_York\"/' /etc/php5/apache2/php.ini
        #configuration for zoneminder 
        chown -R root:www-data /var/cache/zoneminder /etc/zm/zm.conf
        chmod -R 770 /var/cache/zoneminder /etc/zm/zm.conf
        
        #needed to fix problem with ubuntu ... and cron 
        update-locale
        date > /etc/configured
        
        /sbin/zm.sh&
fi
