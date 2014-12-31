#!/bin/bash
### In zm.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxx` runs the given command as the user `xxxx`.
# If you omit that part, the command will be run as root.


svwaitup 3 /etc/service/apache2 /etc/service/mysqld || exit 1

exec 2>&1
exec /etc/init.d/zoneminder start  >>/var/log/zm.log
