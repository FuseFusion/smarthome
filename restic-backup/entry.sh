#!/bin/sh

# backup command to be run
COMMAND="restic backup /data/ --tag $RESTIC_TAG"

# Crontab-Eintrag erstellen
(crontab -l 2>/dev/null; echo "$CRON_TIME $COMMAND") | crontab -


# create log file
touch /var/log/restic.log

# start cron
crond

echo "container started"

exec "$@"