# DEMO 2 - Volume check
#   1- List and create volume
#   2- Explore volume from Docker VM (Linuxkit)
# -----------------------------------------------------------------------------

# 1- List and create volume
# docker volume rm vlm_VersionUpgrade
# Alias version - dkvlm
docker volume ls
docker volume rm vlm_VersionUpgrade
docker volume create vlm_VersionUpgrade
docker volume ls

# 2- Explore volume from Docker VM (Linuxkit)
# Connect to macOS / Docker Linuxkit VM and explore the volumes (bash1 terminal)
docker inspect vlm_VersionUpgrade
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
cd /var/lib/docker/volumes/vlm_VersionUpgrade/_data