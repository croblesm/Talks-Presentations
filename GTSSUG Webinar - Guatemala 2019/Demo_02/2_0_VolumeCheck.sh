# DEMO 2 - Volume check
#   1- Create and inspect volume
#   2- Explore volume from Docker engine
# -----------------------------------------------------------------------------

# 1- Create and inspect volume
# docker volume rm vlm_VersionUpgrade
docker volume ls
docker volume create vlm_VersionUpgrade

# 2- Explore volume from Docker engine
# Connect to macOS Linuxkit VM and explore the volumes (bash1 terminal)
docker inspect vlm_VersionUpgrade
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
cd /var/lib/docker/volumes