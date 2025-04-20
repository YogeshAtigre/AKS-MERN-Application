To deploy the [Sample MERN with Microservices](https://github.com/UnpredictablePrashant/SampleMERNwithMicroservices) application on **Azure Kubernetes Service (AKS)**, follow this structured step-by-step guide. Ensure each step is documented with relevant screenshots and pushed to a GitHub repository for clarity and traceability.

---

## 🧱 Prerequisites
- Azure CLI
- Docker
- kubectl
- Azure Container Registry (ACR)
- AKS Cluster

---

---

### 🔧 **Step 1: Clone the Repository**
```bash
git clone https://github.com/UnpredictablePrashant/SampleMERNwithMicroservices
cd SampleMERNwithMicroservices
```

---

### ⚙️ **Step 2: Prepare Dockerfiles for Microservices**

Inside both `Dockerfiles/helloService.Dockerfile` and `Dockerfiles/profileService.Dockerfile`, create a `Dockerfile`:
```Dockerfile
# Sample Dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3001
CMD ["node", "index.js"]
```
Repeat and update the port as per service (`3001` for helloService, `3002` for profileService).

Also, create a `Dockerfile` for the frontend in `frontend/`.

---

### 🐳 **Step 3: Build and Push Docker Images**

Login to Azure Container Registry (ACR) or Docker Hub:
```bash
az acr login --name <ACR_NAME>
```

Tag and push your images:
```bash
docker build -t <acr-name>.azurecr.io/hello-service:latest -f Dockerfiles/helloService.Dockerfile .
docker push <acr-name>.azurecr.io/hello-service:latest

docker build -t <acr-name>.azurecr.io/profile-service:latest -f Dockerfiles/profileService.Dockerfile .
docker push <acr-name>.azurecr.io/profile-service:latest

docker build -t <acr-name>.azurecr.io/frontend:latest -f Dockerfiles/frontend.Dockerfile .
docker push <acr-name>.azurecr.io/frontend:latest
```
Repeat for profileService and frontend.

---

### ☸️ **Step 4: Create AKS Cluster**
```bash
az aks create --resource-group <resource-group> --name <aks-cluster-name> --node-count 1 --enable-addons monitoring --generate-ssh-keys
az aks get-credentials --resource-group <resource-group> --name <aks-cluster-name>
```

---

### 📁 **Step 5: Write Kubernetes Manifests**

Create deployment and service YAML files:
- `hello-deployment.yaml`
- `profile-deployment.yaml`
- `frontend-deployment.yaml`
- `hello-service.yaml`
- `profile-service.yaml`
- `frontend-service.yaml`

Each should include `Deployment` and `Service` resources exposing ports and referencing the ACR images.

---

### 🚀 **Step 6: Deploy to AKS**
```bash
kubectl apply -f k8s/hello-service.yaml
kubectl apply -f k8s/profile-service.yaml
kubectl apply -f k8s/frontend-service.yaml
kubectl apply -f k8s/hello-deployment.yaml
kubectl apply -f k8s/profile-deployment.yaml
kubectl apply -f k8s/frontend-deployment.yaml
```

---

### 🌐 **Step 7: Expose the Frontend**
Use a `LoadBalancer` service in `frontend-service.yaml`:
```yaml
type: LoadBalancer
```
Fetch external IP:
```bash
kubectl get service frontend-service
```

---

### 📷 **Step 8: Testing**
🌐 Access the Application : 
- Use the EXTERNAL-IP from the LoadBalancer service to access the frontend in your browser.
To check AKS cluster : 
- `kubectl get pods` and `get svc`
---

### 📁 **Step 9: Push All Changes to GitHub**
```bash
git add .
git commit -m "Added AKS deployment steps with screenshots"
git push origin main
```

---