pipeline{
    tools{
        jdk 'myjava'
        maven 'mvnn'
    }
	//agent {label 'linux_slave'}
	agent any
      stages{
           stage('Checkout'){
	    
               steps{
		 echo 'cloning..'
                 git 'https://github.com/devops-learner01012022/DevOpsClassCodes.git'
              }
          }
          stage('Compile'){
             
              steps{
                  echo 'compiling..'
                  sh 'mvn compile'
	      }
          }
          stage('CodeReview'){
		  
              steps{
		    
		  echo 'codeReview'
                 // sh 'mvn pmd:pmd'
              }
          }
           stage('UnitTest'){
		  
              steps{
	         
                  sh 'mvn test'
              }
               post {
               success {
                   junit 'target/surefire-reports/*.xml'
               }
           }	
          }
//            stage('MetricCheck'){
              
//               steps{
//                   sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
//               }
//                post {
//                success {
// 	           cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'target/site/cobertura/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false                  
//                }
//            }		
//           }
          stage('Package'){
		  
              steps{
		  
                  sh 'mvn package'
              }
          }
	      
          stage('Build Image'){
		  
              steps{
		  
                  sh 'docker build -t phanminhlam/myimage:$BUILD_NUMBER .'
              }
          } 
          stage('Push image to docker registry'){
		  
              steps{
		  
                  sh 'docker login -u phanminhlam -p Phanminhlam1@'
		          sh 'docker push phanminhlam/myimage:$BUILD_NUMBER'
              }
          }
	
          stage('DeploytoDevelopment') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'sshslave', keyFileVariable: 'setcret-ssh')]) {
                    sshPublisher(
                      publishers: [
                        sshPublisherDesc(
                          configName: 'slave1', 
                          sshCredentials: [
                            // encryptedPassphrase: '{AQAAABAAAAAQmZpJBQL228Xgi6SrPRMu1dQRuXsdYcq4LR/7X3t6y+c=}', 
                            keyPath: '/var/lib/jenkins/slave-privatekey', 
                            key: '$setcret-ssh',
                            username: 'root'
                            ], 
                          transfers: [
                            sshTransfer(
                              execCommand: 'docker login -u phanminhlam -p Phanminhlam1@ && docker pull phanminhlam/myimage:$BUILD_NUMBER && docker run -d phanminhlam/myimage:$BUILD_NUMBER'
                              )
                            ]
                        )
                      ]
                    )
                }
            }
        }
      }
}
