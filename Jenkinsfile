pipeline {
  agent any

  environment {
    IMAGE = "meera786/ultimate-devops-project"
  }

  stages {

    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE:latest .'
      }
    }

    stage('Run CI Checks') {
      steps {
        sh '''
          docker run --rm $IMAGE:latest \
          sh -c "npx markdownlint '**/*.md' || true"
        '''
      }
    }

    stage('Push Image to Docker Hub') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
            docker push $IMAGE:latest
          '''
        }
      }
    }
  }
}
