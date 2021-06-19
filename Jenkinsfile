#!groovy
pipeline {
    agent none

    options {
        ansiColor('xterm')
    }

    stages {

        stage('debian-stable') {
            agent {
		    dockerfile {
		        filename 'Dockerfile'
		        dir 'Buster'
		        label 'vitexsoftware/debian:stable'
		    }

            }
            steps {
		banner()
            }
        }

        stage('debian-testing') {
            agent {
		    dockerfile {
		        filename 'Dockerfile'
		        dir 'Bullseye'
		        label 'vitexsoftware/debian:testing'
		    }
            }
            steps {
		banner()
            }
        }

        stage('ubuntu-trusty') {
            agent {
		    dockerfile {
		        filename 'Dockerfile'
		        dir 'Trusty'
		        label 'vitexsoftware/ubuntu:stable'
		    }
            }
            steps {
		banner();
            }
        }

        stage('ubuntu-hirsute') {
            agent {
		    dockerfile {
		        filename 'Dockerfile'
		        dir 'Hirsute'
		        label 'vitexsoftware/ubuntu:testing'
		    }
            }
            steps {
		banner();
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

