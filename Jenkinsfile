pipeline {
    agent {
        docker {
            image 'python:3.11-alpine'  // Use the official Python image
            args '-u root'  // Use root user to avoid permission issues
        }
    }

    environment {
        // Docker Hub credentials and image name
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')  // Docker Hub credentials in Jenkins
        IMAGE_NAME = "bpkk/numpy-app"  // Image name in Docker Hub
    }

    triggers {
        pollSCM('* * * * *')  // Poll the SCM repository every minute (adjust as needed)
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Checkout the code from your GitHub repository
            }
        }

        stage('Build') {
            steps {
                echo 'Building..'
                sh '''
                pip install --no-cache-dir -r requirements.txt
                '''
                script {
                    // Build the Docker image
                    sh """
                    docker login -u ${DOCKER_CREDENTIALS.username} -p ${DOCKER_CREDENTIALS.password}
                    docker build -t ${IMAGE_NAME}:latest .
                    """
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Testing..'
                sh '''
                python test.py
                python test.py --name=Brad
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                script {
                    // Push the Docker image to Docker Hub
                    sh """
                    docker push ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Deliver') {
            steps {
                echo 'Deploying...'
                sh 'echo "App deployed successfully."'
            }
        }
    }

    post {
        always {
            // Clean up Docker resources after the pipeline
            sh 'docker system prune -af'
        }
    }
}
