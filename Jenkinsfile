pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git branch: 'project-3', url: 'https://github.com/shebwell/proj-mdp-152-155.git'
      }
    }

    stage('Docker Build & Push') {
      steps {
        sh 'docker build -t shebwell/myapp:latest .'
        sh 'echo "$DOCKER_PASSWORD" | docker login -u "shebwell" --password-stdin'
        sh 'docker push shebwell/myapp:latest'
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl apply -f k8s/service.yaml'
      }
    }
  }
}
