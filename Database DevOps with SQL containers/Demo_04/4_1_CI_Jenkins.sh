# DEMO 4 - Continuos integration with Jenkins
#   1- Show folder structure
#   2- Show Dockerfile file
#   3- Show Jenkins pipeline file
#   4- Show DBA GitHub repository
#   5- Make changes to local DBA git repository
#   6- Commit changes to DBA GitHub repository
#   7- Check Jenkins pipeline
# -----------------------------------------------------------------------------
#

# 0- Env variables | demo path
cd /Users/carlos/Documents/Summit_2019/Demo_04

# 1- Show folder structure
# "tree" command for macOS requires brew installation

Demo_04
├── 4_1_CI_Jenkins.sh # 👉 Demo script
├── DBA
│   ├── entry_point.sh
│   └── sql_deployment.sh  # 👉 SQL Server deployment (To be changed in this demo)
├── Dockerfile # 👉 To build custom image
├── Jenkinsfile # 👉 Jenkins pipeline file
├── README.md
└── backups
    └── hr_backup.bak

# 2- Show Dockerfile file
code ./Dockerfile

# 3- Show Jenkins pipeline file
code ./Jenkinsfile

# 4- Show DBA GitHub repository
HR_Scripts
├── 1_1_CreateDBADatabase.sql
├── 2_1_RestoreDatabase.sql
├── 3_1_CreateLoginsMaskData.sql
├── 4_1_WhoIsActiveTable.sql # 👉 New script to create table for activity logging job
├── 5_1_WhoIsActiveJob.sql # 👉 New script to create job "DBA - Activity logging"
└── README.md

# 5- Make changes to local DBA git repository
# Changed SQL deployment script to include "DBA - Activity logging" job creation
# Check new function in local file
clear && grep -A12 "dba_mon ()" ./DBA/sql_deployment.sh.v2

# List deployment files
clear && echo -e "\n" && ls -ll ./DBA/sql_deployment*

# Rename original file to old & v2 to original file
mv ./DBA/sql_deployment.sh ./DBA/sql_deployment.sh.old
mv ./DBA/sql_deployment.sh.v2 ./DBA/sql_deployment.sh

# List deployment files
clear && echo -e "\n" && ls -ll ./DBA/sql_deployment*

# 6- Commit changes to DBA GitHub repository
git add .
git status
git commit -m "Updated SQL deployment script to include monitoring - 20200508"
git push origin master --force

# 7- Check Jenkins pipeline
open http://52.160.67.118:8080/job/Custom%20database%20image%20for%20DEV%20or%20STG/

# 8- Check image in Docker hub
open https://cloud.docker.com/repository/docker/crobles10/hr-db-dev_stg

# Check las image from command line
curl -s https://hub.docker.com/v2/repositories/crobles10/hr-db-dev_stg/tags/?page_size=100 | jq -r '.results|.[]|.name, .last_updated' | head -1