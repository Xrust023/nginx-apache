#!groovy

properties([disableConcurrentBuilds()])

pipeline{
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '2', artifactNumToKeepStr: '2'))
        timestamps()
    }
    stages {
        stage("Clean") {
            steps {
                echo "========== Clean repository =========="
                sh 'sudo rm -rf nginx-apache'
                
            }
        }
        stage("Git clone") {
            steps {
                echo "========== GitHub clone =========="
                sh 'git clone https://github.com/Xrust023/nginx-apache.git'
            }
        }
        stage("Sign in DockerHub") {
            steps {
                echo "========== Docker Sign in =========="
                withCredentials([usernamePassword(credentialsId: 'dockerhub-nginx-apache', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                }
            }
        }
    
        stage("create docker image") {
            steps {
                echo "========== Start Build =========="
                dir ('./nginx-apache') {
                    sh 'sudo docker build -t dimoon023/nginx-apache .'
                }
            }
        }
        stage("Pushing") {
            steps {
                echo "========== Docker Push =========="
                dir ('./nginx-apache'){
                    sh ' sudo docker push dimoon023/nginx-apache:latest '
                }
            }
        }
        stage("Run container") {
            steps {
                echo "========== Run containers =========="
                dir ('./nginx-apache') {
                    sh 'ssh -i xterm qwerty@51.250.46.106 && sudo rm -rf nginx-apache && sudo git clone https://github.com/Xrust023/nginx-apache.git && cd nginx-apache && sudo docker compose down && sudo docker compose up -d && exit'
            
                }        
            }
        }
    }    
}
