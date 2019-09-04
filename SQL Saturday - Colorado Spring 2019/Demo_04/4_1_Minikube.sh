# DEMO 4 - Minikube
#   1- Start minikube (optional)
#   2- Get Kubernetes cluster info
#   3- Get nodes, pods, services, namespaces
#   4- Get SQL Server service
#   5- Show deployment
#   6- Connect to ADS (check datafiles & get version)
#   7- Simulate failure (Delete pod)
#   8- Check pods, make sure new pod is created
#   9- Check new pod log
# -----------------------------------------------------------------------------

# 1- Start minikube (k8's local cluster)
minikube start

# 2- Get K8s cluster information
kubectl cluster-info

# 3- Get general information
kubectl get nodes
kubectl get pods
kubectl get services
kubectl get namespaces

# 4- Get SQL Server service
minikube service mssql-deployment --url

# 5- Show deployment
sql-kubernetes.yaml

# --------------------------------------
# ADS step
# --------------------------------------
# 6- Connect to ADS (check datafiles & get version)
sqlcmd -S 192.168.99.100,32673 -U SA -P "20Ye4rsOfP@ss#"

# 7- Simulate failure (Delete pod)
kubectl delete pod --all

# 8- Check pods, make sure new pod is created
kubectl get pods

# 9- Check new pod log
kubectl logs <pod name>