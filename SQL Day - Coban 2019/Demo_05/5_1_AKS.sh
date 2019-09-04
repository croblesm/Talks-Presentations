# DEMO 4 - Azure Kubernetes services (AKS)
#   1- Start minikube (optional)
#   2- Get Kubernetes cluster info
#   3- Get nodes, pods, services, namespaces
#   4- Get SQL Server service
#   5- Show deployment
#   6- Connect to SQL Server
#   SqlS@7_830#
# -----------------------------------------------------------------------------

# Connect to Kubernetes cluster in AKS
carlos@Azure:~$ az aks get-credentials --resource-group ApolloK8s --name Adonis
Merged "Adonis" as current context in /home/carlos/.kube/config

# Get nodes
carlos@Azure:~$ kubectl get nodes
NAME                       STATUS   ROLES   AGE     VERSION
aks-agentpool-25004320-0   Ready    agent   5m12s   v1.12.6
aks-agentpool-25004320-1   Ready    agent   5m9s    v1.12.6
aks-agentpool-25004320-2   Ready    agent   5m8s    v1.12.6

# Show persistent volume claim for AKS
# Open text editor

# Check PVC - Matching AK disk with PVC
carlos@Azure:~$ kubectl describe pvc mssql-data | grep "Volume:"
Name:          mssql-data
Namespace:     default
StorageClass:  azure-disk
Status:        Bound
Volume:        pvc-b6a7d706-4dcc-11e9-967b-72a792210e10
Labels:        <none>
Annotations:   kubectl.kubernetes.io/last-applied-configuration:
                 {"apiVersion":"v1","kind":"PersistentVolumeClaim","metadata":{"annotations":{"volume.beta.kubernetes.io/storage-class":"azure-disk"},"name..."
               pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-class: azure-disk
               volume.beta.kubernetes.io/storage-provisioner: kubernetes.io/azure-disk
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      8Gi
Access Modes:  RWO
Events:
  Type       Reason                 Age    From                         Message
  ----       ------                 ----   ----                         -------
  Normal     ProvisioningSucceeded  3m43s  persistentvolume-controller  Successfully provisioned volume pvc-b6a7d706-4dcc-11e9-967b-72a792210e10 using kubernetes.io/azure-disk
Mounted By:  <none>

# Show the disk in AZ
# Go to the portal --> All resources --> Look for PVC disk
carlos@Azure:~$ kubectl describe pvc mssql-data | grep "pvc-b6a7d706-4dcc-11e9-967b-72a792210e10"
Volume:        pvc-b6a7d706-4dcc-11e9-967b-72a792210e10
  Normal     ProvisioningSucceeded  8m39s  persistentvolume-controller  Successfully provisioned volume pvc-b6a7d706-4dcc-11e9-967b-72a792210e10 using kubernetes.io/azure-disk

# Creating deployment
# Open text editor --> Paste code:

# Check pods
carlos@Azure:~$ kubectl get pod
NAME                                READY   STATUS              RESTARTS   AGE
mssql-deployment-5bc9cc6d54-j79p4   0/1     ContainerCreating   0          3s

# Check services
carlos@Azure:~$ kubectl get services
NAME               TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
kubernetes         ClusterIP      10.0.0.1      <none>          443/TCP          49m
mssql-deployment   LoadBalancer   10.0.202.58   40.117.76.238   1433:30825/TCP   12m

# AKS objects (dashboard)
# az aks browse --resource-group ApolloK8s --name Adonis

# Checking pod events
carlos@Azure:~$ kubectl describe pods mssql-deployment-5bc9cc6d54-lbw97
Events:
  Type     Reason                  Age                  From                               Message
  ----     ------                  ----                 ----                               -------
  Normal   Scheduled               15m                  default-scheduler                  Successfully assigned default/mssql-deployment-5bc9cc6d54-lbw97 to aks-agentpool-25004320-1
  Warning  FailedAttachVolume      15m                  attachdetach-controller            Multi-Attach error for volume "pvc-b6a7d706-4dcc-11e9-967b-72a792210e10" Volume is already exclusively attached to one node and cannot be attached to another
  Warning  FailedMount             8m52s (x3 over 13m)  kubelet, aks-agentpool-25004320-1  Unable to mount volumes for pod "mssql-deployment-5bc9cc6d54-lbw97_default(f55a9d9c-4dd1-11e9-967b-72a792210e10)": timeout expired waiting for volumes to attach or mount for pod "default"/"mssql-deployment-5bc9cc6d54-lbw97". list of unmounted volumes=[mssqldb]. list of unattached volumes=[mssqldb default-token-7t565]
  Normal   SuccessfulAttachVolume  8m22s                attachdetach-controller            AttachVolume.Attach succeeded for volume "pvc-b6a7d706-4dcc-11e9-967b-72a792210e10"
  Normal   Pulling                 7m13s                kubelet, aks-agentpool-25004320-1  pulling image "mcr.microsoft.com/mssql/server:2017-latest"
  Normal   Pulled                  3m14s                kubelet, aks-agentpool-25004320-1  Successfully pulled image "mcr.microsoft.com/mssql/server:2017-latest"
  Normal   Created                 3m4s                 kubelet, aks-agentpool-25004320-1  Created container
  Normal   Started                 3m3s                 kubelet, aks-agentpool-25004320-1  Started container

# Getting IP to connect to SQL Server
carlos@Azure:~$ kubectl get service mssql-deployment
NAME               TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
mssql-deployment   LoadBalancer   10.0.202.58   40.117.76.238   1433:30825/TCP   34m

# Connecting to SQL Server
carlos@Azure:~$ sqlcmd -S 40.117.76.238 -U sa -P "Th3M@st3r0fDi$4s7eR"
1> select @@version;
2> go

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Microsoft SQL Server 2017 (RTM-CU13) (KB4466404) - 14.0.3048.4 (X64)
        Nov 30 2018 12:57:58
        Copyright (C) 2017 Microsoft Corporation
        Developer Edition (64-bit) on Linux (Ubuntu 16.04.5 LTS)

(1 rows affected)