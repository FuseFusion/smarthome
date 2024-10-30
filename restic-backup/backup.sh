#!/bin/sh

LOGFILE=/var/log/backup.log



datestring() {
    echo [$(date +%Y-%m-%d\ %H:%M:%S)]

}

runBackup() {
    restic backup $BACKUP_PATH --tag $RESTIC_TAG --verbose
    if [ $(echo $?) -eq 1 ]; then
        echo "Fatal error detected! exiting..."
        exit 1
    fi

    if [ $(echo $?) -eq 3 ]; then
        echo "backup command could not read some source data exiting..."
        exit 1
    fi

    if [ $(echo $?) -eq 11 ]; then
        echo "Failed to lock repository"
        exit 1        
    fi
}


echo "$(datestring) backup started" | tee -a $LOGFILE
echo "$BACKUP_PATH" | tee -a $LOGFILE

runBackup | tee -a $LOGFILE

echo "$(datestring) backup finished" | tee -a $LOGFILE