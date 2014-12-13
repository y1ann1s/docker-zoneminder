#!/bin/sh
### In zm.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxx` runs the given command as the user `xxxx`.
# If you omit that part, the command will be run as root.

sleep 15

exec /usr/bin/zmpkg.pl start >>/var/log/zm.log 2>&1
