#!/bin/bash


set -e

if [ -f /configured ]; then
  exec /usr/bin/supervisord
fi

#configuration executution
chown -R www-data:www-data /var/cache/zoneminder/events
chown -R www-data:www-data /var/cache/zoneminder/images


date > /configured
exec /usr/bin/supervisord
