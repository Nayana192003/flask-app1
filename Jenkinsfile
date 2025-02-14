pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "nayana192003/flask-app1"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git credentialsId: 'git-pat', url: 'https://github.com/Nayana192003/flask-app1.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "nayana192003/${DOCKER_IMAGE}"
                    bat "docker build -t ${imageName}:latest ."
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    def imageName = "nayana192003/${DOCKER_IMAGE}"
                    bat "docker run --rm ${imageName}:latest pytest tests/"
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    def imageName = "nayana192003/${DOCKER_IMAGE}"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                        bat "docker tag ${imageName}:latest ${imageName}:latest"
                        bat "docker push ${imageName}:latest"
                    }
                }
            }
        }

        stage('Deploy Application') {
            steps {
                bat "docker-compose down"
                bat "docker-compose up -d"
            }
        }
    }
}
