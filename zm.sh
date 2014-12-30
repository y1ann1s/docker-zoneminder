#!/bin/sh
### In zm.sh (make sure this file is chmod +x):
# `/sbin/setuser xxxx` runs the given command as the user `xxxx`.
# If you omit that part, the command will be run as root.
ZM_PATH_BIN="/usr/bin"
RUNDIR=/var/run/zm
TMPDIR=/tmp/zm
command="$ZM_PATH_BIN/zmpkg.pl"

sleep 10

mkdir -p $RUNDIR && chown www-data:www-data $RUNDIR
mkdir -p $TMPDIR && chown www-data:www-data $TMPDIR

exec $command start >>/var/log/zm.log 2>&1
