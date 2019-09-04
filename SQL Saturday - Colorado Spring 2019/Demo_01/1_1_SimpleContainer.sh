# DEMO 1 - Basic container
#   1- Start a container
#   2- Connect to ADS (get instance name & version)
#   3- Basic commands
#   4- Connect through bash
#   5- Run query using sqlcmd
#   6- Run basic Docker client commands
#   7- Delete container
# -----------------------------------------------------------------------------

# 1- Starting container
docker run \
--name SQLSat830 \
--hostname SQLSat830 \
--env 'ACCEPT_EULA=Y' \
--env 'MSSQL_SA_PASSWORD=SqlS@T830#' \
--publish 1400:1433 \
--detach mcr.microsoft.com/mssql/server:2017-CU13-ubuntu

# --------------------------------------
# ADS step
# --------------------------------------
# 2- Connect to ADS (get instance name & version)

# 3- Basic management through Docker client commands
# Explain dpsa alias
# alias dpsa='docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"'
# Start \ stop

dpsa 
docker stop SQLSat830
docker start SQLSat830

# 4- Connect through bash
docker exec -it SQLSat830 "bash"

# 5- Run query using sqlcmd
/opt/mssql-tools/bin/sqlcmd -H localhost -U SA -P SqlS@T830#
select @@servername;
GO
select @@version;
GO

# 6- Run basic Docker client commands
dpsa
docker images
docker container ls

# 7- Delete container
docker rm SQLSat830