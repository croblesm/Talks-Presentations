# From SQL Server 2017 CU16 Ubuntu image
FROM mcr.microsoft.com/mssql/server:2017-CU16-ubuntu
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD='SqLr0ck$!'

# Install git
RUN apt-get update \
    && apt-get install -y git \
    # Pre-staging directories
    && mkdir /db_scripts \
    # Pulling git repositories
    && git clone https://github.com/amachanic/sp_whoisactive.git /git/sp_whoisactive

# Staging directories and copying shell scripts
COPY . /db_scripts

# Exporting $PATH variable for SQLCMD and changing permissions to shell script
ENV PATH=$PATH:/opt/mssql-tools/bin
RUN chmod +x /db_scripts/deployment.sh

# Executing scripts
CMD ["/bin/bash", "/db_scripts/entry_point.sh"]