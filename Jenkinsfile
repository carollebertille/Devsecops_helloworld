pipeline {
     agent any 
    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
        timeout (time: 60, unit: 'MINUTES')
        timestamps()
      }
    environment {
       DOCKERHUB_ID = "edennolan2021"
       IMAGE_NAME = "helloworld"
       DOCKERHUB = credentials('dockerhub')
     }

    stages {

        stage('Setup parameters') {
            steps {
                script {
                    properties([
                        parameters([
                            choice(
                                choices: ['DEV', 'QA', 'PREPROD', 'PROD'], 
                                name: 'ENVIRONMENT'
                            ),
                        string(
                             defaultValue: '50',
                             name: 'hello_tag',
                             description: '''Please enter hello image tag to be used''',
                            ),

                        ]),

                    ])
                }
            }
        }
     
      stage('SonarQube analysis') {
         when{  
            expression {
              env.ENVIRONMENT == 'DEV' }
              }
            agent {
                docker {
                  image 'sonarsource/sonar-scanner-cli:4.8.0'
                }
               }
               environment {
        CI = 'true'
        scannerHome='/opt/sonar-scanner'
       }   
            steps{
                withSonarQubeEnv('Sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
         }
     stage('login to docker repository') {
       when{  
            expression {
              env.ENVIRONMENT == 'DEV' }
              }
          steps {
             script {
               sh 'echo $DOCKERHUB | docker login -u $DOCKERHUB_ID --password-stdin'
             }
          }
      }

      stage("Build docker images") {
        when{  
            expression {
              env.ENVIRONMENT == 'DEV' }
              }
        steps {
            script {
               sh ' docker build -t ${DOCKERHUB_ID}/$IMAGE_NAME:${BUILD-NUMBER} . '
            }
        }
     }
     stage("scan docker images") {
        when{  
            expression {
              env.ENVIRONMENT == 'DEV' }
              }
      environment{
          SNYK_TOKEN = credentials('SNYK')
       }
       steps{
        script {
         sh '''
          echo "starting image scan ..."
          SCAN_RESULT=$(docker run --rm -e $SNYK_TOKEN -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/app snyk/snyk:docker snyk test --docker ${DOCKERHUB_ID}/$IMAGE_NAME:$IMAGE_TAG --json || if [[$? -gt "1"]]; then echo -e "warning; you must see scan result \n"; false; elif [[$? -eq "0"]]; then echo "pass: Nothing to do"; elif [[$? -eq "1"]]; then echo "warning" passing with something to do; else false; fi)
          echo"scan ended"
         '''
        }
       }
    }
    stage('push docker image') {
      when{  
            expression {
              env.ENVIRONMENT == 'DEV' }
              }
          steps {
             script {
               sh 'docker push $DOCKERHUB_ID/$IMAGE_NAME:${BUILD-NUMBER} '
             }
          }
     }
     stage('QA: pull images ') {
           when{  
            expression {
              env.ENVIRONMENT == 'QA' }
              }
            steps {
                script {
                    // Log in to Docker Hub
                    sh '''
                        docker pull $DOCKERHUB_ID/$IMAGE_NAME:$hello_tag 
                       
                    '''
                }
            }
        }


        stage('QA: tag  images ') {
           when{  
            expression {
              env.ENVIRONMENT == 'QA' }
              }
            steps {
                script {
                    // Log in to Docker Hub
                    sh '''
                        docker tag  $DOCKERHUB_ID/$IMAGE_NAME:$hello_tag  $DOCKERHUB_ID/$IMAGE_NAME:qa-$hello_tag  
                    '''
                }
            }
        }
        stage('QA: pull images ') {
           when{  
            expression {
              env.ENVIRONMENT == 'QA' }
              }
            steps {
                script {
                    // Log in to Docker Hub
                    sh '''
                        docker pull $DOCKERHUB_ID/$IMAGE_NAME:$hello_tag 
                       
                    '''
                }
            }
        }
        stage('PREPROD: tag  images ') {
           when{  
            expression {
              env.ENVIRONMENT == 'PREPROD' }
              }
            steps {
                script {
                    // Log in to Docker Hub
                    sh '''
                        docker tag  $DOCKERHUB_ID/$IMAGE_NAME:$hello_tag  $DOCKERHUB_ID/$IMAGE_NAME:preprod-$hello_tag  
                    '''
                }
            }
        }
        stage('QA: pull images ') {
           when{  
            expression {
              env.ENVIRONMENT == 'QA' }
              }
            steps {
                script {
                    // Log in to Docker Hub
                    sh '''
                        docker pull $DOCKERHUB_ID/$IMAGE_NAME:$hello_tag 
                       
                    '''
                }
            }
        }


        stage('PROD: tag  images ') {
           when{  
            expression {
              env.ENVIRONMENT == 'PROD' }
              }
            steps {
                script {
                    // Log in to Docker Hub
                    sh '''
                        docker tag  $DOCKERHUB_ID/$IMAGE_NAME:$hello_tag  $DOCKERHUB_ID/$IMAGE_NAME:prod-$hello_tag  
                    '''
                }
            }
        }
    stage('Update DEV  charts') {
      when{  
          expression {
            env.ENVIRONMENT == 'DEV' }
          
            }
      
            steps {
                script {

                    sh '''
rm -rf S4-projects-charts || true
git clone git@github.com:carollebertille/Devsecops_helloworld.git
cd Devsecops_helloworld
ls
pwd
cat << EOF >dev-values.yaml
image:
  repository: edennolan2021/helloworld
  tag: ${BUILD_NUMBER}
EOF
git config --global user.name "carollebertille"
git config --global user.email "carolle.matchum@yahoo.com"

git add -A 
git commit -m "change from jenkins CI"
git push 
                    '''
                }
            }
        }

    stage('Update QA  charts') {
      when{  
          expression {
            env.ENVIRONMENT == 'QA' }
          
            }
      
            steps {
                script {

                    sh '''
rm -rf S4-projects-charts || true
git clone git@github.com:carollebertille/Devsecops_helloworld.git
cd Devsecops_helloworld
ls
pwd
cat << EOF >qa-values.yaml
image:
  repository: edennolan2021/helloworld
  tag: qa-$hello_tag
EOF
git config --global user.name "carollebertille"
git config --global user.email "carolle.matchum@yahoo.com"

git add -A 
git commit -m "change from jenkins CI"
git push 
                    '''
                }
            }
        }
	     
 stage('Update PREPROD  charts') {
      when{  
          expression {
            env.ENVIRONMENT == 'PREPROD' }
          
            }
      
            steps {
                script {

                    sh '''
rm -rf S4-projects-charts || true
git clone git@github.com:carollebertille/Devsecops_helloworld.git
cd Devsecops_helloworld
ls
pwd
cat << EOF >preprod-values.yaml
image:
  repository: edennolan2021/helloworld
  tag: preprod-$hello_tag
EOF
git config --global user.name "carollebertille"
git config --global user.email "carolle.matchum@yahoo.com"

git add -A 
git commit -m "change from jenkins CI"
git push 
                    '''
                }
            }
        }
 stage('Update PROD  charts') {
      when{  
          expression {
            env.ENVIRONMENT == 'PROD' }
          
            }
      
            steps {
                script {

                    sh '''
rm -rf S4-projects-charts || true
git clone git@github.com:carollebertille/Devsecops_helloworld.git
cd Devsecops_helloworld
ls
pwd
cat << EOF >prod-values.yaml
image:
  repository: edennolan2021/helloworld
  tag: prod-$hello_tag
EOF
git config --global user.name "carollebertille"
git config --global user.email "carolle.matchum@yahoo.com"

git add -A 
git commit -m "change from jenkins CI"
git push 
                    '''
                }
            }
        }
 }
}
   
 
