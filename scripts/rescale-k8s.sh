#!/bin/bash

echo '#################################'
echo 'Rescaling k8s deployments'
echo '#################################'
microk8s kubectl get deployments
for dep in $(microk8s kubectl get deployments | awk '/\/1/ {print $1}' ); do 
  microk8s kubectl scale deployment $dep --replicas=1
done
echo 'Sleeping 10 seconds'
sleep 10
microk8s kubectl get deployments

echo '#################################'
echo 'Removing old kubernetes pods'
echo '#################################'
microk8s kubectl get pods
for pod in $(microk8s kubectl get pods | awk '/Terminating/ {print $1}' ); do 
  microk8s kubectl delete pod $pod --force 
done

echo '#################################'
echo 'Current kubernetes pods'
echo '#################################'
microk8s kubectl get pods

echo '#################################'
echo 'Restarting Nginx web server'
echo '#################################'
sudo systemctl daemon-reload
sudo systemctl restart nginx.service
sudo systemctl status --no-pager nginx.service

