# BACKEND - Pass Summit 2019 DEMO for DevOps SQL Server CI/CD

## Prerequisites

* Visual Studio Code

* .NET Core SDK ([Link](https://dotnet.microsoft.com/download/thank-you/dotnet-sdk-3.0.100-windows-x64-installer))


## How to restore the project:

    dotnet restore

## How to run the project:

    dotnet run
    
## How to build the container with Docker:

    docker build -t demo-back-app:latest .
    
## How to build the container with Docker:

    docker run --rm -d -p 5000:80 --name demo_back --network=net_demo_sql_server demo-back-app:latest