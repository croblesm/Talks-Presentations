# From SQL Server 2017 CU13 Ubuntu image
FROM mcr.microsoft.com/mssql/server:2017-CU16-ubuntu

# Staging directories and copying shell scripts
RUN mkdir /container_app_scripts
COPY . /container_app_scripts

# Making app_scripts.sh executable & adding mssql-tools to $PATH env
RUN chmod +x /container_app_scripts/app_scripts.sh
ENV PATH=$PATH:/opt/mssql-tools/bin

# Executing scripts
CMD ["/bin/bash", "/container_app_scripts/entry_point.sh"]