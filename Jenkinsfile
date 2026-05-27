pipeline {
    agent any

    parameters {
        string(name: 'DATA_FOLDER', defaultValue: 'data', description: 'Folder containing test data')
        string(name: 'RAMP_TIME', defaultValue: '60', description: 'Ramp-up time in seconds')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run JMeter') {
            steps {
                sh '''
                    #!/bin/bash
                    chmod +x run-jmeter.sh
                    ./run-jmeter.sh $DATA_FOLDER $RAMP_TIME
                '''
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
