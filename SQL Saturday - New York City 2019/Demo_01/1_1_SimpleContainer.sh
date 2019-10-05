# DEMO 1 - Basic container
#   1- Check SQL Server available images at MCR (Microsoft Container registry)
#   2- Start container
#   3- Connect through ADS (get instance name & version)
#   4- Connect through bash (inside container)
#   5- Run query using sqlcmd (inside container)
#   6- Basic management using Docker client commands
#   7- Cleanup
# -----------------------------------------------------------------------------

# 1- Check SQL Server available images at MCR
# Ubuntu based images
curl -L https://mcr.microsoft.com/v2/mssql/server/tags/list/
### Powershell 👇 🔌🐚
### Run the "pwsh" command to start PowerShell Core
### pwsh $ubuntu_response=Invoke-WebRequest -URI https://mcr.microsoft.com/v2/mssql/server/tags/list/
### $ubuntu_response.content

# RHEL based images
curl -L https://mcr.microsoft.com/v2/mssql/rhel/server/tags/list/
### Powershell 👇 🔌🐚
### Run the "pwsh" command to start PowerShell Core
### $rhel_response = Invoke-WebRequest -URI https://mcr.microsoft.com/v2/mssql/rhel/server/tags/list/
### $rhel_response.content

# 2- Starting container
docker run \
--name SQL2017_CU16 \
--hostname SQL2017_CU16 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqLr0ck$!' \
--publish 1400:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU16-ubuntu

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 3- Connect through ADS (get instance name & version)

# 4- Connect through bash (inside container)
docker exec -it SQL2017_CU16 "bash"

# 5- Run query using sqlcmd (inside container)
# Check CPU and memory specs
/opt/mssql-tools/bin/sqlcmd -U SA -P 'SqLr0ck$!'
select @@servername;
GO
select @@version;
GO
exit

# 6- Basic management using Docker client commands
### Docker aliases 🐳 📝 
### SQL Server Central Article 👇 👍
### https://bit.ly/2wcxEJj

# Alias version - dkpsa
docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"

# Alias version - dkstp SQL2017_CU16
docker stop SQL2017_CU16

# Alias version - dkstrt SQL2017_CU16
docker start SQL2017_CU16

# Alias version - dklgsf SQL2017_CU16
docker logs SQL2017_CU16 -f

# 7- Cleanup
# To force deletion: docker rm -f SQL2017_CU16
# Alias version - dkrm SQL2017_CU16
docker stop SQL2017_CU16
docker rm SQL2017_CU16