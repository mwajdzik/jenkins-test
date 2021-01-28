pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                echo 'building...'
                withGradle() {
                    sh './gradlew -v'
                    sh './gradlew build'
                }
            }
        }
    }
}

