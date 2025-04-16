pipeline {
    agent {
        docker {
            image 'python:3.11-alpine'
            args '-u root'
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
                pip install --no-cache-dir -r requirements.txt
                '''
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

        stage('Deliver') {
            steps {
                echo 'Deploying...'
                sh 'echo "App deployed successfully."'
            }
        }
    }
}
