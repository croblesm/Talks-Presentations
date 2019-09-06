# DEMO 1 - Basic container
#   1- Check SQL Server available images at MCR (Microsoft Container registry)
#   2- Start container
#   3- Connect to ADS (get instance name & version)
#   4- Connect through bash (inside container)
#   5- Run query using sqlcmd (inside container)
#   6- Basic management through Docker client commands
#   7- Delete container
# -----------------------------------------------------------------------------

# 1- Check SQL Server available images at MCR
# Ubuntu
curl -L https://mcr.microsoft.com/v2/mssql/server/tags/list/
#$ubuntu_response = Invoke-WebRequest -URI https://mcr.microsoft.com/v2/mssql/server/tags/list/
#$ubuntu_response.content

# RHEL
curl -L https://mcr.microsoft.com/v2/mssql/rhel/server/tags/list/
#$rhel_response = Invoke-WebRequest -URI https://mcr.microsoft.com/v2/mssql/rhel/server/tags/list/
#$rhel_response.content

# 2- Starting container
docker run \
--name SQL2017_CU16 \
--hostname SQL2017_CU16 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqLr0ck$!' \
--publish 1400:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU16-ubuntu

# --------------------------------------
# ADS step
# --------------------------------------
# 3- Connect to ADS (get instance name & version)

# 4- Connect through bash (inside container)
docker exec -it SQL2017_CU16 "bash"

# 5- Run query using sqlcmd (inside container)
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'SqLr0ck$!'
select @@servername;
GO
select @@version;
GO

# 6- Basic management through Docker client commands
# Explain aliases
# SQL Server Article:
#

docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"
docker stop SQL2017_CU16
docker start SQL2017_CU16
docker logs SQL2017_CU16 -f

# 7- Delete container
# To force deletion: docker rm -f SQL2017_CU16
docker stop SQL2017_CU16
docker rm SQL2017_CU16