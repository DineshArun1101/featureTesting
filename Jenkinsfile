pipeline {
    agent any

    parameters {

        string(
            name: 'BRANCH_NAME',
            defaultValue: 'main',
            description: 'Git branch to run tests from'
        )
    }

    environment {

        JMETER_HOME = "D:/Softwares/apache-jmeter-5.6.3"
    }

    stages {

        stage('Validate Branch') {

            steps {

                script {

                    def branchExists = bat(
                        script: """
                            git ls-remote --heads https://github.com/DineshArun1101/featureTesting.git ${params.BRANCH_NAME}
                        """,
                        returnStdout: true
                    ).trim()

                    if (!branchExists) {

                        error "Branch '${params.BRANCH_NAME}' not found in remote repository!"
                    }

                    echo "Branch '${params.BRANCH_NAME}' exists in remote."
                }
            }
        }

        stage('Checkout') {

            steps {

                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "*/${params.BRANCH_NAME}"]],
                    userRemoteConfigs: [[
                        url: 'https://github.com/DineshArun1101/featureTesting.git',
                        credentialsId: 'MyGitHubCreds'
                    ]]
                ])
            }
        }

        stage('Run JMeter Test') {

            steps {

                bat """
                    bash run-jmeter.sh "${env.JMETER_HOME}"
                """
            }
        }

        stage('Archive Results') {

            steps {

                archiveArtifacts artifacts: 'results_*/**', fingerprint: true

            }
        }
    }

    post {

        always {

            echo 'JMeter execution completed.'
        }

        success {

            echo 'JMeter Test Passed Successfully.'
        }

        failure {

            echo 'JMeter Test Failed.'
        }
    }
}