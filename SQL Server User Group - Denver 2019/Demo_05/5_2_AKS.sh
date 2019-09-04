# DEMO 4 - Azure Kubernetes services (AKS)
#   1- Connect to Kubernetes cluster in AKS
#   2- Get nodes, pods, services, namespaces
#   3- Check PVC - Matching AK disk with PVC
#   4- Describe deployment
#   5- Show AKS dashboard
#   6- Check pod events
#   7- Get IP of SQL Server service
#   8- Check rolling upgrade status
#   9- Check rollout history
# -----------------------------------------------------------------------------

# 0- Check AZ subscription and credentials
# az account list --output table
# az account set --subscription "Microsoft Azure Sponsorship"
# az aks get-credentials --resource-group SQLDayCoban --name Apollo

# 1- Connect to Kubernetes cluster in AKS
az aks get-credentials --resource-group SQLDayCoban --name Apollo
kubectl config get-contexts
kubectl config use-context Apollo

# Secret
# kubectl create secret generic mssql --from-literal=SA_PASSWORD="Th3M@st3r0fDi$4s7eR"

# Adonis DB
# sqlcmd -S 40.78.2.205 -U SA -P "Th3M@st3r0fDi$4s7eR" -i "Adonis.sql"

# 2- Get nodes, pods, services, namespaces
kubectl get nodes
kubectl get pods
kubectl get services

# 3- Check PVC - Matching AZ disk with AKS-PVC
kubectl describe pvc mssql-data

# Filter by Volume
kubectl describe pvc mssql-data | grep "Volume:" #  ➡️ Match it with AKS-PVC
# Go to the portal --> All resources --> Look for PVC disk

# 4- Describe deployment
kubectl describe deployment mssql-deployment

# 5- Show AKS dashboard
az aks browse --resource-group SQLDayCoban --name Apollo

# 6- Check pod events
kubectl describe pods mssql-deployment-6f95f684b8-d9svd

# 7- Get IP of SQL Server service
kubectl get service mssql-deployment

# 8 Connect to SQL Server
clear & sqlcmd -S 104.41.139.139 -U SA -P "Th3M@st3r0fDi$4s7eR" \
-q "SET NOCOUNT ON;SELECT name FROM sys.databases; \
PRINT''; \
SELECT CONVERT(CHAR,serverproperty('ProductUpdateLevel')) as "CU";"

# 7- Upgrade SQL Server
kubectl --record deployment set image mssql-deployment mssql=mcr.microsoft.com/mssql/server:2017-CU14-ubuntu

# 8- Check rolling upgrade status
# In terminal 1
kubectl rollout status -w deployment mssql-deployment

# In terminal 2
kubectl get pods
kubectl describe pods mssql-deployment-786cfdb4d7-9c6d2
kubectl logs mssql-deployment-786cfdb4d7-9c6d2 -f

# 9- Check rollout history
kubectl rollout history deployment mssql-deployment