#!/bin/bash
### In zm.sh (make sure this file is chmod +x):
# `chpst -u root` runs the given command as the user `root`.
# If you omit that part, the command will be run as root.

sv -w7 check apache2

exec chpst -u root /etc/init.d/zoneminder start 2>&1
