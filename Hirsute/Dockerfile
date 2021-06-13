FROM ubuntu:hirsute

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG cs_CZ.utf8

RUN apt update ; apt install -y wget ; echo "deb http://repo.vitexsoftware.cz buster main" | tee /etc/apt/sources.list.d/vitexsoftware.list ; wget -O /etc/apt/trusted.gpg.d/vitexsoftware.gpg http://repo.vitexsoftware.cz/keyring.gpg
RUN apt-get update && apt-get install -y pbuilder sudo curl wget php composer locales




