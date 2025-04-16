pipeline {
    agent {
        docker {
            image 'python:3.11-alpine'
            reuseNode true
        }
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
                script {
                    writeFile file: 'Dockerfile', text: '''
                    FROM python:3.11-alpine
                    WORKDIR /app
                    COPY requirements.txt . 
                    RUN pip install --no-cache-dir --user -r requirements.txt  # Fix for permissions
                    COPY . .
                    CMD ["python", "app.py"]
                    '''.stripIndent()

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
    }
    
    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Please review the logs.'
        }
    }
}
