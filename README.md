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

















