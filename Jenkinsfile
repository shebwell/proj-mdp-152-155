pipeline {
    agent any

    environment {
        DOCKER_IMAGE     = "calculator-app"
        CONTAINER_NAME   = "calculator-container"
        HOST_PORT        = "8081"  // Updated host port
        CONTAINER_PORT   = "8080"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'project-1', 
                    url: 'https://github.com/shebwell/proj-mdp-152-155.git',
                    credentialsId: 'github-credentials' // Replace with your actual credentials ID
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def customTag = "${DOCKER_IMAGE}:${env.BUILD_ID}-${new Date().format('yyyyMMdd-HHmm')}"
                    docker.build(customTag)
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
                    // Run container mapping updated host port
                    sh """
                        docker run -d --name ${CONTAINER_NAME} \
                        -p ${HOST_PORT}:${CONTAINER_PORT} \
                        --network bridge \
                        ${env.DOCKER_IMAGE_FULL}
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    sleep(time: 10, unit: 'SECONDS')
                    sh "curl -I http://localhost:${HOST_PORT} || true"
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
