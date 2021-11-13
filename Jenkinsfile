pipeline {
	agent any

	stages{
			stage('Clean Package'){
				steps{
					withMaven(jdk: 'jdk-7', maven: 'Maven_Home', mavenLocalRepo: 'mvn clean package', tempBinDir: '\bin') {
    mvn clean package
}
				}				
			}
	    stage('push to nexus'){
				steps{
                    nexusArtifactUploader artifacts: [
			    [
				    artifactId: 'timesheet', 
				    classifier: '',
				    file: 'target/timesheet-1.2.3.war',
				    type: 'war'
			    ]
		    ],
			    credentialsId: '296eb851-c66c-46c8-a414-da5b8877166f', 
			    groupId: 'tn.esprit.spring', 
			    nexusUrl: 'localhost:8081', 
			    nexusVersion: 'nexus3', 
			    protocol: 'http', 
			    repository: 'http://localhost:8081/repository/selimdevops/', 
			    version: '1.2.3'
                  }
            }
			
            stage('Sonar Analyse'){
				steps{
                    bat "mvn sonar:sonar"
                  }
            }
			stage('Deploy'){
				steps{
					bat "mvn deploy"
				}				
			}
			
		} 
}
