# DEMO 4 - Custom Image
#   1- Listing images
#   2- Show folder structure
#   3- Inpect Dockerfile
#   4- Show deployment scripts
#   5- Build custom image
#   6- Start container with local custom image
#   7- Test sqlcmd ($PATH) and list databases
#   8- Test database deployment
#   9- Test sp_WhoIsActive deployment
#   10- Tag image with Docker Hub repository and version
#   11- Push image to Docker Hub
# -----------------------------------------------------------------------------

# 0- Navigate to target directory
cd "/Users/carlos/Documents/DBA Mastery/Talks-Presentations/Containers/SQLSat912/Demo_04"

# 1- Listing images
docker images | grep endurance

# 2- Show folder structure
# "tree" command for macOS requires brew installation
├── Demo_04
│   ├── 4_1_CustomImage.sh # 👉 Demo script
│   └── endurance
│       ├── 4_2_TARS.sql
│       ├── Dockerfile
│       ├── deployment.sh
│       └── entry_point.sh
│       └── .dockerignore

# 3- Inpect Dockerfile
code ./endurance/Dockerfile

# 4- Show deployment scripts
code ./endurance/entry_point.sh
code ./endurance/deployment.sh
code ./endurance/TARS.sql

# 5- Build custom image
docker build -t endurance ./endurance
docker images | grep endurance

# 6- Start container with local custom image
docker run \
--name endurance \
--hostname endurance \
--publish 1633:1433 \
--detach endurance:latest && sleep 1 && docker logs endurance -f

# 7- Test sqlcmd ($PATH) and list databases
docker exec -it endurance "bash"
sqlcmd -U sa -P 'SqLr0ck$!'
SELECT name FROM sys.databases;
GO

# 8- Test database deployment
docker exec -it endurance sqlcmd -U sa -P 'SqLr0ck$!' \
-q "SELECT RobotName FROM TARS.dbo.Robot;"
exit

# 9- Test sp_WhoIsActive deployment
docker exec -it endurance sqlcmd -U sa -P 'SqLr0ck$!' \
-q "EXEC master.dbo.sp_whoisactive @output_column_list = '[dd hh:mm:ss.mss][session_id]'"

# 10- Tag image with Docker Hub repository and version
docker images | grep endurance
image_id=`docker images | grep endurance | awk '{ print $3 }'`
docker tag $image_id crobles10/endurance:3.0
docker images | grep endurance

# 11- Push image to Docker Hub
# open https://hub.docker.com/r/crobles10/endurance
docker push crobles10/endurance:3.0