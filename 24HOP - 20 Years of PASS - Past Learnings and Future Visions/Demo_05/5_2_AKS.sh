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
# az account set --subscription "Visual Studio Enterprise"
# az aks get-credentials --resource-group sqlsaturday-912 --name TARS

# Adonis DB
# sqlcmd -S 40.78.2.205 -U SA -P "MyP@ss0rd#" -i "Adonis.sql"

# 1- Connect to Kubernetes cluster in AKS
az aks get-credentials --resource-group sqlsaturday-912 --name TARS
kubectl config get-contexts
kubectl config use-context TARS

# Secret
# kubectl create secret generic mssql --from-literal=SA_PASSWORD="Th3M@st3r0fDi$4s7eR"

# 2- Get all AKS components
kubectl get all
kubectl get nodes
kubectl get pods
kubectl get services
kubectl get pv

# 3- Check PVC - Matching AZ disk with AKS-PVC
kubectl describe pvc mssql-data-claim

# Filter by Volume
kubectl describe pvc mssql-data-claim| grep "Volume:" #  ➡️ Match it with AKS-PVC
# Go to the portal --> All resources --> Look for PVC disk

# 4- Describe deployment
kubectl describe deployment mssql-plex 

# 5- Show AKS dashboard
az aks browse --resource-group sqlsaturday-912 --name TARS

# 6- Describe pod
pod=`kubectl get pods | grep mssql-plex | awk {'print $1'}`
kubectl describe pods $pod

# 6- Check pod logs
kubectl logs $pod -f

# 7- Get IP of SQL Server service
kubectl get service mssql-plex

# 8 Connect to SQL Server

sqlcmd -S 104.41.155.187 -U SA -P "SqLr0ck$!"

clear & sqlcmd -S 40.71.93.12 -U SA -P 'MyP@ss0rd#' \
-q "SET NOCOUNT ON;SELECT name FROM sys.databases; \
PRINT''; \
SELECT CONVERT(CHAR,serverproperty('ProductUpdateLevel')) as "CU";"

# 7- Upgrade SQL Server
kubectl --record deployment set image mssql-plex mssql=mcr.microsoft.com/mssql/server:2017-CU16-ubuntu

# 8- Check rolling upgrade status
# In terminal 1
kubectl rollout status -w deployment mssql-plex

# In terminal 2
kubectl get pods
kubectl describe pods mssql-deployment-786cfdb4d7-9c6d2
kubectl logs mssql-deployment-786cfdb4d7-9c6d2 -f

# 9- Check rollout history
kubectl rollout history deployment mssql-deployment