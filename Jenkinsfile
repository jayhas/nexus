pipeline{
    agent { label "dev" } 
    environment {
	    DOCKER_IMAGE_NAME = "jahas/mywebapp"
    }
    stages{
	stage(checkout){
	  steps{
	      checkout([$class: 'GitSCM', 
    branches: [[name: '*/master']], 
    userRemoteConfigs: [[credentialsId: 'd01f6d7c-63d7-475b-82ae-ac0096c9f6ab', url: 'https://github.com/jayhas/nexus.git']]
	      ])
	      
	  }
	   
		       }
	 stage(build){
	     steps{
	   sh '/usr/local/src/apache-maven/bin/mvn package'      
	          }
	     
	                }
	  stage('Build Docker Image') {
	     when  {
		  branch 'master'
	     }
	     steps {
		  script{
		     app = docker.build(DOCKER_IMAGE_NAME)
		     app.inside {
			     sh 'echo Hello, World!'
		     }
		  }
	     }
	  }
	  stage('Push Docker Image') {
            when {
		 branch 'master'
	    }
	    steps {
		script {
			docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login'){
				app.push("${env.BUILD_NUMBER}")
				app.push("latest")
			}
		}
	    }
	  }
	    stage('DeployToProduction') {
               when {
	    	     branch 'master'
	            }
	        steps {
		    input 'Deploy to Production'
	            milestone(1)
		//implement kubernetes deployment here
	            kubernetesDeploy(
			kubeconfigId: 'kubeconfig',
			configs: 'mywebapp-kube.yml'
			enableConfigSubstitution: true
		         )
		}
	    }
	   }
	  }
	               
