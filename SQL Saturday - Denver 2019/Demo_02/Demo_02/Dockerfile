# From SQL Server 2017 CU13 Ubuntu image
FROM mcr.microsoft.com/mssql/server:2017-CU16-ubuntu
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD='SqLr0ck$!'
ENV MSSQL_AGENT_ENABLED=1

#Installing git
RUN apt-get update \
    && apt-get install -y git \
    # Pre-staging directories
    && mkdir /db_scripts \
    # Pulling git repositories
    && git clone https://github.com/amachanic/sp_whoisactive.git /git_repos/sp_whoisactive

# Copying directories with scripts
COPY . /db_scripts

# Exporting $PATH variable for SQLCMD and changing permissions to shell script
ENV PATH=$PATH:/opt/mssql-tools/bin
RUN chmod +x /db_scripts/DBA/sql_deployment.sh

# Executing scripts
CMD ["/bin/bash", "/db_scripts/DBA/entry_point.sh"]