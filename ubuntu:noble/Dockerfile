FROM ubuntu:noble

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf-8
ENV LC_ALL en_US.utf-8
ENV LANGUAGE=en

RUN apt-get update ; apt-get install -y wget ; echo "deb [signed-by=/usr/share/keyrings/vitexsoftware.gpg] http://repo.vitexsoftware.com noble main backports" | tee /etc/apt/sources.list.d/vitexsoftware.list ; wget -O /usr/share/keyrings/vitexsoftware.gpg http://repo.vitexsoftware.com/keyring.gpg
RUN apt-get -y install locales locales-all && rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && echo "LC_ALL=en_US.UTF-8" >> /etc/environment ; echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen ; echo "LANG=en_US.UTF-8" > /etc/locale.conf ; locale-gen en_US.UTF-8 cs_CZ.UTF-8
RUN apt-get update && apt-get install -y pbuilder sudo curl wget php composer lsb-release jq moreutils aptitude gdebi-core apt-utils debhelper po-debconf

RUN \
    groupadd -g 222 jenkins && useradd -u  222  -g jenkins -G sudo -m -s /bin/bash jenkins && \
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Customized the sudoers file for passwordless access to the jenkins user!" && \
    echo "jenkins user:";  su - jenkins -c id

RUN sed -i -e '/sendmail_path/c\sendmail_path="cat - >> /tmp/mailfile"' /etc/php/*/*/php.ini ; touch /tmp/mailfile ; chmod uog+rw /tmp/mailfile

ADD usrsharelocale.tar.gz /

RUN mkdir -p /var/lib/jenkins/workspace/ ; chown jenkins:jenkins /var/lib/jenkins/ -Rv
RUN apt -y install php-mbstring && phpenmod mbstring
