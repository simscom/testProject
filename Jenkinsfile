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
        git(url: 'https://github.com/simscom/testProject.git', branch: 'main', credentialsId: 'testProject')
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
          sh 'export JAVA_HOME=/var/jenkins_home/bin/jdk1.8.0_341'
          sh 'export GRADLE_HOME=/var/jenkins_home/bin/gradle-7.6.1'
          sh 'export MAVEN_HOME=/var/jenkins_home/bin/apache-maven-3.9.0'
          sh 'export PATH=$JAVA_HOME/bin:$GRADLE_HOME/bin:$MAVEN_HOME/bin:$PATH:/var/jenkins_home/.'
          sh 'chmod +x gradlew'
          sh '/var/jenkins_home/bin/gradle-7.6.1/bin/gradle wrap'
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
