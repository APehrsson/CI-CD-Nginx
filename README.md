# Kubernetes Nginx Deployment with CI/CD

This project automates the deployment of an Nginx container to a Kubernetes cluster using GitHub Actions and Ansible. The workflow builds a Docker image, pushes it to GitHub Container Registry (GHCR), and deploys it to Kubernetes using an Ansible playbook for rolling updates.

## Project Structure

- **workflow.yml**: GitHub Actions workflow that builds and pushes an Nginx Docker image to GHCR.
- **nginx-deployment.yml**: Kubernetes deployment manifest for running Nginx in a cluster.
- **deploy-playbook.yml**: Ansible playbook for performing rolling updates on the Nginx deployment.
- **index.html**: A simple HTML file served by Nginx.
- **Dockerfile**: Defines the Nginx image with the custom index.html page.

## Prerequisites

- A Kubernetes cluster with `kubectl` configured.
- An Ansible installation with `kubernetes.core` collection.
- A GitHub repository with write access to GHCR.

## Setup & Usage

### 1. Build and Push the Image

The GitHub Actions workflow triggers on new tags. To build and push a new image:

```sh
# Tag the repository and push
git tag v1.0.0
git push origin v1.0.0
```

This runs the workflow, which:
1. Extracts the tag version.
2. Builds a Docker image with `nginx:latest`.
3. Pushes the image to GHCR.

### 2. Deploy to Kubernetes

Apply the Kubernetes deployment:

```sh
kubectl apply -f nginx-deployment.yml
```

### 3. Perform a Rolling Update

Run the Ansible playbook to update the deployment:

```sh
ansible-playbook deploy-playbook.yml
```

This playbook:
1. Checks the current image version.
2. Updates the deployment if a new image is available.
3. Monitors rollout status.
4. Rolls back if deployment fails.

### 4. Verify Deployment

Check the status of the deployment:

```sh
kubectl get deployments
kubectl get pods
```

Test the service:

```sh
curl http://<NODE_IP>:30080
```

## Rollback

If the deployment fails, the playbook automatically rolls back to the previous image version.


