pipeline {
	
	agent any
	 tools {
        maven "Maven_Home"
    }
		environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "127.0.0.1:8081"
        NEXUS_REPOSITORY = "maven-nexus-repo"
        NEXUS_CREDENTIAL_ID = "jenkins"
    }

	stages{
						stage('Clean Package'){
				steps{
					bat "mvn clean package"
				}				
			}
	
			
	   stage("Publish to Nexus Repository Manager") {
            steps {
                script {
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
	   }
			
           stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh "./gradlew sonarqube"
                }
            }
        }
			stage('Deploy'){
				steps{
					bat "mvn deploy"
				}				
			}
			
		} 
}
