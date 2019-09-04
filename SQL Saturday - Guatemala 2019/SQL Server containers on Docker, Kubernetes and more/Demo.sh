# Basic container
docker run \
--name sqlsat828 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqlSat828#' \
--publish 1400:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU11

# Connect from ADS
# server: localhost,1400
# database: master
# authenticationType: SqlLogin
# user: sa
# password: SqlSat828#
# savePassword: true
# profileName: SqlSat1

# Basic management
docker stop 
docker start 
docker exec -it sqlsat828 "bash"
docker ps -a
docker container ls
docker rm sqlsat828

# Creating volume
docker volume create SQLSat828
docker inspect SQLSat828

# Advanced container
docker run \
--name sqlsat828_cu11 \
--hostname sqlsat828_cu11 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqlSat828#' \
--volume SQLSat828:/var/opt/mssql \
--volume "/Users/carlos/Documents/Blog resources/Linux":/Shared \
--publish 1401:1433 \
--detach microsoft/mssql-server-linux:2017-CU11

#docker exec -it sqlsat828_cu11 "bash"

# exporting env variables
export PATH=$PATH:/opt/mssql-tools/bin;
export password="SqlSat828#";
alias sql="sqlcmd -S localhost -U SA -P $password";

# Get container IP
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sqlsat828_cu11

# Restore database from /Shared directory
RESTORE DATABASE WideWorldImporters FROM DISK = '/Shared/wwi.bak' WITH
MOVE 'WWI_Primary' TO '/var/opt/mssql/data/WideWorldImporters.mdf',
MOVE 'WWI_UserData' TO '/var/opt/mssql/data/WideWorldImporters_userdata.ndf',
MOVE 'WWI_Log' TO '/var/opt/mssql/data/WideWorldImporters.ldf', 
MOVE 'WWI_InMemory_Data_1' TO '/var/opt/mssql/data/WideWorldImporters_InMemory_Data_1';

# Stopping container for upgrade
docker stop sqlsat828_cu11

# Start new container using the same volumes (to force upgrade)
docker run \
--name sqlsat828_cu12 \
--hostname sqlsat828_cu12 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqlSat828#' \
--volume SQLSat828:/var/opt/mssql \
--volume "/Users/carlos/Documents/Blog resources/Linux":/Shared \
--publish 1401:1433 \
--detach microsoft/mssql-server-linux:2017-CU12

# Checking WWI datafiles
/var/opt/mssql/data# ls -ltr *Wide*

# Checking SQL Server log (upgrade)
/var/opt/mssql/log
grep -i upgrade errorlog | more

# Checking for build version 
grep -i 3045 errorlog