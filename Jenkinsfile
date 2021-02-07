def GIT_COMMIT_HASH
def ACCOUNT_REGISTRY_PREFIX

pipeline {
    agent any
    stages {
        stage('Get the latest commit hash and log into ECR') {
            steps {
                script {
                    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
                    ACCOUNT_REGISTRY_PREFIX = "xxxxxxxxxxxx.dkr.ecr.us-west-2.amazonaws.com"
                    sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${ACCOUNT_REGISTRY_PREFIX}"
                }
            }
        }

        stage('Make a builder image') {
            steps {
                script {
                    //
                    // https://www.jenkins.io/doc/book/pipeline/docker/
                    //
                    def image = "${ACCOUNT_REGISTRY_PREFIX}/demo-app-builder:${GIT_COMMIT_HASH}"
                    def builderImage = docker.build(image, "-f ./Dockerfile.builder .")

                    builderImage.push()
                    builderImage.push("${env.GIT_BRANCH}")

                    builderImage.inside("-v $WORKSPACE:/root/project -u root") {
                        sh "cd /root/project; gradle build"
                    }
                }
            }
        }
    }
}

