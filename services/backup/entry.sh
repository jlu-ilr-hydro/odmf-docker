#!/bin/sh
echo "... do initial backup"
/backup.sh
echo "... get crontab"
/usr/bin/crontab /crontab.txt
echo "... start crond in foreground"
/usr/sbin/crond -L /var/backup/crond.log -f