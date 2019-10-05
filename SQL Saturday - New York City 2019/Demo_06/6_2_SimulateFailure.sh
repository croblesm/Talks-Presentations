#!/bin/bash

echo -e  "Setting kubectl context to Endurance\n"
kubectl config set-context --current --namespace=endurance-sql

echo -e  "--------------------------------------" 
echo -e  "          Simulating failure          " 
echo -e  "--------------------------------------\n" 
echo -e  "Start time:" `date +"%T"`
echo -e  "--------------------------------------"

# Get pods
echo -e  "\nGetting status of curent pods:"
kubectl get pods

# Delete pods
echo -e  "\nDeleting pods \ Simulating pod failure"
kubectl delete pod --all
# Setting star time for timer
start_time="$(date -u +%s)"

# Wait for pod
sleep 10

# Get pods
echo -e  "\nGetting status of curent pods:"
kubectl get pods
# Setting end time for timer
end_time="$(date -u +%s)"

# Get latest pod status
echo -e  "\nChecking SQL Server logs from latest pod:"
MyPod=`kubectl get pods | grep "mssql-plex" | awk '{ print $1}'`
kubectl logs $MyPod
elapsed="$(($end_time-$start_time))"

echo -e  "--------------------------------------\n" 
echo -e  "Stop time:" `date +"%T"`
echo -e  "Total of $elapsed seconds"
echo -e  "--------------------------------------\n"