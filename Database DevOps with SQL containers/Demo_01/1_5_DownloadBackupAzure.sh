#!/bin/bash

#==============================================================================
# Script name   : 1_5_DownloadBackupAzure.sh
# Description   : Script to download backup file from Azure
# Author        : Carlos Robles
# Email         : crobles@dbamastery.com
# Twitter       : @dbamastery
# Date          : 20191106
# 
# Version       : 3.0   
# Usage         : bash 1_5_DownloadBackupAzure.sh
#
# Notes         : This script assumes AZ CLI is installed and configured
#==============================================================================

# Setting storage account settings
export  AZURE_STORAGE_ACCOUNT=""
export  AZURE_STORAGE_KEY=""
container_name="sqlbackupfiles"
backup_dir=/Users/carlos/Documents/Summit_2019/Backups

echo -e "Starting script to download backups from Azure to local machine\n ..."

# Getting blob container name
echo -e "\nBlob container name:\t $container_name"

echo -e "\nListing blobs in $container_name container...\n"
az storage blob list --container-name $container_name --query '[].{BlobName:name, CreationDate:properties.creationTime}' -o table

# Getting last backup file
last_backup=`az storage blob list --container-name $container_name --output table | sort -g -k 6 | tail -1 | awk '{print $1}'`

echo -e "\nBackup file to download:\t $last_backup"

# Downloading last backup file
echo -e "\nDownloading bak file ...\n"
az storage blob download --container-name $container_name --name $last_backup --file $backup_dir/$last_backup --output table

echo -e "\nBackup downloaded succesfully:\n"
ls /Users/carlos/Documents/Summit_2019/Backups/*.bak

echo -e "\n\nEnd of script"