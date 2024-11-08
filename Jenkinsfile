pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "adhibanganesh/docker-ci-cd"
        REGISTRY_CREDENTIALS = "dockerhub-creds"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/AdhibanGanesh/endsem_lab.git'
            }
        }
        
        stage('Build') {
            steps {
                script {
                    // Build with specific profile (staging or production)
                    sh "mvn clean package -P${env.BRANCH_NAME}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${env.BRANCH_NAME} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push Docker image to DockerHub
                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        sh "docker push ${DOCKER_IMAGE}:${env.BRANCH_NAME}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy to different servers based on the branch
                    if (env.BRANCH_NAME == 'staging') {
                        sh "ssh user@${env.deploy.server} 'docker pull ${DOCKER_IMAGE}:${env.BRANCH_NAME} && docker run -d -p 8081:8080 ${DOCKER_IMAGE}:${env.BRANCH_NAME}'"
                    } else if (env.BRANCH_NAME == 'master') {
                        sh "ssh user@${env.deploy.server} 'docker pull ${DOCKER_IMAGE}:${env.BRANCH_NAME} && docker run -d -p 8081:8080 ${DOCKER_IMAGE}:${env.BRANCH_NAME}'"
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Example test stage
                    sh 'mvn test'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
