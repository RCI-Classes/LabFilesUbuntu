#!/bin/bash
microk8s kubectl get pods
for pod in $(microk8s kubectl get pods | awk '/Terminating/ {print $1}' ); do 
  microk8s kubectl delete pod $pod --force 
  
done
microk8s kubectl get pods

cd /home/student/labFiles
git pull
