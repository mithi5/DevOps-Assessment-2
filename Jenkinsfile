pipeline {
    agent any
 
    stages{
        stage("clone the Repo") {
            steps {
                dir ("/assess2/DevOps-Assessment-2/") {
                sh "rm -rf *"
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/mithi5/DevOps-Assessment-2.git']]])
                    }
                }
        }

        stage ("maven build") {
            steps {
                dir ("/assess2/DevOps-Assessment-2/") {
                sh 'mvn install'
                sh 'mvn package -Pproduction'
                sh 'cp /assess2/DevOps-Assessment-2/target/bookstore-example-1.0-SNAPSHOT.war /assess2/DevOps-Assessment-2/'
                    }
                }
            }

        stage ("build the docker image & Push") {
            steps {
                script{
                withCredentials([string(credentialsId: 'docker-pass', variable: 'docker_password')]) {
                dir ("/assess2/DevOps-Assessment-2") {
                sh 'docker system prune -a -f'
                sh 'docker build -t mithi5/myapp .'
                sh 'docker push mithi5/myapp'
                                        }
                                }
                        }
                }
        }
        stage ("Deploy the Manifest using HELM") {
            steps {
			dir ("/assess2/DevOps-Assessment-2/") {
                sshagent(['8e67092e-04a6-422f-9f7f-a885666925b4']) {
                    sh "scp -r tomcat ubuntu@172.31.14.67:/home/ubuntu"
		    sh "ssh ubuntu@172.31.14.67 sudo helm upgrade --install --force mytest tomcat --set appimage=mithi5/myapp:latest"
                    }
                }
			}
		}
	}
}
