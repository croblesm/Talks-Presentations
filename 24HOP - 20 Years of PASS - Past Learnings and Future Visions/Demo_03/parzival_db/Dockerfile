# From SQL Server 2017 CU13 Ubuntu image
FROM mcr.microsoft.com/mssql/server:2017-CU11-ubuntu

# Staging directories and copying shell scripts
RUN mkdir /container_app_scripts
COPY . /container_app_scripts

# Creating custom bash profile and changing permissions to shell script
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
#RUN echo 'export password="SqlPass24#";' >> ~/.bash_profile
#RUN echo '. ~/.bash_profile' >> ~/.bashrc
RUN chmod +x /container_app_scripts/app_scripts.sh

# Executing scripts
CMD ["/bin/bash", "/container_app_scripts/entry_point.sh"]