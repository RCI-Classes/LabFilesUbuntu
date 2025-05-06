#!/bin/bash
echo '#################################'
echo 'updating lab files'
echo '#################################'

cd /home/student/labFiles
git pull

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