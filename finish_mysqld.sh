#!/bin/bash
### In finish_mysqld.sh (make sure this file is chmod +x):
# `/sbin/setuser mysql` runs the given command as the user `mysql`.
# If you omit that part, the command will be run as root.

/bin/kill -9 $(/bin/pidof mysqld)
/bin/kill -9 $(/bin/pidof mysqld_safe)
exit 0
