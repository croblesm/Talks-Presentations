# Checking AZ subscription
#az account list --output table
#az account set --subscription "Microsoft Azure Sponsorship"

# Reference:
# https://docs.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-jenkins-github-docker-cicd
# https://medium.com/@gustavo.guss/jenkins-building-docker-image-and-sending-to-registry-64b84ea45ee9
# https://github.com/Azure/azure-quickstart-templates/tree/master/jenkins-cicd-container/
# https://oncomputingwell.princeton.edu/2018/01/triggering-a-jenkins-build-every-time-changes-are-pushed-to-a-git-branch-on-github/

# Create RS 
az group create --name Summit2019 --location westus

# Create VM - Ubuntu with Jenkins + Docker
az vm create --resource-group Summit2019 \
    --name Jenkins \
    --image UbuntuLTS \
    --admin-username azureuser \
    --generate-ssh-keys \
    --custom-data AZ_Jenkins.txt

# Opening ports
az vm open-port --resource-group Summit2019 --name Jenkins --port 8080 --priority 1001
az vm open-port --resource-group Summit2019 --name Jenkins --port 1337 --priority 1002

az vm open-port --resource-group Summit2019 --name Jenkins --port 80 --priority 1003
az vm open-port --resource-group Summit2019 --name Jenkins --port 90 --priority 1004
az vm open-port --resource-group Summit2019 --name Jenkins --port 5000 --priority 1004

# Look for succeeded

# Configure Jenkins
az vm show --resource-group Summit2019 --name Jenkins -d --query [publicIps] --o tsv
# 52.160.67.118

# Connect to Jenkins VM
ssh azureuser@52.160.67.118
#azureuser \ Viz@rd10Kr4t0s

# Check Jenkins status
service jenkins status

# Get Jenkins admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
#49efecff8bb14f38870fa4db04f86a75

# Connect to Jenkins
open http://52.160.67.118:8080

# Install default plugins
# Create first admin user
    # Username:  dbamaster
    # Password:  Summit2019
    # Full name: DBA Master
    # Email:     crobles@dbamastery.com

# docker build --tag crobles10:$BUILD_NUMBER .

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

# Make kubectl executable
chmod +x ./kubectl

# Add kubectl to PATH
sudo mv ./kubectl /usr/local/bin/kubectl

# Install AZ CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login into AZ
az login

# Set subscription
az account list --output table
az account set --subscription "Microsoft Azure Sponsorship"

# List resource groups
az group list --output table

# Setting enviroment to Kubernetes clusters
az aks get-credentials --resource-group Summit2019 --name adonis-stage
az aks get-credentials --resource-group Summit2019 --name apollo-production

# Changing Kubernetes context
kubectl config use-context adonis-stage
kubectl config use-context adonis-production