# DEMO 6 - Complex container
#   1- Check SQL Server available images at MCR
#   2- Inspect container properties
#   3- Connect to ADS (get instance properties)
#   4- Inspect files within container
# -----------------------------------------------------------------------------
# Reference:
# https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables

# 1- Create "complex" container
docker run \
--name master_CU13 \
--hostname master_CU13 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqLr0ck$!' \
--env 'MSSQL_BACKUP_DIR=/mssql_backup' \
--env 'MSSQL_DATA_DIR=/mssql_data' \
--env 'MSSQL_LOG_DIR=/mssql_log' \
--env 'MSSQL_ENABLE_HADR=1' \
--env 'MSSQL_AGENT_ENABLED=1' \
--volume vlm_Backup:/mssql_backup \
--volume vlm_Data:/mssql_data \
--volume vlm_Log:/mssql_log \
--volume "/Users/carlos/Documents/DBA Mastery/Shared":/Shared \
--publish 1500:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU13-ubuntu

# 2- Inspect container properties
docker exec -it master_CU13 "bash"
docker inspect master_CU13

# --------------------------------------
# ADS step
# --------------------------------------
# 3- Connect to ADS (get instance properties)

# 4- Inspect files within container
ls -ltra /mssql_backup
ls -ltra /mssql_data
ls -ltra /mssql_log