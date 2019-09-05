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
#   10- Simulate failure (Take it home!)
#
#   Reference:
#   https://kubernetes.io/docs/reference/kubectl/cheatsheet/
# -----------------------------------------------------------------------------

# 1- Start minikube (k8's local cluster)
minikube start
kubectl config get-contexts
kubectl config use-context minikube

# 2- Get K8s cluster information
kubectl cluster-info

# 3- Get general information
kubectl get nodes
kubectl get pods
kubectl get services
kubectl get namespaces
kubectl describe deployment mssql-deployment

# 4- Get SQL Server service
minikube service mssql-deployment --url

# 5- Show deployment
vi sql-kubernetes.yaml

# --------------------------------------
# ADS step
# --------------------------------------
# 6- Connect to ADS (check datafiles & get version)
sqlcmd -S 192.168.99.100,31060 -U SA -P "20Ye4rsOfP@ss#"

# 7- Simulate failure (Delete pod)
kubectl delete pod --all

# 8- Check pods, make sure new pod is created
kubectl get pods

# 9- Check new pod log
kubectl logs -f mssql-deployment-6ff8956466-9sdhs

# 10- Simulate failure (Take it home!)
cd /Users/carlos/Documents/DBA Mastery/Talks-Presentations/Containers/MusicCityTech/Demo_04
./4_3_SimulateFailure.sh