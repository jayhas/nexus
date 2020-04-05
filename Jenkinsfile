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
		     	  

	    
	   }
	  }
	               
