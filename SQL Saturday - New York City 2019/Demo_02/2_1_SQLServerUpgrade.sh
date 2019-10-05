# DEMO 2 - SQL Server upgrade
#   1- Pull images from MCR (optional)
#   2- Check local images (optional)
#   3- Create SQL Server CU15 container
#   4- Connect through ADS (perform restore & get version)
#   5- Stop SQL Server CU15 container
#   6- Create SQL Server CU16 container (version upgrade)
#   7- Check SQL Server errorlog (inside container)
#   8- Check container log
#   9- Connect through ADS (get version & check datafiles)
#   10- Check volume (list all datafiles)
# -----------------------------------------------------------------------------

# 1- Pull images from MCR (optional)
# Use docker pull to download CU15 & CU16 SQL Server images for Ubuntu
# docker pull mcr.microsoft.com/mssql/server:2017-CU15-ubuntu
# docker pull mcr.microsoft.com/mssql/server:2017-CU16-ubuntu

# 2- Check local images (optional)
# Filtered list, returning first and second column of "docker image ls" command
docker image ls | awk '{ print $1 "\t |  " $2}' | sort | grep mssql

# 3- Create SQL Server CU15 container
docker run \
--name master_CU15 \
--hostname master_CU15 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqLr0ck$!' \
--volume vlm_VersionUpgrade:/var/opt/mssql \
--volume "/Users/carlos/Documents/DBA Mastery/Talks-Presentations/Containers/SQLSat912":/Shared \
--publish 1401:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU15-ubuntu

# Check the backup file
docker exec -it master_CU15 ls -ll /Shared/wwi.bak

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 4- Connect through ADS
# Restore database
# Check SQL Server instance and OS details

# 5- Stop CU15 container
docker stop master_CU15

# 6- Create SQL Server CU16 container (version upgrade)
# Start a new container using the same volumes to upgrade SQL Server instance from CU15 to CU16
docker run \
--name master_CU16 \
--hostname master_CU16 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqLr0ck$!' \
--volume vlm_VersionUpgrade:/var/opt/mssql \
--volume "/Users/carlos/Documents/DBA Mastery/Talks-Presentations/Containers/SQLSat912":/Shared \
--publish 1401:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU16-ubuntu

# 7- Check SQL Server errorlog (within container)
# Connect through bash
docker exec -it master_CU16 "bash"

# Navigate to SQL Server log location
cd /var/opt/mssql/log

# Looking for the "upgrade" word within the log
grep -i upgrade errorlog | grep -i master |  more

# Looking for build version within the log
grep -i "14.0.3223.3" errorlog

# 8- Check container log
docker logs master_CU16 -f

# --------------------------------------
# ADS step
# --------------------------------------
# 9- Connect to ADS (check datafiles & get version)
# Check SQL Server instance
# Check databases and datafiles

#   10- Check volume (list all datafiles)
# (In terminal screen)
clear

# List all directories in volume
ls -ll

# Navigate to data directory and list MDF and LDF
cd data
ls -ll