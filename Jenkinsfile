pipeline {
    agent any
     stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/dhanyababu/fooproject'
             }
        }
        stage('Build') {
            steps {
                sh "mvn compile"
            }
        }
       stage('Test') {
            steps {
                sh "mvn test"
            }
       }
       stage('newman') {
            steps {
                sh 'newman run Restful_Booker.postman_collection.json --environment Restful_Booker.postman_environment.json --reporters junit'
            }
            post {
                always {
                     junit '**/*xml'
                }
            }

       }
       stage('code coverage') {
                   steps {
                       sh "mvn cobertura:cobertura"
                   }
                   post {
                       always {
                            junit '**/TEST*.xml'
                       }
                   }

              }

        stage('robot') {
                    steps {
                        sh 'robot -d results --variable BROWSER:headlesschrome infotivHome.robot'
                    }
                    post {
                        always {
                            script {
                                  step(
                                        [
                                          $class              : 'RobotPublisher',
                                          outputPath          : 'results',
                                          outputFileName      : '**/output.xml',
                                          reportFileName      : '**/report.html',
                                          logFileName         : '**/log.html',
                                          disableArchiveOutput: false,
                                          passThreshold       : 50,
                                          unstableThreshold   : 40,
                                          otherFiles          : "**/*.png,**/*.jpg",
                                        ]
                                   )
                            }
                        }
                    }
        }
     }

    post {
        always {
            junit '**/TEST*.xml'
            step([$class: 'CoberturaPublisher' ,autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: '**/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false])
            emailext attachLog: true, attachmentsPattern: '**/TEST*xml',
            body: '', recipientProviders: [culprits()], subject:
            '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!'

        }
    }
 }

