pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to run tests from')
    }

    stages {
        stage('Validate Branch') {
            steps {
                script {
                    def branchExists = sh(
                        script: "git ls-remote --heads https://github.com/DineshArun1101/featureTesting.git ${params.BRANCH_NAME}",
                        returnStdout: true
                    ).trim()

                    if (!branchExists) {
                        error "Branch '${params.BRANCH_NAME}' not found in remote repository!"
                    } else {
                        echo "Branch '${params.BRANCH_NAME}' exists in remote."
                    }
                }
            }
        }

        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: "*/${params.BRANCH_NAME}"]],
                          userRemoteConfigs: [[url: 'https://github.com/DineshArun1101/featureTesting.git',
                                               credentialsId: 'MyGitHubCreds']]])
            }
        }

        stage('Run JMeter') {
            steps {
                sh """
                    #!/bin/bash
                    chmod +x run-jmeter.sh
                    ./run-jmeter.sh
                """
            }
        }

        stage('Archive Results') {
            steps {
                archiveArtifacts artifacts: 'results.jtl'
                archiveArtifacts artifacts: 'report/**'
            }
        }
    }
}
