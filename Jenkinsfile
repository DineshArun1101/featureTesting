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

        stage('Publish HTML Report') {

            steps {

                script {

                    def reportFolders = bat(
                        script: '''
                            for /d %%i in (results_*) do @echo %%i
                        ''',
                        returnStdout: true
                    ).trim().split("\\r?\\n")

                    def reportFolder = reportFolders[-1]

                    echo "Detected Latest Report Folder: ${reportFolder}"

                    publishHTML(target: [
                        allowMissing: false,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: "${reportFolder}/html-report",
                        reportFiles: 'index.html',
                        reportName: "JMeter HTML Report - ${reportFolder}",
                        reportTitles: "JMeter Execution Report"
                    ])
                }
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