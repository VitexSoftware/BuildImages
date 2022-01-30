#!groovy

pipeline {
    agent none

    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }

    stages {

        stage('ArchitecturesBuild') {
            matrix {
                agent any
                axes {
                    axis {
                        name 'ARCH'
                        values 'amd64', 'i386', 'armel', 'aarch64'
                    }
                    axis {
                        name 'DIST'
                        values 'debian-stretch', 'debian-buster', 'debian-bullseye', 'debian-bookworm', 'ubuntu-focal', 'ubuntu-impish'
                    }
                }
            }
            stages {
                    stage('Build') {
                        steps {
                            echo "Do Build for ${ARCH} - ${DIST}"
                        }
                    }
                    stage('Test') {
                        steps {
                            echo "Do Test for ${ARCH} - ${DIST}"
                        }
                    }
            }

        stage('debian-lts') {
            agent {
                dockerfile {
                    filename 'stretch/Dockerfile'
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
                    filename 'buster/Dockerfile'
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
                    filename 'bullseye/Dockerfile'
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
                    filename 'bookworm/Dockerfile'
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
                    filename 'focal/Dockerfile'
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
                    filename 'hirsute/Dockerfile'
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

        stage('ubuntu-impish') {
            agent {
                agentAction('ubuntu','impish','rolling');
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
    // def agentAction(distro,code,type){
    //     architecture = sh (
    //             script: 'dpkg --print-architecture',
    //             returnStdout: true
    //         ).trim()

    //     dockerfile {
    //         filename code + '/Dockerfile'
    //         additionalBuildArgs ' --platform linux/ ' + architecture + ' -t vitexsoftware/' + distro + ':' + code + ' -t vitexsoftware/' + distro + ':' + type
    //     }
    // }

    }

    def banner() {
        architecture = sh (
                script: 'dpkg --print-architecture',
                returnStdout: true
            ).trim()
        distro = sh (
                script: 'lsb_release -sd',
                returnStdout: true
            ).trim()
        ansiColor('vga') {
                echo '\033[42m\033[90mBuild VitexSoftware\'s Docker image for ' + distro + ' ' + architecture  + '\033[0m'
        }
    }

}
