pipeline{
  agent {
    docker {
      image 'maven:3-alpine'
      args '-v /root/.m2:/root/.m2'
    }
  }
  stages {
    stage('Maven-Clean'){
      steps{
        sh 'mvn clean'
      }
    }
    stage('Maven-Compile'){
      steps{
        sh 'mvn compile'
      }
    }
    stage('Maven_Test'){
      steps{
        sh 'mvn test'
      }
    }
    
     stage("build & SonarQube analysis") {
            agent any
            steps{
                      script{
                      withSonarQubeEnv('sonarserver') { 
                      sh "mvn sonar:sonar"
                       }
                      timeout(time: 1, unit: 'MINUTES') {
                      def qg = waitForQualityGate()
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                    }
		    sh "mvn clean install"
                  }
                }  
              }

       }  
    stage('Maven-Package'){
      
      steps{
        // retry(3){
        sh 'mvn package'
        // }
      }
      // post{
      //   failure{
      //     sh 'mvn package'
      //   }
      // }

    }
  }
}
