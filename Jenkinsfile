pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "nayana192003/flask-app1"
        DOCKER_HUB_USERNAME = "your-dockerhub-username"  // Change this
        DOCKER_HUB_PASSWORD = "your-dockerhub-password"  // Change this
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
                    def imageName = "${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE}"
                    bat "docker build -t ${imageName}:latest ."
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    def imageName = "${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE}"
                    bat "docker run --rm ${imageName}:latest pytest tests/"
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    def imageName = "${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE}"
                    bat "docker login -u \"${DOCKER_HUB_USERNAME}\" -p \"${DOCKER_HUB_PASSWORD}\""
                    bat "docker tag ${imageName}:latest ${imageName}:latest"
                    bat "docker push ${imageName}:latest"
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
