pipeline{
    agent { label "dev" } 
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
	  stage(codequality){
	       steps{
	   withSonarQubeEnv('SonarqubeServer'){        
	  sh '/usr/local/src/apache-maven/bin/mvn sonar:sonar'         
	            }
	       }
	  }
	  stage(artifact){
	      steps{
	        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {   
	    sh '/usr/local/src/apache-maven/bin/mvn deploy exit 1'
	    
	      }
	                }
	  }
	   stage(deploy){
	       steps{
	       sh 'sudo scp /root/jenkins/workspace/pipeline/target/*.war root@jacobhassan2c.mylabserver.com:/var/lib/tomcat/webapps'
	       }
	       
	                }
	   }
	  }
	               
