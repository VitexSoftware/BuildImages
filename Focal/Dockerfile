FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf-8
ENV LC_ALL en_US.utf-8

RUN apt-get update ; apt-get install -y wget ; echo "deb http://repo.vitexsoftware.cz focal main" | tee /etc/apt/sources.list.d/vitexsoftware.list ; wget -O /etc/apt/trusted.gpg.d/vitexsoftware.gpg http://repo.vitexsoftware.cz/keyring.gpg
RUN apt-get -y install locales ; echo "LC_ALL=en_US.UTF-8" >> /etc/environment ; echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen ; echo "LANG=en_US.UTF-8" > /etc/locale.conf ; locale-gen en_US.UTF-8
RUN apt-get update && apt-get install -y pbuilder sudo curl wget php composer lsb-release jq moreutils aptitude gdebi-core freight apt-utils apt-utils debhelper po-debconf  

RUN \
    groupadd -g 114 jenkins && useradd -u 107 -g jenkins -G sudo -m -s /bin/bash jenkins && \
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Customized the sudoers file for passwordless access to the jenkins user!" && \
    echo "jenkins user:";  su - jenkins -c id

