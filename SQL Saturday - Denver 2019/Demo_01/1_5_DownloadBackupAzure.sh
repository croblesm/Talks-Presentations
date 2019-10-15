#!/bin/bash

# Setting storage account settings
destination_file=$1
export  AZURE_STORAGE_ACCOUNT="MY STORAGE ACCOUNT NAME"
export  AZURE_STORAGE_KEY="MY STORAGE ACCOUNT PASSWORD"
container_name="sqlbackupfiles"

echo -e "Starting script to download backups from Azure to local machine"
echo -e "\n ..."

# Getting blob container name
echo -e "\nBlob container name:\t $container_name"

echo -e "\nListing blobs in $container_name container...\n"
az storage blob list --container-name $container_name --query '[].{BlobName:name, CreationDate:properties.creationTime}' -o table

# Getting last backup file
#export blob_name=`az storage blob list --container-name $container_name --output table | awk 'NR == 3 {print $1}'`
last_backup=`az storage blob list --container-name $container_name --output table | sort -r |awk 'NR == 1 {print $1}'`
echo -e "\nBackup file to download:\t $last_backup"

# Downloading last backup file
echo -e "\nDownloading bak file ...\n"
az storage blob download --container-name $container_name --name $last_backup --file $destination_file --output table

echo -e "\nBackup downloaded succesfully:\n"
ls /Users/carlos/Documents/Summit_2019/Backups/*.bak

echo -e "\n\nEnd of script"
