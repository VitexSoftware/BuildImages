#!groovy

pipeline {
    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }
    agent none
    stages {
        stage('ArchitecturesBuild') {
            matrix {
                agent {
                    label "${ARCH}"
                    dockerfile {
                        filename "${DIST}/Dockerfile"
                        additionalBuildArgs " --architecture ${ARCH} -t vitexsoftware/${DIST}"
                    }
                }
                axes {
                    axis {
                        name 'ARCH'
                        values 'amd64', 'i386', 'armel', 'aarch64'
                    }
                    axis {
                        name 'DIST'
                        values 'debian:stretch', 'debian:buster', 'debian:bullseye', 'debian:bookworm', 'ubuntu:focal', 'ubuntu:hirsute', 'ubuntu:impish'
                    }
                }
                post {
                    success {
                        banner()
                    }
                }
            }
        }
    }
}

def banner() {
    distro = sh (
            script: 'lsb_release -sd',
            returnStdout: true
        ).trim()
    ansiColor('vga') {
            echo '\033[42m\033[90mBuild VitexSoftware\'s Docker image for ' + distro  + '\033[0m'
    }
}
