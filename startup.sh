#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
        #start external process that will wait for apache and mysql start to run one time 
        /sbin/zm.sh &
else
        #configuration for zoneminder 
        chown -R root:www-data /var/cache/zoneminder
        chmod -R 770 /var/cache/zoneminder
        
        #needed to fix problem with ubuntu ... and cron 
        update-locale
        date > /etc/configured
        #start external process that will wait for apache and mysql start to run one time 
        /sbin/zm.sh &
fi
