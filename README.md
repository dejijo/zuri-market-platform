# Zuri Market Platform – DevOps Capstone Project

## 1. Project Overview

Zuri Market is a cloud-native application deployed using modern DevOps practices. The project demonstrates the implementation of containerisation, infrastructure automation, Kubernetes orchestration, continuous integration and deployment, application monitoring, and cloud infrastructure management.

The platform consists of a frontend web application and a backend API, deployed on an AWS EC2-hosted Kubernetes cluster.

The primary objective is to establish a scalable, maintainable, observable, and reliable application deployment environment using industry-standard DevOps tools and practices.

## 2. Project Architecture

The implementation follows this deployment architecture:

```text
                    Developer
                        |
                        v
                  GitHub Repository
                        |
                        v
                 CI/CD Workflow
                        |
              +---------+---------+
              |                   |
         Code Quality         Build and
          Analysis            Deployment
              |                   |
              v                   v
           SonarQube         Docker Images
                                  |
                                  v
                           Kubernetes Cluster
                            (AWS EC2 / Ubuntu)
                                  |
                         NGINX Ingress Controller
                                  |
                     +------------+------------+
                     |                         |
                     v                         v
                Frontend Service          Backend Service
                     |                         |
                     v                         v
                Frontend Pod              Backend Pod
                                               |
                                               v
                                         API Secret
                                               |
                                               v
                                      Kubernetes Secret

                  Monitoring Infrastructure
                           |
                           v
                       Prometheus
                           |
              +------------+-------------+
              |            |             |
              v            v             v
          Node Exporter  Kube State    Application
                         Metrics       Metrics
              |            |             |
              +------------+-------------+
                           |
                           v
                         Grafana
                           |
                           v
                   Monitoring Dashboards
```

*Note: The architecture illustrates the intended CI/CD and security integrations. SonarQube's actual CI execution and AWS Secrets Manager synchronisation must be verified separately.*

## 3. Technology Stack

| Area | Technology |
|---|---|
| Source code management | Git and GitHub |
| Cloud infrastructure | AWS EC2 |
| Operating system | Ubuntu Server 24.04 |
| Infrastructure as Code | Terraform |
| Containerisation | Docker |
| Container orchestration | Kubernetes |
| Kubernetes installation | kubeadm |
| Ingress management | NGINX Ingress Controller |
| Application monitoring | Prometheus |
| Monitoring visualisation | Grafana |
| Kubernetes metrics | Kube State Metrics |
| Host monitoring | Node Exporter |
| Code quality analysis | SonarQube |
| Secret management | Kubernetes Secrets / AWS Secrets Manager |
| Automation | GitHub Actions |

## 4. Application Components

The platform is separated into two application components.

### Frontend

The frontend provides the Zuri Market web interface and is deployed as a Kubernetes Deployment.

- Docker containerisation.
- Kubernetes Deployment and Service.
- NGINX-based web serving.
- External access through the Kubernetes Ingress Controller.

### Backend

The backend provides the application API.

- Node.js application.
- Docker containerisation.
- Kubernetes Deployment and Service.
- Runs on container port 5000.
- Uses environment variables for application configuration.
- Uses a Kubernetes Secret for `API_SECRET_KEY`.

The backend API includes the store information endpoint:

```text
/api/store
```

Example response:

```json
{
  "name": "Zuri Market",
  "totalProducts": 8
}
```

## 5. Containerisation

Docker is used to package the frontend and backend applications into deployable container images.

The configured Docker Hub image repositories are:

- `dejijo/zuriapp-frontend`
- `dejijo/zuriapp-backend`

The Docker Compose configuration supports local development and application testing.

The backend uses environment-based configuration, including:

- `PORT`
- `STORE_NAME`
- `API_SECRET_KEY`

Sensitive configuration values should not be committed to source control.

## 6. Cloud Infrastructure and Kubernetes Deployment

The application is deployed to an AWS EC2 Ubuntu server running a Kubernetes cluster installed using kubeadm.

The cluster hosts the Zuri Market application and monitoring infrastructure.

### Kubernetes resources

The application manifests are maintained under:

```text
kubernetes/
└── base/
    ├── namespace.yaml
    ├── backend-configmap.yaml
    ├── backend-deployment.yaml
    ├── backend-service.yaml
    ├── frontend-deployment.yaml
    ├── frontend-service.yaml
    ├── ingress.yaml
    └── kustomization.yaml
```

### Kubernetes namespace

The application runs in:

```text
zuri-market
```

### Deployment management

Kustomize is used to organise and deploy the Kubernetes resources.

Example deployment command:

```bash
kubectl apply -k kubernetes/base/
```

Check application resources:

```bash
kubectl get pods -n zuri-market
```

Check services:

```bash
kubectl get svc -n zuri-market
```

Check ingress:

```bash
kubectl get ingress -n zuri-market
```

### Application routing

The NGINX Ingress Controller routes requests as follows:

| URL path | Destination |
|---|---|
| `/` | Frontend Service |
| `/api` | Backend Service, port 5000 |

The application was verified as externally accessible using the EC2 public IP and the HTTP Ingress NodePort.

## 7. Secrets Management

The backend requires an API secret to operate securely.

A Kubernetes Secret named:

```text
zuri-backend-secret
```

is configured in the `zuri-market` namespace.

The backend Deployment references the following key:

```text
API_SECRET_KEY
```

AWS Secrets Manager is being used as the cloud-based secret-management solution.

The intended integration is to securely retrieve secrets from AWS Secrets Manager and make them available to Kubernetes workloads without storing sensitive values in GitHub.

**Security considerations:**

- Never commit API secrets, passwords or AWS credentials.
- Use IAM permissions with least privilege.
- Restrict access to Kubernetes Secrets.
- Avoid printing secret values in CI/CD logs.
- Rotate credentials periodically.

The AWS Secrets Manager-to-Kubernetes synchronisation should be verified before considering this integration complete.

## 8. Monitoring and Observability

Prometheus and Grafana are deployed in the Kubernetes cluster under the:

```text
monitoring
```

namespace.

### Prometheus

Prometheus collects infrastructure and Kubernetes metrics.

The configured monitoring components include:

- Node Exporter.
- Kube State Metrics.
- Prometheus.

The Prometheus service is accessible internally at:

```text
http://prometheus.monitoring.svc.cluster.local:9090
```

### Grafana

Grafana provides dashboards and visualisation of the metrics collected by Prometheus.

The Grafana service is available internally at:

```text
http://grafana.monitoring.svc.cluster.local:3000
```

Existing dashboards include:

- Kubernetes Kube State Metrics dashboard.
- Node Exporter Full dashboard.

### Monitoring verification

The Prometheus connectivity check was successfully completed using:

```promql
up
```

The following monitoring targets were confirmed UP:

- Prometheus.
- Node Exporter.
- Kube State Metrics.

Kubernetes workload discovery was also verified using:

```promql
kube_pod_info
```

The Zuri Market frontend and backend pods were successfully identified using:

```promql
kube_pod_info{namespace="zuri-market"}
```

This confirms that Prometheus can discover the application workloads.

Further work includes completing application-specific CPU and memory panels and validating the relevant container resource metrics.

## 9. Continuous Integration and Code Quality

GitHub Actions is used as the automation platform for the project's CI/CD implementation.

The intended workflow includes:

1. Source code checkout.
2. Dependency installation.
3. Application validation and testing.
4. Code quality analysis.
5. Docker image build.
6. Container image publication.
7. Deployment to the Kubernetes environment.

### SonarQube

SonarQube is the selected code quality and static analysis platform.

It is intended to analyse application source code and identify:

- Bugs.
- Code smells.
- Security vulnerabilities.
- Maintainability issues.
- Code quality problems.

The SonarQube CI integration must be validated by confirming that the GitHub Actions workflow executes the analysis and that a successful pipeline publishes its results to the SonarQube server.

## 10. Repository Structure

The main repository contains the infrastructure and Kubernetes deployment configuration.

```text
zuri-market-platform/
│
├── .github/
│   └── workflows/
│       └── CI/CD workflow files
│
├── kubernetes/
│   └── base/
│       ├── namespace.yaml
│       ├── backend-configmap.yaml
│       ├── backend-deployment.yaml
│       ├── backend-service.yaml
│       ├── frontend-deployment.yaml
│       ├── frontend-service.yaml
│       ├── ingress.yaml
│       └── kustomization.yaml
│
├── monitoring/
│   └── Monitoring configuration files
│
├── terraform/
│   └── Infrastructure as Code files
│
├── docker-compose.yml
├── .gitignore
└── README.md
```

The frontend and backend application source code are maintained in separate repositories:

- Frontend: `zuriapp-frontend`
- Backend: `zuriapp-backend`

Directory names may differ slightly depending on the latest repository changes.

## 11. Deployment and Verification

### Verify Kubernetes workloads

```bash
kubectl get pods -n zuri-market
```

### Verify monitoring workloads

```bash
kubectl get pods -n monitoring
```

### Verify Prometheus targets

Open the Prometheus interface and execute:

```promql
up
```

All expected monitoring targets should return a value of `1`.

### Verify application API

```bash
curl http://<EC2-PUBLIC-IP>:<INGRESS-HTTP-NODEPORT>/api/store
```

### Verify frontend

Open the following address in a web browser:

```text
http://<EC2-PUBLIC-IP>:<INGRESS-HTTP-NODEPORT>/
```

### Access Grafana securely

Grafana is exposed internally through a ClusterIP service. It can be accessed using Kubernetes port forwarding:

```bash
kubectl port-forward -n monitoring svc/grafana 3000:3000
```

Then create an SSH tunnel from your local machine:

```bash
ssh -i ~/.ssh/zuri-market-key \
-L 3000:localhost:3000 \
ubuntu@<EC2-PUBLIC-IP>
```

Open:

```text
http://localhost:3000
```

## 12. Security and Best Practices

The project follows several security principles:

- Application secrets are not intended to be stored in source control.
- Kubernetes Secrets are used for backend configuration.
- AWS IAM permissions should follow least-privilege principles.
- Grafana is accessed through an SSH tunnel rather than an unrestricted public endpoint.
- Containerised applications run using their configured container security settings.
- Infrastructure and application configuration are maintained separately.
- CI/CD credentials should be stored as protected GitHub Actions secrets.

## 13. Project Implementation Achievements

The following implementation activities have been completed and verified during deployment:

- Frontend and backend application containerisation.
- AWS EC2 Ubuntu environment provisioning.
- Kubernetes cluster deployment using kubeadm.
- Kubernetes application namespace creation.
- Frontend and backend Kubernetes Deployments.
- Kubernetes Services for application communication.
- NGINX Ingress Controller installation and routing.
- External frontend access through the EC2 public IP.
- Successful backend API response through the Ingress endpoint.
- Kubernetes Secret creation for backend API configuration.
- Prometheus deployment and successful API connectivity.
- Grafana deployment and Prometheus data source configuration.
- Successful Prometheus target health checks.
- Kubernetes pod discovery through Kube State Metrics.
- Grafana dashboard availability.

## 14. Further Improvements and Outstanding Validation

The following activities are important for completing and strengthening the project:

- Validate SonarQube analysis within the GitHub Actions CI workflow.
- Complete AWS Secrets Manager integration with Kubernetes.
- Complete application-specific CPU and memory monitoring.
- Develop a dedicated Zuri Market Grafana dashboard.
- Configure monitoring alerts for unhealthy pods and infrastructure.
- Validate automated Docker image publication and deployment.
- Review Terraform provisioning and infrastructure state.
- Document backup, recovery and disaster recovery procedures.
- Configure production-grade HTTPS and domain-based access.

## 15. Conclusion

The Zuri Market DevOps Capstone demonstrates the practical application of cloud infrastructure, containerisation, Kubernetes orchestration, continuous integration, security and observability.

The deployment establishes a working cloud-hosted application with externally accessible frontend and backend services, Kubernetes workload management, and a functioning Prometheus-Grafana monitoring stack.

The project provides a foundation for further improvements in automated delivery, infrastructure reproducibility, security integration and production-grade monitoring.

---

**Repository:** [dejijo/zuri-market-platform](https://github.com/dejijo/zuri-market-platform)

**Active development branch:** `feature/terraform-infrastructure`

**Project:** Zuri Market DevOps Capstone
