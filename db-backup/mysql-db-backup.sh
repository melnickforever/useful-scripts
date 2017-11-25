#!/usr/bin/env bash
# This is a fork for https://github.com/matriphe/BASH-MySQL-Backup-to-Amazon-S3/blob/master/db.backup.sh
DB_NAME='your_database_name'
DB_USER='your_mysql_user'
DB_PSWD='your_mysql_password'
DB_HOST='localhost'
DB_PORT='3306'

# Temporary local place for backup
DUMP_LOC='/path/to/save/backup'
# How long the backup in local will be kept
DAYS_OLD="5"
START_TIME="$(date +"%s")"
DATE_BAK="$(date +"%Y-%m-%d")"
DATE_EXEC="$(date "+%d+%b")"
DATE_EXEC_H="$(date "+%d %b %Y %H:%M")"

echo "["$DATE_EXEC_H"] Backup process start.. "
echo "Backing up "$DB_NAME"..."
MYSQL_PWD=$DB_PSWD mysqldump --add-drop-table --lock-tables=true -u $DB_USER -h $DB_HOST -P $DB_PORT $DB_NAME | gzip -9 > $DUMP_LOC/$DB_NAME-$DATE_BAK.sql.gz

FILESIZE="$(ls -lah $DUMP_LOC/$DB_NAME-$DATE_BAK.sql.gz | awk '{print $5}')"

END_TIME="$(date +"%s")"
DIFF_TIME=$(( $END_TIME - $START_TIME ))
H=$(($DIFF_TIME/3600))
M=$(($DIFF_TIME%3600/60))
S=$(($DIFF_TIME%60))

echo "Removing old files..."
find $DUMP_LOC/*.sql.gz -mtime +$DAYS_OLD -exec rm {} \;

TWT_MSG="$DATE_EXEC+|+$DB_NAME+($FILESIZE)+in+$H+hour(s)+$M+minute(s)+$S+seconds"

echo "Done: "$TWT_MSG

# You can tweet the message or sending DM to notify your backup is completed.