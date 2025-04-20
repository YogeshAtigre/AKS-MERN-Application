# 🚀 Deploying Sample MERN with Microservices on Azure Kubernetes Service (AKS)

This guide outlines the end-to-end deployment of the Sample MERN Microservices app on AKS.

## 🧱 Prerequisites
- Azure CLI
- Docker
- kubectl
- Azure Container Registry (ACR)
- AKS Cluster

## 📦 Docker Build & Push

```bash
# Login to ACR
az acr login --name <acr-name>

# Build and push each image
docker build -t <acr-name>.azurecr.io/hello-service:latest -f Dockerfiles/helloService.Dockerfile .
docker push <acr-name>.azurecr.io/hello-service:latest

docker build -t <acr-name>.azurecr.io/profile-service:latest -f Dockerfiles/profileService.Dockerfile .
docker push <acr-name>.azurecr.io/profile-service:latest

docker build -t <acr-name>.azurecr.io/frontend:latest -f Dockerfiles/frontend.Dockerfile .
docker push <acr-name>.azurecr.io/frontend:latest
