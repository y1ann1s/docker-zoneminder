#!/bin/bash
### In finish_zm.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxx` runs the given command as the user `xxxx`.
# If you omit that part, the command will be run as root.

ZM_PATH_BIN="/usr/bin"
RUNDIR=/var/run/zm
TMPDIR=/tmp/zm
command="$ZM_PATH_BIN/zmpkg.pl"

exec 2>&1
exec $command stop --pid /var/run/zm/zm.pid >>/var/log/zm.log
