pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "calculator-app"
        CONTAINER_NAME = "calculator-container"
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'project-1', 
                url: 'https://github.com/shebwell/proj-mdp-152-155.git',
                credentialsId: 'github-credentials'  // Replace with your Jenkins credentials ID
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build with current timestamp tag
                    def customTag = "${DOCKER_IMAGE}:${env.BUILD_ID}-${new Date().format('yyyyMMdd-HHmm')}"
                    docker.build(customTag)
                    
                    // Store the image name for later stages
                    env.DOCKER_IMAGE_FULL = customTag
                }
            }
        }
        
        stage('Stop Previous Container') {
            steps {
                script {
                    // Gracefully stop and remove any existing container
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }
        
        stage('Run New Container') {
            steps {
                script {
                    docker.run(
                        image: env.DOCKER_IMAGE_FULL,
                        name: CONTAINER_NAME,
                        ports: ['8080:8080'],
                        detach: true,
                        network: 'bridge'
                    )
                }
            }
        }
        
        stage('Verify Deployment') {
            steps {
                script {
                    // Wait for application to start
                    sleep(time: 10, unit: 'SECONDS')
                    
                    // Simple health check
                    sh "curl -I http://localhost:8080 || true"
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completed - cleaning up workspace'
            cleanWs()
        }
        failure {
            echo 'Pipeline failed - sending notification'
            // Add notification logic here
        }
    }
}
