pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nayana192003/flask-app1'
        DOCKER_CREDENTIALS = 'dockerhub-credentials'
        GIT_CREDENTIALS = 'git-pat'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git credentialsId: "${GIT_CREDENTIALS}", url: 'https://github.com/Nayana192003/flask-app1.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build -t $DOCKER_IMAGE:latest .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    bat 'docker run --rm $DOCKER_IMAGE:latest pytest'
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS}", url: 'https://index.docker.io/v1/']) {
                    bat 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    bat """
                    docker pull $DOCKER_IMAGE:latest
                    docker stop flask-app || true
                    docker rm flask-app || true
                    docker run -d --name flask-app -p 5000:5000 $DOCKER_IMAGE:latest
                    """
                }
            }
        }
    }
}
