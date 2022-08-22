pipeline {
    agent any
	environment{
	VERSION= "${env.BUILD_ID}"
	}
	
    stages{
        stage("clone the Repo") {
            steps {
		dir ("/assess2/") {
		sh "rm -rf *"
		sh "git clone https://github.com/mithi5/DevOps-Assessment-2.git"
                    }
                }
	}
			
	stage ("maven build") {
            steps {
		dir ("/assess2/DevOps-Assessment-2/") {
		sh 'mvn clean package'
		sh 'cp /assess2/DevOps-Assessment/target/bookstore-example-1.0-SNAPSHOT.war /assess2/assessment-2'
                    }
                }
            }
			
	stage ("build the docker image & Push") {
            steps {
		script{
		withCredentials([string(credentialsId: 'docker-pass', variable: 'docker_password')]) {
		dir ("/assess2/DevOps-Assessment-2") {
		sh 'docker build -t mithi5/my:${VERSION} .'
		sh 'docker push mithi5/my:${VERSION}'
		sh 'docker rmi mithi5/my:${VERSION}'
					}
				}	
			}
		}
	}
	stage ("Deploy the Manifest using HELM") {
		steps {
		script{
                withCredentials([kubeconfigFile(credentialsId: 'k8-config', variable: 'KUBECONFIG')]) {
		dir ("/home/ubuntu/tomcat/"){  
		sh 'helm list'
		sh 'helm install  myapp:${VERSION} tomcat '
					}
				}
			}					
		}
	}
}
