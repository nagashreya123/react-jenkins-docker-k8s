pipeline {
    agent any

    environment {
        // Set your Docker Hub credentials here (make sure to add them in Jenkins credentials)
        DOCKER_HUB_REPO = 'nagashreya2005/react-app'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone your GitHub repository
                git branch: 'main', url: 'https://github.com/nagashreya123/react-jenkins-docker-k8s.git'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                // Install dependencies using npm
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                // Run tests (optional, make sure your React project has tests configured)
                sh 'npm test'
            }
        }

        stage('Build React App') {
            steps {
                // Build the React application
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                sh "docker build -t ${DOCKER_HUB_REPO}:latest ."
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                // Push the Docker image to Docker Hub
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${DOCKER_HUB_REPO}:latest"
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                // Pull the latest image and deploy using docker-compose
                sh 'docker-compose down'
                sh 'docker-compose pull'
                sh 'docker-compose up -d'
            }
        }
    }

    post {
        always {
            // Clean up Docker images to save space
            sh 'docker image prune -f'
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed. Please check the logs.'
        }
    }
}
