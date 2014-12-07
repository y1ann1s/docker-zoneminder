#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else
        #configuration for zoneminder 
        chown -R www-data:www-data /var/cache/zoneminder/events
        chown -R www-data:www-data /var/cache/zoneminder/images
        chown -R www-data:www-data /var/cache/zoneminder/temp
        
        #needed to fix problem with ubuntu ... and cron 
        update-locale
        date > /etc/configured
fi
