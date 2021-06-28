#!groovy

pipeline {
    agent none

    options {
        ansiColor('xterm')
	disableConcurrentBuilds()
    }

    stages {

        stage('debian-stable') {
	    agent {
        	dockerfile {
        	    filename "Buster/Dockerfile"
        	    additionalBuildArgs "-t vitexsoftware/debian:stable"
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
        	    filename "Bullseye/Dockerfile"
        	    additionalBuildArgs "-t vitexsoftware/debian:testing"
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
        	    filename "Focal/Dockerfile"
        	    additionalBuildArgs "-t vitexsoftware/ubuntu:stable"
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
        	    filename "Hirsute/Dockerfile"
        	    additionalBuildArgs "-t vitexsoftware/ubuntu:testing"
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

