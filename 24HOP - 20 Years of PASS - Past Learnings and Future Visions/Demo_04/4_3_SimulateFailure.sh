#!/bin/bash
echo "--------------------------------------" 
echo "          Simulating failure          " 
echo "--------------------------------------" 
echo ""
echo "Start time:" `date +"%T"`
echo "--------------------------------------"
echo ""

# Get pods
echo "Getting status of curent pods:"
kubectl get pods
echo ""

# Delete pods
echo "Deleting pods \ Simulating pod failure"
kubectl delete pod --all
# Setting star time for timer
start_time="$(date -u +%s)"
echo ""

# Wait for pod
sleep 10

# Get pods
echo "Getting status of curent pods:"
kubectl get pods
echo ""
# Setting end time for timer
end_time="$(date -u +%s)"

# Get latest pod status
echo "Checking SQL Server logs from latest pod:"
MyPod=`kubectl get pods | grep "mssql-deployment" | awk '{ print $1}'`
kubectl logs $MyPod
echo ""
elapsed="$(($end_time-$start_time))"

echo "--------------------------------------" 
echo ""
echo "Stop time:" `date +"%T"`
echo "Total of $elapsed seconds"
echo "--------------------------------------"
echo ""