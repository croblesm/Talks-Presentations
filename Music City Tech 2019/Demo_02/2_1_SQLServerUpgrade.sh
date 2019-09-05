# DEMO 2 - SQL Server upgrade
#   1- Pull images (optional)
#   2- Check images (optional)
#   3- Create and inspect volume
#   4- Explore volume from Docker engine
#   5- Create CU13 container
#   6- Connect to ADS (perform restore & get version)
#   7- Stop CU13 container
#   8- Create CU14 container (upgrade)
#   9- Connect to ADS (check datafiles & get version)
#   10- Check SQL Server errorlog
# -----------------------------------------------------------------------------

# 1- Pull images (optional)
# Use docker pull to download CU13 & C14 SQL Server images for Ubuntu
# docker pull mcr.microsoft.com/mssql/server:2017-CU13-ubuntu
# docker pull mcr.microsoft.com/mssql/server:2017-CU14-ubuntu

# 2- Check images (optional)
# List all SQL Server images | look for 2017-CU13 & CU14
docker image ls | awk '{ print $2}' | sort

# 3- Create and inspect volume
docker volume rm vlm_VersionUpgrade
docker volume ls
docker volume create vlm_VersionUpgrade

# 4- Explore volume from Docker engine
# Connect to macOS Linuxkit VM and explore the volumes (bash1 terminal)
docker inspect vlm_VersionUpgrade
# screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
# cd /var/lib/docker/volumes

# 5- Create CU13 container
docker run \
--name master_CU13 \
--hostname master_CU13 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqLr0ck$!' \
--volume vlm_VersionUpgrade:/var/opt/mssql \
--volume "/Users/carlos/Documents/Containers":/Shared \
--publish 1401:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU13-ubuntu

# --------------------------------------
# ADS step
# --------------------------------------
# 6- Connect to ADS
# Restore database
# Check SQL Server instance and OS details

# 7- Stop CU13 container
docker stop master_CU13

# 8- Create CU14 container (upgrade)
# Start a new container using the same volumes to upgrade SQL Server instance from CU13 to CU14
docker run \
--name master_CU14 \
--hostname master_CU14 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqLr0ck$!' \
--volume vlm_VersionUpgrade:/var/opt/mssql \
--volume "/Users/carlos/Documents/Containers":/Shared \
--publish 1401:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU14-ubuntu

# --------------------------------------
# ADS step
# --------------------------------------
# 9- Connect to ADS (check datafiles & get version)
# Check SQL Server instance and OS details
# Check databases and datafiles

#10- Check SQL Server errorlog
# Connect through bash
docker exec -it master_CU14 "bash"

# Navigate to SQL Server log location
cd /var/opt/mssql/log

# Looking for the "upgrade" word within the log
grep -i upgrade errorlog | grep -i master |  more

# Looking for build version within the log
grep -i "2017.140.3076" errorlog