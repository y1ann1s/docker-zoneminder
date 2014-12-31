#!/bin/bash

source /etc/apache2/envvars
exec 2>&1 
exec /usr/sbin/apache2ctl -k stop >>/var/log/apache2.log 
