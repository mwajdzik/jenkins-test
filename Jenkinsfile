pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    sh 'for n in `seq 1 10`; do echo $n; sleep 1; done'
                }
                timeout(time: 2, unit: 'MINUTES') {
                    sh 'for n in `seq 1 50`; do echo $n; sleep 1; done'
                }
            }
        }
    }
}

