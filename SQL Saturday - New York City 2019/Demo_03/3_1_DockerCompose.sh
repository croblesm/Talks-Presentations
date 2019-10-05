# DEMO 3 - Customized SQL Server instance (docker-compose)
#   1- Show folder structure
#   2- Show Dockerfile
#   3- Show application & database scripts
#   4- Show docker compose
#   5- Execute docker compose
#   6- Connect through ADS (show instance objects)
#   7- Cleanup
# -----------------------------------------------------------------------------

# 0- Navigate to target directory
cd "/Users/carlos/Documents/DBA Mastery/Talks-Presentations/Containers/SQLSat912/Demo_03"

# 1- Show folder structure
# "tree" command for macOS requires brew installation
├── Demo_03
│   ├── 3_1_DockerCompose.sh # 👉 Demo script
│   ├── 3_2_QueryHRDatabase.sql # 👉 Demo script
│   ├── docker-compose.yaml
│   └── parzival_db
│       ├── Dockerfile
│       ├── app_scripts.sh
│       ├── app_script.sql
│       └── entry_point.sh
│       └── .dockerignore

# 2- Show Dockerfile
code ./parzival_db/Dockerfile

# 3- Show application scripts
code ./parzival_db/entry_point.sh
code ./parzival_db/app_scripts.sh
code ./parzival_db/app_script.sql

# 4- Show docker compose
code ./docker-compose.yaml

# 5- Execute docker compose
# Check the progress from output
docker-compose up

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 6- Connect through ADS (show instance objects)

# 7- Cleanup
docker-compose down
docker rm -f parzival
docker rmi demo_03_parzival