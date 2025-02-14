pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "flask-app1"
        CONTAINER_NAME = "flask-app1-container"
        PORT = "5000"
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
                    bat "docker build -t ${DOCKER_IMAGE}:latest ."
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    bat "docker run --rm ${DOCKER_IMAGE}:latest pytest tests/"
                }
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    // Stop and remove existing container if running
                    bat "docker-compose down || exit 0"
                    
                    // Start application using Docker Compose
                    bat "docker-compose up -d"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully! Flask app is running on port ${PORT}"
        }
        failure {
            echo "Pipeline failed. Check logs for errors."
        }
    }
}
