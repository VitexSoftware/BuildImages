#!groovy

node {

    stage('Clone repository') {
        checkout scm
    }

    stage('debian-stable') {
        def buster = docker.build("vitexsoftware/debian:stable", "-f ./Buster/Dockerfile ")
	buster.inside {
    	    banner()
	}
    }

    stage('debian-testing') {
        def bullseye = docker.build("vitexsoftware/debian:testing", "-f ./Bullseye/Dockerfile ")
	bullseye.inside {
    	    banner()
	}
    }

    stage('ubuntu-trusty') {
        def trusty = docker.build("vitexsoftware/ubuntu:stable", "-f ./Trusty/Dockerfile ")
	trusty.inside {
    	    banner()
	}
    }

    stage('ubuntu-hirsute') {
        def hirsute = docker.build("vitexsoftware/ubuntu:testing", "-f ./Hirsute/Dockerfile ")
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

