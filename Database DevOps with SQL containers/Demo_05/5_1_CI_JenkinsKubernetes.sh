# DEMO 5 - Continuos integration with Jenkins and Kubernetes
#   1- Show folder structure
#   2- Show Kubernetes services and deployments
#   3- Show Dockerfile file
#   4- Show Jenkins pipeline file
#   5- Make changes to local DBA git repository
#   6- Commit changes to DBA GitHub repository
#   7- Check Jenkins pipeline
#   8- Check deployment and pods
#   9- Check SQL Server properties - Execute DBA job
#   10- Test RESTful API
#   11- Check website status
# -----------------------------------------------------------------------------
#

# 0- Env variables | demo path
cd /Users/carlos/Documents/Summit_2019/Demo_05
kubectl config use-context apollo-stage
kubectl config get-contexts

# Mapping local variables to Kubernetes services
back_end=`kubectl get service hr-backend | grep hr-backend | awk {'print $4'}`;
front_end=`kubectl get service hr-frontend | grep hr-frontend | awk {'print $4'}`;
database=`kubectl get service hr-sql-dev | grep hr-sql-dev | awk {'print $4'}`;

# 1- Show folder structure
# "tree" command for macOS requires brew installation

Demo_04
├── 5_1_CI_JenkinsKubernetes.sh # 👉 Demo script
├── DBA
│   ├── entry_point.sh
│   └── sql_deployment.sh  # 👉 SQL Server deployment (Updated from previous demo)
├── deployments
│   ├── dplmnt_backend.yaml
│   ├── dplmnt_database.yaml
│   └── dplmnt_frontend.yaml
├── persistent_volumes
│   └── pvc_database.yaml
├── services
│   ├── srvc_backend.yaml
│   ├── srvc_database.yaml
│   └── srvc_frontend.yaml
├── Dockerfile # 👉 To build custom image
├── Jenkinsfile # 👉 Jenkins pipeline file
├── README.md
└── backups
    └── hr_backup.bak # 👉 Backup file downloaded from Azure

# 2- Show Kubernetes services and deployments
kubectl get pods
kubectl get pvc
kubectl get deployments
kubectl get services

# Kubernetes dashboard
az aks browse --resource-group Summit2019 --name apollo-stage

# 3- Show Dockerfile file
code ./Dockerfile

# 4- Show Jenkins pipeline file
code ./Jenkinsfile

# 5- Make changes to local DBA git repository
# Change SQL Server CU version in Dockerfile
# Dockerfile before change
clear && echo -e "\n" && head -2 Dockerfile

# Making change to Dockerfile
sed -i '' "s/CU15/CU16/g" Dockerfile

# Dockerfile after change
echo -e "\n" && head -2 Dockerfile

# 6- Commit changes to DBA GitHub repository
git add .
git status
git commit -m "Updated CU version for SQL Server of custom image, also included UPGRADE flag to SQL deployment script"
git push origin master --force

# 7- Check Jenkins pipeline
open http://52.160.67.118:8080/job/Custom%20database%20image%20for%20DEV%20or%20STG%20-%20Kubernetes/

# 8- Check deployment and pods
kubectl describe deployment hr-sql-dev | grep Image
kubectl get pods
MyPod=`kubectl get pods | grep hr-sql-dev | awk {'print $1'}`
kubectl describe pod $MyPod
kubectl logs $MyPod -f

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 9- Check SQL Server properties - Execute DBA job

# 10- Test RESTful API
curl -s http://$back_end:5000/api/locations | python -m json.tool

# 11- Check website status
open http://$front_end:80/