#!/bin/bash

echo '#################################'
echo 'Rescaling k8s deployments'
echo '#################################'
microk8s kubectl get deployments
for dep in $(microk8s kubectl get deployments | awk '/\/1/ {print $1}' ); do 
  microk8s kubectl scale deployment $dep --replicas=1
done
sleep 10
microk8s kubectl get deployments
