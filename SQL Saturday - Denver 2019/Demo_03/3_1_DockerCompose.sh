# DEMO 3 - Docker compose - Database + Application
#   1- Show folder structure
#   2- Show docker compose
#   3- Docker compose
#   4- Check database objects (Azure Data Studio)
#   5- Check RESTful API (Backend - RESTful API)
#   6- Check application (Frontend - Web brower)
#   7- Docker compose cleanup
# -----------------------------------------------------------------------------
#
# 0- Navigate to demo folder
# ssh azureuser@52.160.67.118
# cd /home/azureuser/Demo_03_

# 1- Show folder structure
# "tree" command for macOS requires brew installation

Demo_03_
├── 3_1_DockerCompose.sh # 👉 Demo script
├── hr_app
│   ├── docker-compose.yml # 👉 Docker compose file
│   ├── backend
│   │   ├── appsettings.DockerAdmin.json
│   │   ├── appsettings.DockerWebApp.json
│   │   ├── Dockerfile
│   │   ├── Controllers # 👉 Multiple folders was ommited
│   │   └── Models # 👉 Multiple folders was ommited
│   ├── frontend
│   │   ├── Dockerfile
│   │   └── src # 👉 Multiple folders was ommited
│   └── README.md
├── .dockerignore
├── .gitignore
└── README.md

# 2- Show docker compose
code ./hr_app/docker-compose.yml
cd hr_app

# 3- Docker compose
#docker-compose up --build
docker-compose up

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 4- Check database objects
sqlcmd -S localhost,1433 -U SA -P 'SqLr0ck$!' -Q "SET NOCOUNT ON; select first_name from HumanResources.dbo.Employees where Employee_Id=100"
sqlcmd -S localhost,1433 -U dev_team -P '123_D3v3L0pM3nt' -Q "SET NOCOUNT ON; select first_name from HumanResources.dbo.Employees where Employee_Id=100"

#   5- Check RESTful API (Backend - RESTful API)
#curl -v http://localhost:5000/api/locations | python -m json.tool
curl -s http://52.160.67.118:5000/api/locations | python -m json.tool

# 6- Check application
#open http://localhost:90
open http://52.160.67.118:90

# 7- Docker compose cleanup
docker-compose down