#!groovy
String[] architectures = ['amd64', 'armhf', 'aarch64']
String[] distributions = ['debian:buster', 'debian:bullseye', 'debian:bookworm', 'ubuntu:focal', 'ubuntu:hirsute', 'ubuntu:impish']

String vendor = 'vitexsoftware'
String distribution = ''
String architecture = ''
String dockerfile = ''
String buildArgs = ''

architectures.each {
    architecture = it
    distributions.each {
        distribution = it
        dockerfile =  distribution + '/Dockerfile'
        buildArgs = ' --platform linux/' + architecture +
/*        ' -t ' + vendor + '/' + distribution + */
        ' -f ' + dockerfile + ' ' + distribution

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
                stage('Docker push ' + architecture + '/' + distribution ) {
                    docker.withRegistry('https://registry.hub.docker.com', 'vitex_dockerhub') {
                        buildImage.push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }
    }
}
