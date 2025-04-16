pipeline {
    agent {
        docker {
            image 'python:3.11-alpine'
            reuseNode true
        }
    }

    environment {
        DOCKER_IMAGE = "bpkk/numpy-app:latest"
    }

    stages {
        stage('Build') {
            steps {
                sh '''
                    echo "Starting build..."
                    python --version
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    echo "Build complete."
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    echo "Running tests..."
                    python test.py 
                    echo "Tests passed."
                '''
            }
        }

        stage('Deliver') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo "Building Docker image..."
                        docker build -t ${DOCKER_IMAGE} .

                        echo "Logging in to Docker Hub..."
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

                        echo "Pushing image to Docker Hub..."
                        docker push ${DOCKER_IMAGE}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully. Docker image delivered.'
        }
        failure {
            echo '❌ Pipeline failed. Check the logs for more info.'
        }
    }
}
