#!groovy

String[] architectures = ['amd64', 'i386', 'armel', 'aarch64']
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
                stage "\u001B[31m' + buildArgs + '\u001B[0m"
            }

            stage('Build ' + architecture + '/' + distribution + ' image') {
                def customImage = docker.build(vendor + '/' + distribution, buildArgs)
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
