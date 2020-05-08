# DEMO 3 - Docker compose - Database + Application
#   1- Show folder structure
#   2- Show docker compose
#   3- Docker compose
#   4- Check database objects deployed (Azure Data Studio)
#   5- Test RESTful API (Backend - RESTful API)
#   6- Check application (Frontend - Web browser)
#   7- Docker compose cleanup
# -----------------------------------------------------------------------------
#

# 0- Env variables | demo path
cd /Users/carlos/Documents/Summit_2019/Demo_03

# -----------------------------------------------------------------------------------------------
# Special thanks to Geovani de Leon (from Guatemala) for the help, developing the frontend and backend 
# of this HR application. 👍 🇬🇹 🚀
# Geovani GitHub's repository: https://github.com/yovafree
# This app repository: https://git.io/JezQC
# -----------------------------------------------------------------------------------------------

# 1- Show folder structure
# "tree" command for macOS requires brew installation

Demo_03
├── 3_1_DockerCompose.sh # 👉 Demo script
├── hr_app
│   ├── docker-compose.yml # 👉 Docker compose file
│   ├── backend
│   │   ├── appsettings.DockerAdmin.json
│   │   ├── appsettings.DockerWebApp.json
│   │   ├── Dockerfile # 👉 To build "backend" image
│   │   ├── Controllers # 👉 Multiple folders was ommited
│   │   └── Models # 👉 Multiple folders was ommited
│   ├── frontend
│   │   ├── Dockerfile # 👉 To build "frontend" image (optional)
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

# New terminal
# Run control + shift + ~ to open a new terminal
# cd /Users/carlos/Documents/Summit_2019/Demo_03

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 4- Check database objects
# Using SQLCMD
sqlcmd -S localhost,1433 -U SA -P '_SqLr0ck$_' -Q "SET NOCOUNT ON; select first_name from HumanResources.dbo.Employees where Employee_Id=100"
sqlcmd -S localhost,1433 -U dev_team -P '_D3v3L0pM3nt_' -Q "SET NOCOUNT ON; select first_name from HumanResources.dbo.Employees where Employee_Id=100"

# 5- Check RESTful API (Backend - RESTful API)
#curl -s http://52.160.67.118:5000/api/locations | python -m json.tool
curl -s http://localhost:5000/api/locations | python -m json.tool

# 6- Check application
#open http://52.160.67.118:90
open http://localhost:90

# 7- Take Docker compose down
cd /Users/carlos/Documents/Summit_2019/Demo_03/hr_app
docker-compose down