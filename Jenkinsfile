pipeline {
    agent any
 
    environment {
        repository = "jenkins/testproject"
        dockername = "jenkins-testproject"
        dockerImage = ''
    }
 
    stages {
        stage('Prepare') {
          steps {
            echo 'Clonning Repository'
            git url: 'http://192.168.56.1:9002/git/snet00/testProject.git',
              branch: 'master',
              credentialsId: 'snet00'
            }
            post {
             success { 
               echo 'Successfully Cloned Repository'
             }
           	 failure {
               error 'This pipeline stops here...'
             }
          }
        }
 
        stage('Bulid Gradle') {
          steps {
            echo 'Bulid Gradle'
            dir('.'){
                sh "chmod +x gradlew"
                sh "gradle wrap"
                sh './gradlew clean build'
            }
          }
          post {
            failure {
              error 'This pipeline stops here...'
            }
          }
        }
        
        stage('Bulid Test') {
          steps {
              echo 'Bulid Test'
              sh './gradlew check'
          }
          post {
            failure {
              error 'This pipeline stops here...'
            }
          }
        }
        
        stage('Docker Rm') {
            steps {
                sh 'echo "Docker Rm Start"'
                sh """
                docker stop $dockername
                docker rm $dockername
                docker rmi -f $repository
                """
            }
            
            post {
                success { 
                    sh 'echo "Docker Rm Success"'
                }
                failure {
                    sh 'echo "Docker Rm Fail"'
                }
            }
        }
       
        stage('Bulid Docker') {
          steps {
            echo 'Bulid Docker'
            script {
                //dockerImage = docker.build repository + ":$BUILD_NUMBER"   //빌드 태그 추가시 사용
                dockerImage = docker.build repository                        //빌드 태그 미사용시 사용
            }
          }
          post {
            failure {
              error 'This pipeline stops here...'
            }
          }
        }
        
        stage('Docker Deploy') { 
	  steps {
	     echo 'Deploy Docker'
	     //sh "docker ps -q --filter 'name=$dockername' | grep -q . && docker stop $dockername && docker rm $dockername | true" 
	     //sh "docker run -p 8081:8080 -d --name=$dockername $repository:$BUILD_NUMBER"   //빌드 태그 추가시 사용
	     sh "docker run -p 8081:8080 -d --name=$dockername $repository"                   //빌드 태그 미사용시 사용
	     //sh "docker rmi -f $(docker images -f 'dangling=true' -q) || true"	      //미사용 삭제
          }
          post {
            success {
        	echo 'success'
            }
	    failure {
	        echo 'failed'
	    }
          }
        }     
    }
 
}