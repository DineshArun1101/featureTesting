pipeline {
    agent any

    parameters {

        string(
            name: 'BRANCH_NAME',
            defaultValue: 'main',
            description: 'Git branch to run tests from'
        )

        string(
            name: 'REPORT_NAME',
            defaultValue: '',
            description: 'Provide format like smokeTest01_0530'
        )
    }

    environment {

        JMETER_HOME = "D:/Softwares/apache-jmeter-5.6.3"
    }

    stages {

        stage('Validate Inputs') {

            steps {

                script {

                    // Validate REPORT_NAME

                    if (!params.REPORT_NAME?.trim()) {

                        error """
REPORT_NAME parameter is empty.

Please provide report name like:
smokeTest01_0530
regressionTest01_0530
loginTest_0530
"""
                    }

                    echo "REPORT_NAME : ${params.REPORT_NAME}"

                    // Validate Git Branch

                    def branchExists = bat(
                        script: """
                            git ls-remote --heads https://github.com/DineshArun1101/featureTesting.git ${params.BRANCH_NAME}
                        """,
                        returnStdout: true
                    ).trim()

                    if (!branchExists) {

                        error """
No branch available in repository for:

${params.BRANCH_NAME}

Please provide valid branch name.
"""
                    }

                    echo "Branch '${params.BRANCH_NAME}' exists in remote repository."
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
                    bash run-jmeter.sh "${env.JMETER_HOME}" "${params.REPORT_NAME}"
                """
            }
        }

        stage('Archive Results') {

            steps {

                archiveArtifacts artifacts: "results-history/results_${params.REPORT_NAME}/**", fingerprint: true
            }
        }

        stage('Publish HTML Report') {

            steps {

                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: "results-history/results_${params.REPORT_NAME}/html-report",
                    reportFiles: 'index.html',
                    reportName: "JMeter HTML Report - ${params.REPORT_NAME}",
                    reportTitles: "JMeter Execution Report"
                ])
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