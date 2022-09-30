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
		  
                  sh 'sudo docker build -t myimage:$BUILD_NUMBER .'
              }
          } 
          stage('Push image to docker registry'){
		  
              steps{
		  
                  sh 'sudo docker login -u phanminhlam -p Phanminhlam1@'
		  sh 'sudo docker push phanminhlam/myimage:$BUILD_NUMBER'
              }
          } 
      }
}
