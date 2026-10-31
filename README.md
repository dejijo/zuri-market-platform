# Zuri Market DevOps Capstone

## Project Overview

# Zuri Market DevOps Capstone

## Project Overview

This project implements DevOps practices for the Zuri Market frontend and backend applications. It demonstrates infrastructure provisioning, containerisation, CI/CD automation, security analysis, Kubernetes infrastructure and monitoring.

The project is organised into three repositories:

- `zuriapp-frontend` – React frontend application.
- `zuriapp-backend` – Backend application.
- `zuri-market-platform` – Infrastructure, Kubernetes manifests, monitoring, automation and project documentation.

## Objectives

- Containerise the frontend and backend applications using Docker.
- Automate testing and builds using GitHub Actions.
- Provision AWS infrastructure using Terraform.
- Publish Docker images to Docker Hub.
- Use SonarQube Cloud for code quality analysis.
- Manage Kubernetes infrastructure using kubeadm.
- Monitor infrastructure using Prometheus and Grafana.
- Automate application health checks using Bash and cron.
- Apply security and infrastructure best practices.

## Technology Stack

| Area | Technology |
|---|---|
| Frontend | React, Vite |
| Containerisation | Docker |
| CI/CD | GitHub Actions |
| Infrastructure as Code | Terraform |
| Cloud | AWS EC2 |
| Container Registry | Docker Hub |
| Code Quality | SonarQube Cloud |
| Orchestration | Kubernetes (kubeadm) |
| Monitoring | Prometheus, Grafana |
| Metrics Collection | Node Exporter, kube-state-metrics |
| Automation | Bash, cron |

## Project Structure

```text
zuri-market-platform/
├── .github/
│   └── workflows/
├── docs/
├── kubernetes/
├── monitoring/
├── scripts/
├── terraform/
├── compose.yaml
├── .gitignore
└── README.md
```

The frontend and backend applications are maintained in their own repositories.

## CI/CD Pipeline

GitHub Actions is used to automate application workflows.

The implemented workflows cover:

- Frontend continuous integration.
- Backend continuous integration.
- Docker image building and publishing.
- Docker Hub authentication using GitHub repository secrets.
- SonarQube Cloud analysis.

Docker Hub images:

- Frontend: https://hub.docker.com/r/dejijo/zuriapp-frontend
- Backend: https://hub.docker.com/r/dejijo/zuriapp-backend

Images are published using the `latest` tag and commit-specific tags where configured.

## Code Quality and Security

SonarQube Cloud is used to analyse application code and report code quality information.

Project dashboard: https://sonarcloud.io/

The analysis is part of the project's code quality workflow. Quality Gate enforcement and coverage reporting should be verified separately before being described as enforced pipeline requirements.

## Infrastructure and Kubernetes

The infrastructure work uses Terraform and AWS EC2.

A self-managed Kubernetes cluster was configured using kubeadm rather than Amazon EKS.

The cluster provides the infrastructure for running Kubernetes workloads and monitoring components.

**Current deployment distinction:** The monitoring stack is running in the EC2 Kubernetes cluster. The Zuri Market frontend and backend have not yet been deployed into that cluster.

## Monitoring

Prometheus and Grafana are deployed in the Kubernetes `monitoring` namespace.

The monitoring stack includes:

- **Prometheus:** Collects and stores metrics.
- **Grafana:** Provides dashboards and visualisation.
- **Node Exporter:** Exposes host-level metrics.
- **kube-state-metrics:** Exposes Kubernetes object and resource-state metrics.

Grafana uses Prometheus as its data source.

Prometheus service address inside the cluster:

```text
http://prometheus.monitoring.svc.cluster.local:9090
```

### Local access

The following local endpoints are used when the relevant services, port-forwards and SSH tunnels are running:

| Service | Local URL |
|---|---|
| Frontend | http://localhost:8081 |
| Backend | http://localhost:5001 |
| Grafana | http://localhost:3001 |
| Prometheus | http://localhost:9090 |

Grafana and Prometheus access depends on Kubernetes port-forwarding and SSH tunnels. These localhost addresses are not public deployment URLs.

## Useful Kubernetes Commands

Check cluster nodes:

```bash
kubectl get nodes
```

List pods across namespaces:

```bash
kubectl get pods -A
```

List monitoring resources:

```bash
kubectl get all -n monitoring
```

Check deployments:

```bash
kubectl get deployments -A
```

Check services:

```bash
kubectl get svc -A
```

View Prometheus logs:

```bash
kubectl logs -n monitoring deployment/prometheus
```

View Grafana logs:

```bash
kubectl logs -n monitoring deployment/grafana
```

## Application Access

The frontend and backend are developed and run separately from the EC2 Kubernetes monitoring cluster.

- Frontend: `http://localhost:8081`
- Backend: `http://localhost:5001`

These endpoints depend on the applications being started locally and are intended for local development and testing.

## Automation

The project includes a `scripts/` directory for operational automation.

Bash and cron are intended to support scheduled health checks and other routine operational tasks. The final scheduled execution and evidence should be verified before marking this objective fully complete.

## Current Project Status

### Completed work

- [x] Repository structure established.
- [x] Frontend and backend CI workflows implemented.
- [x] Docker images built and published to Docker Hub.
- [x] SonarQube Cloud analysis completed.
- [x] AWS EC2 Kubernetes infrastructure configured.
- [x] Prometheus deployed.
- [x] Grafana deployed and connected to Prometheus.
- [x] Node Exporter deployed.
- [x] kube-state-metrics deployed.
- [x] Node Exporter Full dashboard imported into Grafana.

## Conclusion

The Zuri Market DevOps Capstone demonstrates the use of modern DevOps tools and practices across application development, CI/CD, infrastructure provisioning, containerisation, code quality analysis and infrastructure monitoring.

The project establishes a foundation for completing automated application deployment and end-to-end monitoring on Kubernetes.
