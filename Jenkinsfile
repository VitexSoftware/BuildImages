#!groovy

node {

    stage('Clone repository') {
        checkout scm
    }

    stage('debian-stable') {
        def buster = docker.build("vitexsoftware/debian:stable", "-f Dockerfile ./Buster")
	buster.inside {
    	    banner()
	}
    }

    stage('debian-testing') {
        def bullseye = docker.build("vitexsoftware/debian:testing", "-f Dockerfile ./Bullseye")
	bullseye.inside {
    	    banner()
	}
    }

    stage('ubuntu-trusty') {
        def trusty = docker.build("vitexsoftware/ubuntu:stable", "-f Dockerfile ./Trusty")
	trusty.inside {
    	    banner()
	}
    }

    stage('ubuntu-hirsute') {
        def hirsute = docker.build("vitexsoftware/ubuntu:testing", "-f Dockerfile ./Hirsute")
        hirstute.inside {
	    banner()
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

