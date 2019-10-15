# DEMO 1 - Custom container
#   1- Create custom container
#   2- Inspect container properties
#   3- Get SQL Server instance properties (Azure Data Studio)
#   4- Backup database from source (Azure - Blob)
#   5- Download backup file from Azure blob storage (Shell script)
#   6- Restore database in container (Azure Data Studio)
#   7- Inspect files within container (Azure Data Studio)
#   8- Create logins and mask data (Azure Data Studio)
#   9- Test connectivity with new login (Azure Data Studio)
#   10- Query masked data as Dev team(Azure Data Studio)
# -----------------------------------------------------------------------------
# References:
#   SQL Server on Linux environment variables
#   open https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables
#
#   Mount Azure file share over SMB with macOS
#   open https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-mac
#

# 0- Env variables
backup=/Users/carlos/Documents/Summit_2019/Backups
cd /Users/carlos/Documents/Summit_2019/Demo_01
docker volume rm vlm_Data vlm_Log vlm_Backup

# 1- Create custom container
 # 👉 Using $backup as an env variable for the backup path

docker run \
--name demo_01 \
--hostname demo_01 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqLr0ck$!' \
--env 'MSSQL_DATA_DIR=/mssql_data' \
--env 'MSSQL_LOG_DIR=/mssql_log' \
--env 'MSSQL_BACKUP_DIR=/mssql_backup' \
--volume vlm_Data:/mssql_data \
--volume vlm_Log:/mssql_log \
--volume vlm_Backup:/mssql_backup \
--volume $backup:/Shared \
--publish 1500:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU16-ubuntu

# 2- Inspect container properties
# All details
docker inspect demo_01

# All volumes
docker volume ls

# List volumes attached to my container
docker inspect --format='{{json .Mounts}}' demo_01 | python -m json.tool

# List local volumes
docker inspect demo_01 | grep -i '"Type": "volume"' -C3 | \
grep -v "Propagation" | sed 's/\--//g; s/\},//g; /^$/d'

# List bind volumes
docker inspect demo_01 | grep -i '"Type": "bind"' -C3 | \
grep -v "Propagation" | sed 's/\--//g; s/\},//g; /^$/d'

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 3- Get SQL Server instance properties
# 4- Backup database from source (Azure - Blob)

# 5- Download backup file from Azure blob storage
# code ./1_5_DownloadBackupAzure.sh

# Execute shell script
bak_file="$backup/humanresources_backup_2019_1105.bak"
./1_5_DownloadBackupAzure.sh $bak_file

# Checking backup from container
docker exec -it demo_01 ls "/Shared/"

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 6- Restore database in container

# 7- Inspect files within container
# List MDFs
docker exec -it demo_01 ls -ll "/mssql_data"

# List LDFs
docker exec -it demo_01 ls -ll "/mssql_log"

# List backups
docker exec -it demo_01 ls -ll "/mssql_backup"

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 8- Create logins and mask data
# 9- Test connectivity with new login
# 10- Query masked data as Dev team