pipeline {
    agent {
        docker {
            image 'python:3.11-alpine'
            args '-u root'  // So pip installs won't hit permission errors
        }
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh '''
                cd myapp
                pip install --no-cache-dir -r requirements.txt
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Testing..'
                sh '''
                cd myapp
                python hello.py
                python hello.py --name=Brad
                '''
            }
        }

        stage('Deliver') {
            steps {
                echo 'Deploying...'
                sh 'echo "App deployed successfully."'
            }
        }
    }
}
