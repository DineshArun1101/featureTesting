pipeline {
    agent any

    parameters {
        // Branch name to checkout (e.g. "main", "feature-xyz")
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to run tests from')
    }

    stages {
        stage('Validate Branch') {
            steps {
                script {
                    // Check if branch exists in remote before checkout
                    def branchExists = sh(
                        script: "git ls-remote --heads https://github.com/DineshArun1101/featureTesting.git ${params.BRANCH_NAME}",
                        returnStdout: true
                    ).trim()

                    if (!branchExists) {
                        error "Branch '${params.BRANCH_NAME}' not found in remote repository!"
                    }
                }
            }
        }

        stage('Checkout') {
            steps {
                // Checkout the branch specified in BRANCH_NAME
                checkout([$class: 'GitSCM',
                          branches: [[name: "*/${params.BRANCH_NAME}"]],
                          userRemoteConfigs: [[url: 'https://github.com/DineshArun1101/featureTesting.git']]])
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
