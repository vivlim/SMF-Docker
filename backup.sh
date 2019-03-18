#!/bin/bash

source backup.config.sh

if [ -z "$SMF_DB_USERNAME" ]; then echo "FATAL ERROR: SMF_DB_USERNAME not set"; exit 1; fi
if [ -z "$SMF_DB_PASSWORD" ]; then echo "FATAL ERROR: SMF_DB_PASSWORD not set"; exit 1; fi
if [ -z "$BACKUP_PATH" ]; then echo "FATAL ERROR: BACKUP_PATH not set"; exit 1; fi

now_date=$(date +"%Y_%m_%d")
now_time=$(date +"%H_%M_%S")

destination_path="$BACKUP_PATH/$now_date"

mkdir -p "$destination_path"

docker exec `docker ps --filter name=smf_db -q` mysqldump -usmfuser -psmfpass --all-databases > "$destination_path/db-$now_date-$now_time.sql"
docker exec `docker ps --filter name=smf_web -q` tar -czf - /var/www/html > "$destination_path/web-$now_date-$now_time.tar.gz"

echo "Backup written to $destination_path"