# Jenkins Kubernetes agent (amd64) for the Debian package pipelines.
#
# The pipelines run the actual builds in vitexsoftware/<distro> containers
# (docker.image(...).inside); the agent itself only needs git, the dpkg/devscripts
# tools called outside of them, sudo and the docker CLI. The daemon is a
# docker:dind sidecar sharing its socket through /run/dind.
#
# uid/gid 222 matches the jenkins user of the distro images, so files written on
# either side of the workspace mount stay accessible.
FROM jenkins/inbound-agent:latest-jdk21 AS agent

FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive LANG=C.UTF-8 \
    JAVA_HOME=/opt/java/openjdk PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    AGENT_WORKDIR=/home/jenkins/agent DOCKER_HOST=unix:///run/dind/docker.sock

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates curl git openssh-client sudo procps unzip jq \
       dpkg-dev devscripts lsb-release docker-cli \
    && groupadd -g 222 jenkins \
    && useradd -m -u 222 -g 222 -s /bin/bash jenkins \
    && echo 'jenkins ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/jenkins \
    && chmod 0440 /etc/sudoers.d/jenkins \
    && rm -rf /var/lib/apt/lists/*

COPY --from=agent /opt/java/openjdk /opt/java/openjdk
COPY --from=agent /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar
COPY --from=agent /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent

RUN ln -s jenkins-agent /usr/local/bin/jenkins-slave \
    && mkdir -p /home/jenkins/agent /home/jenkins/.jenkins \
    && chown -R jenkins:jenkins /home/jenkins

USER jenkins
WORKDIR /home/jenkins/agent
ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
