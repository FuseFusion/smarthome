#!/bin/sh

# Crontab-Eintrag erstellen
(crontab -l 2>/dev/null; echo "$CRON_BACKUP /usr/bin/backup") | crontab -
echo "setting crontab with "$CRON_BACKUP /usr/bin/backup""

# create log file
touch /var/log/backup.log

# start cron
crond

echo "container started"

# keep the container running, but allow it to be interruptable
(crond -f) & CRONPID=$!
trap "kill $CRONPID; wait $CRONPID" SIGINT SIGTERM
wait $CRONPID