# DEMO 2 - Docker build - Custom development image
#   1- Show folder structure
#   2- Show Dockerfile
#   3- Show application scripts
#   4- Build custom image for development
#   5- Test custom image (Create container)
#   6- Check deployment logs (Azure Data Studio)
#   7- Check DBA objects (Azure Data Studio)
#   8- Execute stored procedures (Azure Data Studio)
#   9- Tag image with Docker Hub repository and version
#   10- Push image to Docker Hub
# -----------------------------------------------------------------------------
#

# 0- Navigate to demo folder
# cd /Users/carlos/Documents/Summit_2019/Demo_02

# 1- Show folder structure
# "tree" command for macOS requires brew installation

Demo_02
├── 2_1_DockerBuild.sh  # 👉 Demo script
├── Backups
│   └── humanresources_backup_2019_1105.bak
├── DBA_scripts
│   ├── RestoreDatabase.sql
│   ├── CreateLoginsMaskData.sql
│   ├── sql_deployment.sh
│   └── entry_point.sh
├── Dockerfile
├── README.md
└── .gitignore
└── .dockerignore

# 2- Show Dockerfile
code ./Dockerfile

# 3- Show application scripts
code ./DBA/1_1_CreateDBADatabase.sql
code ./DBA/2_1_RestoreDatabase.sql
code ./DBA/3_1_CreateLoginsMaskData.sql
code ./DBA/sql_deployment.sh
code ./DBA/entry_point.sh

# 4- Build custom image for development
# docker rm -f hr_dev
# docker rmi hr_dev

# Build image
docker build . -t hr-database # 👉 🚀 already built for demo purposes

# List images
docker images hr-database

# 5- Test custom image (Create container)
# Create container, make sure pause is made and scripts are deployed
docker run \
--name hr_dev_sql \
--hostname hr_dev_sql \
--publish 1501:1433 \
--detach hr-database && sleep 1 && docker logs hr_dev_sql -f

# 6- Check deployment logs 
#docker exec -it custom_sql "bash"
docker exec -it hr_dev_sql cat /db_scripts/sql_deployment.log

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 7- Check DBA objects
# 8- Check DBA jobs
# 9- Execute stored procedures

# Using sqlcmd
#sqlcmd -S localhost,1500 -U sa -P 'SqLr0ck$!' -q "EXEC master.dbo.sp_whoisactive @output_column_list = '[dd hh:mm:ss.mss][session_id]'"
docker exec -it hr_dev_sql sqlcmd -U sa -P 'SqLr0ck$!' -q "EXEC DBA.dbo.sp_whoisactive @output_column_list = '[dd hh:mm:ss.mss][session_id]'"

# 10- Tag image with Docker Hub repository and version
# Get image ID
docker images
image_id=`docker images | grep hr-database | awk '{ print $3 }'`
docker tag $image_id crobles10/hr-database:2.0
docker images | grep hr-database

# 10- Push image to Docker Hub
docker push crobles10/hr-database:2.0

# Check image in Docker hub
open https://cloud.docker.com/repository/docker/crobles10/hr-database

# RHEL based images
curl -sL https://hub.docker.com/v2/repositories/crobles10/hr-database/tags/ | python -m json.tool
### Powershell 👇 🔌🐚
### Run the "pwsh" command to start PowerShell Core
### $dh_response = Invoke-WebRequest -URI https://hub.docker.com/v2/repositories/crobles10/hr-database/tags/
### $dh_response.content