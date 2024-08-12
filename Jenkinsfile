#!groovy

properties([disableConcurrentBuilds()])

pipeline{
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '2', artifactNumToKeepStr: '2'))
        timestamps()
    }
    stages {
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
                dir ('.') {
                    sh 'sudo docker build -t dimoon023/nginx-apache .'
                }
            }
        }
        stage("Run container") {
            steps {
                echo "========== Run containers =========="
                dir ('.') {
                    sh 'sudo docker-compose down'
                    sh 'sudo docker-compose up -d'
            
                }        
            }
        }
        stage("Pushing") {
            steps {
                echo "========== Docker Push =========="
                dir ('.'){
                    sh ' sudo docker push dimoon023/nginx-apache:latest '
                }
            }
        }
    }    
}
