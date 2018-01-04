#!/bin/bash

#Backup mysql
mysqldump -u root -pmysqlpsswd -h db --all-databases > /var/backups/alldb_backup.sql

#Backup important file ... of the configuration ...
cp  /etc/hosts  /var/backups/

