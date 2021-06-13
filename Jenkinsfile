#!groovy
pipeline {
    agent none
    stages {
        stage('debian-stable') {
            agent {
                docker { image 'vitexsoftware/debian:stable' }
            }
            steps {
                dir('build/debian/package') {
                    sh 'if [ ! -d source ]; then git clone --depth 1 --single-branch $GIT_URL source ; else cd source; git pull; cd ..; fi;'
		    sh 'ls -la'
		    sh 'ls -la source'
                    sh 'cd source ; debuild -i -us -uc -b ; cd ..'
                    sh 'mkdir -p $WORKSPACE/dist/debian/ ; mv *.deb *.changes *.build $WORKSPACE/dist/debian/'
                }
                stash includes: 'dist/**', name: 'dist-debian'
            }
        }

        stage('debian-testing') {
            agent {
                docker { image 'vitexsoftware/debian:testing' }
            }
            steps {
                dir('build/debian/package') {
                    sh 'if [ ! -d source ]; then git clone --depth 1 --single-branch $GIT_URL source ; else cd source; git pull; cd ..; fi;'
                    sh 'cd source ; debuild -i -us -uc -b ; cd ..'
                    sh 'mkdir -p $WORKSPACE/dist/debian/ ; mv *.deb *.changes *.build $WORKSPACE/dist/debian/'
                }
            }
        }
        stage('ubuntu-trusty') {
            agent {
                docker { image 'vitexsoftware/trusty:stable' }
            }
            steps {
                dir('build/debian/package') {
                    sh 'if [ ! -d source ]; then git clone --depth 1 --single-branch $GIT_URL source ; else cd source; git pull; cd ..; fi;'
                    sh 'cd source ; debuild -i -us -uc -b ; cd ..'
                    sh 'mkdir -p $WORKSPACE/dist/debian/ ; mv *.deb *.changes *.build $WORKSPACE/dist/debian/'
                }
            }
        }
        stage('ubuntu-hirsute') {
            agent {
                docker { image 'vitexsoftware/ubuntu:testing' }
            }
            steps {
                dir('build/debian/package') {
                    sh 'if [ ! -d source ]; then git clone --depth 1 --single-branch $GIT_URL source ; else cd source; git pull; cd ..; fi;'
                    sh 'cd source ; debuild -i -us -uc -b ; cd ..'
                    sh 'mkdir -p $WORKSPACE/dist/debian/ ; mv *.deb *.changes *.build $WORKSPACE/dist/debian/'
                }
            }
       }
    }
}
