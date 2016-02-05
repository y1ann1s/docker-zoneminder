#!/bin/bash
### In zm.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxx` runs the given command as the user `xxxx`.
# If you omit that part, the command will be run as root.

#umount /dev/shm
#mount -t tmpfs -o rw,nosuid,nodev,noexec,relatime,size=${MEM:-4096M} tmpfs /dev/shm

sleep 10s

/etc/init.d/ntp start  >>/var/log/ntp.log 2>&1
/etc/init.d/zoneminder start  >>/var/log/zm.log 2>&1
