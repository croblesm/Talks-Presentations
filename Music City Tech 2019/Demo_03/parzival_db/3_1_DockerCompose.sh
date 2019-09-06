# DEMO 3 - Customized SQL Server instance (docker-compose)
#   1- Show Dockerfile
#   2- Show folder structure
#   3- Show application scripts
#   4- Show database scripts
#   5- Execute docker compose
#   6- Show results in ADS
#   7- Cleanup
# -----------------------------------------------------------------------------

# 5- Execute docker compose
# Navigate to 24HOP directory
cd "/Users/carlos/Documents/DBA Mastery/Talks-Presentations/Containers/MusicCityTech/Demo_03"

# Build and run Docker compose
docker-compose up --build

# --------------------------------------
# ADS step
# --------------------------------------
# 6- Show database and objects in ADS

# 7- Cleanup
# Run Docker compose
docker-compose down
docker rm -f parzival
docker rmi demo_03_parzival