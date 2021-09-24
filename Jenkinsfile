#!groovy

pipeline {
    agent none

    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }

    stages {
        stage('debian-lts') {
            agent {
                dockerfile {
                    filename 'Stretch/Dockerfile'
                    additionalBuildArgs '-t vitexsoftware/debian:lts -t vitexsoftware/debian:stretch'
                }
            }
            steps {
                checkout scm
            }
            post {
                success {
                    banner()
                }
            }
        }
        stage('debian-oldstable') {
            agent {
                dockerfile {
                    filename 'Buster/Dockerfile'
                    additionalBuildArgs '-t vitexsoftware/debian:buster -t vitexsoftware/debian:oldstable'
                }
            }
            steps {
                checkout scm
            }
            post {
                success {
                    banner()
                }
            }
        }

        stage('debian-stable') {
            agent {
                dockerfile {
                    filename 'Bullseye/Dockerfile'
                    additionalBuildArgs '-t vitexsoftware/debian:bullseye -t vitexsoftware/debian:stable'
                }
            }
            steps {
                checkout scm
            }
            post {
                success {
                    banner()
                }
            }
        }

        stage('debian-testing') {
            agent {
                dockerfile {
                    filename 'Bookworm/Dockerfile'
                    additionalBuildArgs '-t vitexsoftware/debian:bookworm -t vitexsoftware/debian:testing'
                }
            }
            steps {
                checkout scm
            }
            post {
                success {
                    banner()
                }
            }
        }

        stage('ubuntu-stable') {
            agent {
                dockerfile {
                    filename 'Focal/Dockerfile'
                    additionalBuildArgs '-t vitexsoftware/ubuntu:focal -t vitexsoftware/ubuntu:stable'
                }
            }
            steps {
                checkout scm
            }
            post {
                success {
                    banner()
                }
            }
        }

        stage('ubuntu-testing') {
            agent {
                dockerfile {
                    filename 'Hirsute/Dockerfile'
                    additionalBuildArgs '-t vitexsoftware/ubuntu:hirsute -t vitexsoftware/ubuntu:testing'
                }
            }
            steps {
                checkout scm
            }
            post {
                success {
                    banner()
                }
            }
        }
    }
}

def banner() {
    def DISTRO = sh (
            script: 'lsb_release -sd',
            returnStdout: true
        ).trim()
    ansiColor('vga') {
            echo '\033[42m\033[90mBuild VitexSoftware\'s Docker image for ' + DISTRO  + '\033[0m'
    }
}
