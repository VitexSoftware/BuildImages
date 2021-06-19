#!groovy

pipeline {
    agent none

    options {
        ansiColor('xterm')
    }

    stages {

        stage('debian-stable') {
    	    dockerfile {
        	filename "Buster/Dockerfile"
        	additionalBuildArgs "-t vitexsoftware/debian:stable"
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
    	    dockerfile {
        	filename "Bulseye/Dockerfile"
        	additionalBuildArgs "-t vitexsoftware/debian:testing"
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
    	    dockerfile {
        	filename "Trusty/Dockerfile"
        	additionalBuildArgs "-t vitexsoftware/ubuntu:stable"
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
    	    dockerfile {
        	filename "Hirsute/Dockerfile"
        	additionalBuildArgs "-t vitexsoftware/ubuntu:testing"
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

