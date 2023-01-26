#!/bin/bash

# Update system
sudo apt-get update

# Install snapd
sudo apt-get install snapd -y

# Install microk8s
sudo snap install microk8s --classic

# Enable required microk8s plugins
microk8s.enable dns dashboard registry portainer

# Wait for cluster to start
sleep 10

# Get cluster IP
IP_ADDRESS=$(microk8s.config | grep "server:" | awk '{print $2}')

# Print cluster information
echo "Cluster IP: $IP_ADDRESS"
echo "Dashboard: http://$IP_ADDRESS:8080/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/"

# Create a join token
JOIN_TOKEN=$(microk8s.add-node | grep "Join" | awk '{print $2}')

# Print join token
echo "Join Token: $JOIN_TOKEN"
