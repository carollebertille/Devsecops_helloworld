# Deployment of hello world application
 
## Context
 ##### Deployment of hello world application through the CI/CD Pipeline with implementation of security
 
## Tools
   
- Cloud: GCP, (vm, gke, service account)
- Container Engine: Docker
- Source Code Management: Github
- Scheduling: Jenkins
- Security: Snyk, Sonarqube
- Notification: Slack
- gcloud

## Infrastructure

  We wanted to reproduce an enterprise-type infrastructure with 3 servers and GKE
  
 - A master server Jenkins scheduling build jobs, monitor the slaves
 - A build server(slave) to build our docker images, tests, and  scan  images
 - Google Kubernetes engine to deploy our web application which can be consumed of production.
 - Sonarqube server: Static Code Analysis
 - Snyk: scan docker images

## Choice and description of tools

- Terraform  infrastructure as code tool used to automate infrastructure in cloud provider. it will help to prvision 3 servers(jenkins,nodebuild and sonarqube) and Google kubernetes Engine
- Jenkins is an open-source automation server that facilitates continuous integration (CI) and continuous delivery (CD) of software projects. It enables developers to 
   automate various stages of the software development lifecycle, including building, testing, and deploying applications
- Using Docker to containerize hello world application
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
- Installer SDK Cloud:  https://cloud.google.com/sdk/docs/install
- Create Google account: https://cloud.google.com/docs/get-started 
- Create un service account on GCP: https://cloud.google.com/iam/docs/service-accounts-create
- install jenkins  https://www.jenkins.io/doc/book/installing/linux/
- install sonarqube https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/install-the-server/
- create snyk account https://snyk.io/
- Create dockerhub account: https://hub.docker.com/

##### NB: After creating a service account, you will download a .json file necessary for any application (terraform, Gcloud) connected to your account to deploy the resources and in google cloud platform, we create a project, enable the bill, link to that project and whatever we want to create, we need to enable the API(enable API for compute engine, kubernetes engine etc)
##### Using terraform to provision resource in GCP compute network, subnetwork, firewall and two compute instances
##### Automate infrastructure with terraform (Jenkins and sonarqube server, gke) the code is here  https://github.com/carolledevops/Helloworld.git
We provide service account to terraforn, it use that to authenticate to gcp and provision infrastructure
### network
![Screenshot (348)](https://github.com/carolledevops/Helloworld/assets/138341326/4e0b761d-b9fb-4f89-8d53-d7edd0005cd1)
### cluster gke
![Screenshot (346)](https://github.com/carolledevops/Helloworld/assets/138341326/f7c3df53-a58b-4d04-9f70-186976d7bce8)
### servers and one worker node
![Screenshot (368)](https://github.com/carolledevops/Helloworld/assets/138341326/18f0a8e6-8f55-48ab-9630-95ffcd80a51c)
## Connection of tools

we need to connect the tools 
- after installing the tools, we need to connect
- jenkins: ip:8080
- sonarqube: ip:9000.

jenkins to authenticate or communicate with tools, we need to integre plugins(jenkins is collection of plugin) and provide credentials of each tools.
Plugins that we need to integrate( sonarqube scanner, slack notification, docker, snyk security plugin, gke plugin, github integration, kubernetes etc) 
## manage jenkins - plugins - available plugins and integrate the plugins that we need
### Now we need to generate token
# sonarqube 
    go to  account - security - generate token
# snyk 
 we need to generate token: 
 #### account setting  
![Screenshot (344)](https://github.com/carolledevops/Helloworld/assets/138341326/71d6f99c-b543-4b2d-a05a-c0621576968e)
#### generate token
![Screenshot (345)](https://github.com/carolledevops/Helloworld/assets/138341326/fa4281a8-fbfe-4f9d-9cfe-14656d257520)

# slack( generate token)
after create your account, you provide your workspace my workspace here is devops and that workspace, create your channel mine is #develop
 on devops, you select 
#####  Settings & administration - manage app
![Screenshot (339)](https://github.com/carolledevops/Helloworld/assets/138341326/70248cc8-b125-487c-9f4a-52293be49818)
##### put the apps jenkinsci
![Screenshot (340)](https://github.com/carolledevops/Helloworld/assets/138341326/88f51941-777b-4bf9-863c-0fe5dcfcd842)
##### click on add jenkins
![Screenshot (341)](https://github.com/carolledevops/Helloworld/assets/138341326/ea13c1fe-bd2b-458c-810f-ddf364814b10)
##### select your channel
![Screenshot (342)](https://github.com/carolledevops/Helloworld/assets/138341326/75769d9f-a661-4387-8a40-ff865e23fdaf)
##### slack will provide token
![Screenshot (343)](https://github.com/carolledevops/Helloworld/assets/138341326/cab9d7c9-1267-411b-ae83-531a548e034a)


All this creadendials(token, kube/config, service account, private key)  will provide to jenkins to authenticate to sonarqube to analyse the code, github clone private repository, slack to notify the team, snyk to scan docker images, dockerhub to store docker images, gcp and gke to deploy hello world application.
provide all that credentials: go to manage plugins- manage credentials

##### Manage jenkins
![Screenshot (350)](https://github.com/carolledevops/Helloworld/assets/138341326/cc26a74c-dbd8-4da6-a30a-6c813c6e5cc7)

##### Click on credentials

![Screenshot (351)](https://github.com/carolledevops/Helloworld/assets/138341326/f78de2be-cca7-40d7-bf33-174384caa1cf)

##### add credentials

![Screenshot (352)](https://github.com/carolledevops/Helloworld/assets/138341326/d77a77f1-60e8-465e-babc-68607a9e1796)

##### All my credentials
![Screenshot (357)](https://github.com/carolledevops/Helloworld/assets/138341326/bbec4ec6-e008-4aa5-b463-84428da51a7f)

After add the credentials
we need to go in global tools configuration to set java, SonarQube Scanner and snyk
##### manage jenkins - global tools configuration - java
![Screenshot (360)](https://github.com/carolledevops/Helloworld/assets/138341326/f1ad38b6-3dc3-45ca-b537-0be14c7efb2d)

##### manage jenkins - global tools configuration - snyk
![Screenshot (358)](https://github.com/carolledevops/Helloworld/assets/138341326/ce4a3c4a-7ef9-482b-9a01-cc8501eb971f)
 
##### Configure systems
we need to go in configure systems to set slack, SonarQube server
##### manage jenkins - configur systems -sonarqube server

##### manage jenkins - configur systems - slack
![Screenshot (362)](https://github.com/carolledevops/Helloworld/assets/138341326/0d655fb7-bef4-480c-93a8-9e8020d46738)

##### Configure jenkins and github via webhook(webhook is a trigger that use to notify jenkins everytime we merge PR(Pull Request),
##### Go to github - click on your repository - settings - webhook

 ![Screenshot (363)](https://github.com/carolledevops/Helloworld/assets/138341326/d4c69177-1f65-472c-ada0-5b6423aab145)

 ##### click on it and choose add webhook
 ![Screenshot (365)](https://github.com/carolledevops/Helloworld/assets/138341326/539051a0-2796-4d3a-a9e3-40f1abeae160)

  ##### On Payload URL, put "http://ip(ip for jenkins):port/github-webhook" 
 ##### mine is 
![Screenshot (371)](https://github.com/carolledevops/Helloworld/assets/138341326/28e96d21-31cd-4120-ace7-0b97c43ce9df)

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





