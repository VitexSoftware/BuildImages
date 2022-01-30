#!groovy

String[] arch = ['amd64', 'i386', 'armel', 'aarch64']
String[] dist = ['debian:stretch', 'debian:buster', 'debian:bullseye', 'debian:bookworm', 'ubuntu:focal', 'ubuntu:hirsute', 'ubuntu:impish']

String dockerfile =  "${DIST}/Dockerfile"
String buildArgs = " --architecture ${ARCH} -t vitexsoftware/${DIST}"

arch.eachWithIndex { val, idx -> println "$val in position $idx" }

def banner() {
    distro = sh (
            script: 'lsb_release -sd',
            returnStdout: true
        ).trim()
    ansiColor('vga') {
            echo '\033[42m\033[90mBuild VitexSoftware\'s Docker image for ' + distro  + '\033[0m'
    }
}
