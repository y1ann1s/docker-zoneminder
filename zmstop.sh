#!/bin/bash
### In zmstop.sh (make sure this file is chmod +x):
# `chpst -u root` runs the given command as the user `root`.
# If you omit that part, the command will be run as root.

chpst -u root /usr/bin/zmpkg.pl stop 2>&1
