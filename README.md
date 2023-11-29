# Deployment of hello world application
 
## Context
 ##### Deployment of hello world application through the CI/CD Pipeline with implementation of security
 
## Tools
   
- Cloud: AWS
- Container Engine: Docker
- Source Code Management: Github
- Scheduling: Jenkins
- Security: Snyk, Sonarqube
- Notification: Slack


## Infrastructure

  We wanted to reproduce an enterprise-type infrastructure with 3 servers and EKS
  
 - A master server Jenkins scheduling build jobs, monitor the agent
 - A build server(slave) to build our docker images, tests, and  scan  images
 - AWS Kubernetes engine to deploy our web application which can be consumed of production.
 - Sonarqube server: Static Code Analysis
 - Snyk: scan docker images

## Choice and description of tools

- Terraform  infrastructure as code tool used to automate infrastructure in cloud provider. it will help to prvision 3 servers(jenkins, Agent and sonarqube server) and EKS
- Jenkins is an open-source automation server that facilitates continuous integration (CI) and continuous delivery (CD) of software projects. It enables developers to 
   automate various stages of the software development lifecycle, including building, testing, and deploying applications
- Using Docker to build image and containerize hello world application
- Dockerhub: registry to store docker imges
- Snyk is a popular developer-first security platform that helps developers find and fix vulnerabilities in their open-source dependencies and container images.Here are 
  some key
    1. Dependency scanning
    2. Container image scanning
    3. Fix suggestions and remediation
- GKE used to deploy hello world application
- Slack collaborative platform used to notify us of the state of the pipeline
- SonarQube is an open-source platform developed by SonarSource for continuous inspection of code quality. SonarQube does static code analysis, which provides a detailed 
  report of bugs, code smells, vulnerabilities, code duplications.

## Installation tools
- Install Terraform on Windows or linux:  https://www.terraform.io/downloads.html
- install jenkins  https://www.jenkins.io/doc/book/installing/linux/
- install sonarqube https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/install-the-server/
- create snyk account https://snyk.io/
- Create dockerhub account: https://hub.docker.com/

##### Automate infrastructure with terraform (Jenkins, Agent and sonarqube server, EKS) the code is here  https://github.com/carolledevops/Helloworld.git



## Workflow
CI/CD pipeleine, we have 4 environments(dev, qa, prepro,pro) and each environment have the pipeline 
- In dev environment, we have multipipeline, I will use one pipeline
![Screenshot (353)](https://github.com/carolledevops/Helloworld/assets/138341326/135317d6-57d2-4b5a-a134-1c9d7af84761)
### Explication
##### Development pipeline (when pull request merged to develop branch)

1.  A pull request is merged in the develop branch
2.  jenkins notice the change on helloworld repository via preset webhook then clone the repository.
3.  Jenkins send build start notification on slack
4,5 jenkins use the docker agent to launch sonarqube scannercli container to analyse the code and the scan result sent back to jenkins
6.  Jenkins sent the build report to sonarqube to be compared with quality gate
7.  sonarqube sent the code analysis result back to jenkins
8.  jenkins read dockerfile to build, scan and push docker images to dockerhub
9.  jenkins deploy helloworld application in kubernetes
10. kubernetes pull docker images from dockerhub

##### QA pipeline

![Screenshot (354)](https://github.com/carolledevops/Helloworld/assets/138341326/8856a655-93d8-4882-8a86-693eb9edbca3)

pipeline for qa will capable to take as input  docker image and perform differents test(load test, functional test etc)

##### Production pipeline 

![Screenshot (356)](https://github.com/carolledevops/Helloworld/assets/138341326/7717f3b5-320c-49ed-a1ba-402097ce1c24)

 - After validation by the whole team, the Ops manager can make the merger request in order to pass the modification on the main branch.
 - Deployment in production environment will then be activated and a notification is sent to slack
 - Once the application is deployed Kubernetes cluster, a end user will be able to connect and consume the application.

Helloworld application
![Screenshot (366)](https://github.com/carolledevops/Helloworld/assets/138341326/87df55b1-5882-4ab0-bf8e-6f2a37952488)





list of development tasks that would be useful for enhancing a codebase or solution:

##### Unit testing imlement unit test to verify the correctness 
##### Monitoring tools can help you track the health, performance, and availability of your systems.Example Datadog, promethus and grafana
##### Argo CD is an open-source continuous delivery (CD) tool designed to automate and manage the deployment of applications to Kubernetes clusters. It have many features
- Rollbacks and Versioning
- Multi-Environment Deployments
- Application Sync
- Integration with CI/CD
- RBAC and Access Control
- Web UI and CLI
##### PagerDuty incident management and response platform. It provides real-time alerts, on-call scheduling, and incident response coordination.  some features 
Integration with Monitoring and Communication Tools
- On-Call Schedules
- Incident Response Workflows
##### Helm package manager for Kubernetes that simplifies the deployment and management of applications and services.
Helm simplifies the management of Kubernetes deployments by providing a consistent and reusable approach. It enables developers and operators to package and distribute applications as charts, facilitating consistent and scalable deployments across different environments.

##### github actions: GitHub Actions provides an intuitive and user-friendly interface, making it easy to get started with CI/CD without the need for additional infrastructure or configuration.

![Screenshot (370)](https://github.com/carolledevops/Helloworld/assets/138341326/4244d06c-5586-475a-8e76-424763e26a4c)





