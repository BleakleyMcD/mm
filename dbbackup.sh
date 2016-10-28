#!/bin/sh

#Configuration Section
#Select directory for backup
SQL_BACKUP_DIR=""
#Select database for backup
DATABASE_NAME=""
#Enter SQL log in path for database (This can be created with the command `mysql_config_editor set --login-path=[name your log in path here] --host=[enter database host here] --user=[enter user name here] --password)`
SQL_LOGIN_PATH=""
#Number of backup versions to retain
COPIES_NUMBER=""

#####

usage(){
    echo "This script will create backups of the selected database and retain the specified amount. Script can be run manually or set up as a recurring task."
    echo "Usage: -e edit configurations, -h help"
    echo "To configure either run with the -e option or open the script in a text editor to set the configuration variables."
    exit 0
}

OPTIND=1
while getopts "he" opt ; do
    case "${opt}" in
        h) usage ;;
        e) runtype="edit";;
        *)
    esac
done

if [ "$runtype" = "edit" ] ; then
    nano "$0"
fi


FILES=$(ls "$SQL_BACKUP_DIR"| sort)
FILE_COUNT=$(echo "$FILES" | wc -l)
OLDEST_FILE=$(echo "$FILES" | head -n 1)
BACKUP_FILE=${SQL_BACKUP_DIR}/"$DATABASE_NAME"_backup_`date +"%m-%d-%Y_%H-%M-%S"`.sql


if [ "$FILE_COUNT" -ge "$COPIES_NUMBER" ] ; then
    rm "$SQL_BACKUP_DIR"/"$OLDEST_FILE" 
fi

mysqldump --login-path="$SQL_LOGIN_PATH" "$DATABASE_NAME" > "$BACKUP_FILE"

gzip "$BACKUP_FILE"
