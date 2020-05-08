# DEMO 2 - Custom development image
# Part 1 - Troubleshooting
#
#   1- Create container using custom dev image using ACI (Azure container instances)
#   2- Check container logs
#   3- Get container public DNS / IP
#   4- Connect to container using SQLCMD
#   5- Execute some queries
#   6- Report issue to DBA
#   7- Use sp_WhoIsActive on Notebook
# -----------------------------------------------------------------------------
#

# 0- Env variables | demo path
cd /Users/carlos/Documents/Summit_2019/Demo_02

### Getting started with Azure container instances 💻 📝 
### MSSQL tips articles series 👇 👍
### https://bit.ly/324Tqwd --> Create
### https://bit.ly/388jUQo --> Manage
### https://bit.ly/2PxqARR --> Connect

# 1- Creating container using Azure container instances
# To delete an existing ACI container
# az container delete --name hr-dev-sql01 --resource-group Summit2019

az container create --resource-group Summit2019 \
--name hr-dev-sql01 \
--image crobles10/hr-db-dev_stg:10.0 \
--environment-variables WAIT_SQL=35 \
--dns-name-label hr-dev-sql01 \
--cpu 2 \ # 👀 Cannot use 0 or the default - minimum is 2 CPUs for SQL Server on Linux
--memory 2 \ # 👀 Cannot use 0 or the default - minimum is 2 GBs for SQL Server on Linux
--port 1433

### SQL Server on Linux - System requirements 👀 👇
### https://bit.ly/2Wxn2RW

# Container creation output from Azure
{
  "containers": [
    {
      "command": null,
      "environmentVariables": [
        {
          "name": "WAIT_SQL",
          "secureValue": null,
          "value": "35"
        }
      ],
      "image": "crobles10/hr-db-dev_stg:10.0",
      "instanceView": {
        "currentState": {
          "detailStatus": "",
          "exitCode": null,
          "finishTime": null,
          "startTime": "2020-03-01T19:10:54+00:00",
          "state": "Running"
        },
        "events": [
          {
            "count": 1,
            "firstTimestamp": "2020-03-01T19:09:30+00:00",
            "lastTimestamp": "2020-03-01T19:09:30+00:00",
            "message": "pulling image \"crobles10/hr-db-dev_stg:10.0\"",
            "name": "Pulling",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2020-03-01T19:10:45+00:00",
            "lastTimestamp": "2020-03-01T19:10:45+00:00",
            "message": "Successfully pulled image \"crobles10/hr-db-dev_stg:10.0\"",
            "name": "Pulled",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2020-03-01T19:10:54+00:00",
            "lastTimestamp": "2020-03-01T19:10:54+00:00",
            "message": "Created container",
            "name": "Created",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2020-03-01T19:10:54+00:00",
            "lastTimestamp": "2020-03-01T19:10:54+00:00",
            "message": "Started container",
            "name": "Started",
            "type": "Normal"
          }
        ],
        "previousState": null,
        "restartCount": 0
      },
      "livenessProbe": null,
      "name": "hr-dev-sql01",
      "ports": [
        {
          "port": 1433,
          "protocol": "TCP"
        }
      ],
      "readinessProbe": null,
      "resources": {
        "limits": null,
        "requests": {
          "cpu": 2.0,
          "gpu": null,
          "memoryInGb": 2.0
        }
      },
      "volumeMounts": null
    }
  ],
  "diagnostics": null,
  "dnsConfig": null,
  "id": "/subscriptions/a3729944-2d39-4be1-8251-0529dd60c431/resourceGroups/Summit2019/providers/Microsoft.ContainerInstance/containerGroups/hr-dev-sql01",
  "identity": null,
  "imageRegistryCredentials": null,
  "instanceView": {
    "events": [],
    "state": "Running"
  },
  "ipAddress": {
    "dnsNameLabel": "hr-dev-sql01",
    "fqdn": "hr-dev-sql01.westus.azurecontainer.io",
    "ip": "13.83.99.58",
    "ports": [
      {
        "port": 1433,
        "protocol": "TCP"
      }
    ],
    "type": "Public"
  },
  "location": "westus",
  "name": "hr-dev-sql01",
  "networkProfile": null,
  "osType": "Linux",
  "provisioningState": "Succeeded",
  "resourceGroup": "Summit2019",
  "restartPolicy": "Always",
  "tags": {},
  "type": "Microsoft.ContainerInstance/containerGroups",
  "volumes": null
}

# 2- Check container logs
az container logs  --resource-group Summit2019 --name  hr-dev-sql01

# 3- Get container public DNS / IP
az container list --resource-group Summit2019 | grep -A3 dnsNameLabel

# 4- Connect to container using SQLCMD
clear && sqlcmd -S hr-dev-sql01.westus.azurecontainer.io -U dev_team -P '_D3v3L0pM3nt_' -Q "SET NOCOUNT ON;SELECT TOP 4 employee_id, first_name  FROM HumanResources.dbo.Employees;"
clear && sqlcmd -S hr-dev-sql01.westus.azurecontainer.io -U dev_team -P '_D3v3L0pM3nt_' -Q "SET NOCOUNT ON;SELECT TOP 4 dependent_id, first_name  FROM HumanResources.dbo.Dependents;"

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 5- Execute some queries
# 6- Report issue to DBA
# 7- Use sp_WhoIsActive on Notebook