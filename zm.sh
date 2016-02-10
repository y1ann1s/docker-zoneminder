#!/bin/bash
### In zm.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxx` runs the given command as the user `xxxx`.
# If you omit that part, the command will be run as root.
sleep 10s

/etc/init.d/ntp start  >>/var/log/ntp.log 2>&1
/etc/init.d/zoneminder start  >>/var/log/zm.log 2>&1
