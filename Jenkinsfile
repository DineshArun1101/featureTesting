pipeline {
    agent any

    parameters {
        // Only parameter: folder name from repo
        string(name: 'TARGET_FOLDER', defaultValue: 'perf-tests', description: 'Folder in GitHub repo containing JMX file')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validate Folder') {
            steps {
                script {
                    if (!fileExists("${params.TARGET_FOLDER}")) {
                        error "Folder '${params.TARGET_FOLDER}' not found in repo!"
                    }
                }
            }
        }

        stage('Run JMeter') {
            steps {
                sh """
                    #!/bin/bash
                    chmod +x run-jmeter.sh
                    ./run-jmeter.sh $TARGET_FOLDER
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
