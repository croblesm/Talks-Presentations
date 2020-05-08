# DEMO 1 - Custom container
#
#   1- Create custom container
#   2- Inspect container properties
#   3- Get SQL Server instance properties (Azure Data Studio)
#   4- Backup database from source (Azure - Blob)
#   5- Download backup file from Azure blob storage (Shell script)
#   6- Restore database into container (Azure Data Studio)
#   7- Inspect database files within container
#   8- Create logins and mask data (Azure Data Studio)
#   9- Test connectivity with new logins (Azure Data Studio)
#   10- Query masked data as development team (Azure Data Studio)
# -----------------------------------------------------------------------------
# References:
#   SQL Server on Linux environment variables
#   open https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables
#

# 0- Env variables | demo path
backup_dir=/Users/carlos/Documents/Summit_2019/Backups;
cd /Users/carlos/Documents/Summit_2019/Demo_01;

# Ubuntu based images
curl -L https://mcr.microsoft.com/v2/mssql/server/tags/list/
### Powershell 👇 🔌🐚
### Make sure to execute the "pwsh" command to start a PowerShell Core session
### $ubuntu_response=Invoke-WebRequest -URI https://mcr.microsoft.com/v2/mssql/server/tags/list/
### $ubuntu_response.content

# RHEL based images
curl -L https://mcr.microsoft.com/v2/mssql/rhel/server/tags/list/
### Powershell 👇 🔌🐚
### Make sure to execute the "pwsh" command to start a PowerShell Core session
### $rhel_response = Invoke-WebRequest -URI https://mcr.microsoft.com/v2/mssql/rhel/server/tags/list/
### $rhel_response.content

# 1- Create custom container
# 👉 Using $backup as an env variable for the backup path
# Custom mount points for data files and backups

docker run \
--name demo_01 \
--hostname demo_01 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=_SqLr0ck$_' \
--env 'MSSQL_DATA_DIR=/mssql_data' \
--env 'MSSQL_LOG_DIR=/mssql_log' \
--env 'MSSQL_BACKUP_DIR=/mssql_backup' \
--env 'MSSQL_AGENT_ENABLED=1' \
--volume vlm_Data:/mssql_data \
--volume vlm_Log:/mssql_log \
--volume vlm_Backup:/mssql_backup \
--volume $backup_dir:/Shared \
--publish 1500:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU19-ubuntu-16.04

# 2- Inspect container properties
### Docker aliases 🐳 📝 
### SQL Server Central Article 👇 👍
### https://bit.ly/2wcxEJj

# Get containers status
docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

# Detailed information
docker inspect demo_01

# Get PID and status
docker inspect -f 'PID:{{.State.Pid}} Status:{{.State.Status}}' demo_01

# Get IP address
docker inspect -f 'IP address: {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' demo_01

# Get CPU and memory
docker inspect -f 'CPU Quota: {{.HostConfig.CpuQuota}} Memory Quota: {{.HostConfig.Memory}}' demo_01

# Get resource utilization
docker stats --all --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Open settings
code ./DockerSettings.png

# All volumes
docker volume ls

# List volumes attached to my container (Formatted)
clear && \
docker ps -a --format '{{ .ID }}' | xargs -I {} docker inspect -f '{{ .Name }}{{ printf "\n" }}{{ range .Mounts }} {{ printf "\n\t" }}{{ .Type }} {{ if eq .Type "bind" }}{{ .Source }}{{ end }}{{ .Name }} => {{ .Destination }}{{ end }}{{ printf "\n" }}' {}

# List volumes attached to my container (JSON)
docker inspect -f='{{json .Mounts}}' demo_01 | python -m json.tool

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
#bak_file="$backup/hr_20200508_1500.bak"
./1_5_DownloadBackupAzure.sh

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

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 8- Create logins and mask data
# 9- Test connectivity with new login
# 10- Query masked data as development team