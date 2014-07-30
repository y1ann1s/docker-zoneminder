#!/bin/bash


set -e

if [ -f /configured ]; then
  exec /usr/bin/supervisord
fi

#configuration executution

date > /configured
exec /usr/bin/supervisord
