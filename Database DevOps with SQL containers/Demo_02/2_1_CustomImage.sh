# DEMO 2 - Custom development image
# Part 1 - Docker build
#
#   1- Show folder structure
#   2- Show Dockerfile
#   3- Show application scripts
#   4- Build custom image for development
#   5- Test custom image (Create container)
#   6- Check deployment logs
#   7- Check database objects (Azure Data Studio - Optional)
#   8- Execute stored procedures (Azure Data Studio - Optional)
#   9- Tag image with Docker Hub repository and version
#   10- Push image to Docker Hub
#   11- Check image in Docker hub
# -----------------------------------------------------------------------------
#

# 0- Env variables | demo path
cd /Users/carlos/Documents/Summit_2019/Demo_02

# 1- Show folder structure
# "tree" command for macOS requires brew installation

Demo_02
├── 2_1_DockerBuild.sh # 👉 Demo script
├── backups
│   └── hr_backup.bak
├── DBA
│   ├── sql_deployment.sh # 👉 SQL Server deployment
│   └── entry_point.sh
├── Dockerfile # 👉 To build custom image
├── README.md
└── .gitignore
└── .dockerignore

# 2- Show Dockerfile
code ./Dockerfile

# 3- Show application scripts
code ./DBA/entry_point.sh
code ./DBA/sql_deployment.sh

# 4- Build custom image for development
# Build image
docker build . -t hr-db-dev_stg

# List images
docker images hr-db-dev_stg

# 5- Test custom image (Create container)
# Create container, make sure pause is made and scripts are deployed
    docker run \
    --name hr_dev_sql \
    --hostname hr_dev_sql \
    --publish 1501:1433 \
    --env 'WAIT_SQL=30' \
    --detach hr-db-dev_stg && sleep 1 && docker logs hr_dev_sql -f

    docker run \
    --name hr_stg_sql \
    --hostname hr_stg_sql \
    --publish 1502:1433 \
    --env 'WAIT_SQL=30' \
    --env 'ENVIRONMENT=STG' \
    --detach hr-db-dev_stg_2 && sleep 1 && docker logs hr_stg_sql -f

# 6- Check deployment logs 
docker exec -it hr_dev_sql cat /db_scripts/sql_deployment.log
docker exec -it hr_dev_sql ls -ll /db_scripts/DBA/db-initialized

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 7- Check database objects (Optional)
# 8- Execute stored procedures (Optional)

# Using sqlcmd
# sqlcmd -S localhost,1501 -U sa -P '_SqLr0ck$_' -q "EXEC DBA.dbo.sp_whoisactive @output_column_list = '[dd hh:mm:ss.mss][session_id]'"
# sqlcmd -S localhost,1501 -U dev_team -P '_D3v3L0pM3nt_'  -q "EXEC DBA.dbo.sp_whoisactive @output_column_list = '[dd hh:mm:ss.mss][session_id]'"
# sqlcmd -S localhost,1502 -U sa -P '_SqLr0ck$_' -q "EXEC DBA.dbo.sp_whoisactive @output_column_list = '[dd hh:mm:ss.mss][session_id]'"
# sqlcmd -S localhost,1502 -U dev_team -P '_D3v3L0pM3nt_'  -q "EXEC DBA.dbo.sp_whoisactive @output_column_list = '[dd hh:mm:ss.mss][session_id]'"

# 9- Tag image with Docker Hub repository and version
# Get image ID
docker images hr-db-dev_stg
image_id=`docker images | grep hr-db-dev_stg | awk '{ print $3 }' | head -1`
echo $image_id
docker tag $image_id crobles10/hr-db-dev_stg:10.0
docker images | grep hr-db-dev_stg

# 10- Push image to Docker Hub (Already did it for demo purposes)
docker push crobles10/hr-db-dev_stg:10.0

# 11- Check image in Docker hub
open https://cloud.docker.com/repository/docker/crobles10/hr-db-dev_stg

# Check images from command line
curl -sL https://hub.docker.com/v2/repositories/crobles10/hr-db-dev_stg/tags/ | python -m json.tool
curl -s https://hub.docker.com/v2/repositories/crobles10/hr-db-dev_stg/tags/?page_size=60 |jq -r '.results|.[]|"{","Tag:",.name,"Last update:", .last_updated,"}","\n"'
curl -s https://hub.docker.com/v2/repositories/crobles10/hr-db-dev_stg/tags/?page_size=60 | jq -r '.results|.[]|.name, .last_updated' | head -1

### Powershell 👇 🔌🐚
### Run the "pwsh" command to start PowerShell Core
### $dh_response = Invoke-WebRequest -URI https://hub.docker.com/v2/repositories/crobles10/hr-db-dev_stg/tags/
### $dh_response.content