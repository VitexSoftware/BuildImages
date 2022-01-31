#!groovy
String[] architectures = ['amd64', 'armhf', 'aarch64']
String[] distributions = ['debian:stretch', 'debian:buster', 'debian:bullseye', 'debian:bookworm', 'ubuntu:focal', 'ubuntu:hirsute', 'ubuntu:impish']

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
        buildArgs = ' --platform linux/' + architecture + ' -t ' + vendor + '/' + distribution + ' -f ' + dockerfile + ' ' + distribution
        node( architecture ) {
            ansiColor('xterm') {
                stage(architecture + '/' + distribution) {
                    def buildImage = docker.build(vendor + '/' + distribution, buildArgs)
                }
            }

        }
    }
}
