pipeline {
  agent any
  stages {
    stage('Prepare') {
      post {
        success {
          echo 'Successfully Cloned Repository'
        }

        failure {
          error 'This pipeline stops here...'
        }

      }
      steps {
        echo 'Clonning Repository'
        git(url: 'https://github.com/simscom/testProject.git', branch: 'master', credentialsId: 'testProject2')
      }
    }

    stage('Bulid Gradle') {
      post {
        failure {
          error 'This pipeline stops here...'
        }

      }
      steps {
        echo 'Bulid Gradle'
        dir(path: '.') {
          sh 'chmod +x gradlew'
          sh 'gradle wrap'
          sh './gradlew clean build'
        }

      }
    }

    stage('Bulid Test') {
      post {
        failure {
          error 'This pipeline stops here...'
        }

      }
      steps {
        echo 'Bulid Test'
        sh './gradlew check'
      }
    }

    stage('Docker Rm') {
      post {
        success {
          sh 'echo "Docker Rm Success"'
        }

        failure {
          sh 'echo "Docker Rm Fail"'
        }

      }
      steps {
        sh 'echo "Docker Rm Start"'
        sh """
                                        docker stop $dockername
                                        docker rm $dockername
                                        docker rmi -f $repository
                                        """
      }
    }

    stage('Bulid Docker') {
      post {
        failure {
          error 'This pipeline stops here...'
        }

      }
      steps {
        echo 'Bulid Docker'
        script {
          dockerImage = docker.build repository                        //빌드 태그 미사용시 사용
        }

      }
    }

    stage('Docker Deploy') {
      post {
        success {
          echo 'success'
        }

        failure {
          echo 'failed'
        }

      }
      steps {
        echo 'Deploy Docker'
        sh "docker run -p 8081:8080 -d --name=$dockername $repository"                   //빌드 태그 미사용시 사용
      }
    }

  }
  environment {
    repository = 'jenkins/testproject'
    dockername = 'jenkins-testproject'
    dockerImage = ''
  }
}
