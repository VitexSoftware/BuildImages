#!groovy
String[] architectures = ['amd64', 'armhf', 'aarch64']
String[] distributions = ['debian:buster', 'debian:bullseye', 'debian:bookworm', 'ubuntu:focal', 'ubuntu:hirsute', 'ubuntu:impish', 'ubuntu:jammy', 'ubuntu:kinetic']

String vendor = 'vitexsoftware'
String distribution = ''
String architecture = ''
String dockerfile = ''
String buildArgs = ''
String distroFamily = ''
String distroCodename = ''


architectures.each {
    architecture = it
    distributions.each {
        distribution = it
        dockerfile =  distribution + '/Dockerfile'
        buildArgs = ' --platform linux/' + architecture +
/*        ' -t ' + vendor + '/' + distribution + */
        ' -f ' + dockerfile + ' ' + distribution

        def dist = distribution.split(':')
        distroFamily = dist[0]
        distroCodename = dist[1]


        def buildImage = ''

        node( architecture ) {
            ansiColor('xterm') {
                stage('Build ' + architecture + '/' + distribution) {
                    checkout scm
                    buildImage = docker.build(vendor + '/' + distribution, buildArgs)
                }
                stage('Test ' + architecture + '/' + distribution) {
                    buildImage.inside {
                        sh 'whoami'
                        sh 'sudo apt install -y linuxlogo'
                        sh 'linuxlogo'
                    }
                }
                stage('Docker push ' + architecture + '/' + distroCodename + "-${env.BUILD_NUMBER}-SNAPSHOT" ) {
                    docker.withRegistry('https://registry.hub.docker.com', 'vitex_dockerhub') {
			if(env.PUSH == 'true'){
                    	    buildImage.push(  distroCodename + "-${env.BUILD_NUMBER}-SNAPSHOT")
			}
                    }
                }
            }
        }
    }
}
