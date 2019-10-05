# DEMO 6 - Azure Kubernetes services (AKS) - HA
#   1- Get pods
#   2- Get public IP of SQL Server service
#   3- Simulate failure
#   4- Connect to SQL Server
#   5- Show Kubernetes dashboard
# -----------------------------------------------------------------------------

# 0- Navigate to target directory
cd "/Users/carlos/Documents/DBA Mastery/Talks-Presentations/Containers/SQLSat912/Demo_06"

# 1- Get pods
kubectl get pods

# 2- Get public IP of SQL Server service
kubectl get service mssql-plex
MyService=`kubectl get service mssql-plex | grep mssql-plex | awk {'print $4'}`

# 3- Simulate failure
./6_2_SimulateFailure.sh

# 4- Connect to SQL Server
clear & sqlcmd -S $MyService -U SA -P "_EnDur@nc3_" \
select @@servername;
GO
select @@version;
GO
exit

# 5- Show Kubernetes dashboard
az aks browse --resource-group sqlsaturday-912 --name Endurance