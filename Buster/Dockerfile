FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US
ENV LANGUAGE en_US
ENV LC_ALL en_US

RUN apt-get update ; apt-get install -y wget ; echo "deb http://repo.vitexsoftware.cz buster main" | tee /etc/apt/sources.list.d/vitexsoftware.list ; wget -O /etc/apt/trusted.gpg.d/vitexsoftware.gpg http://repo.vitexsoftware.cz/keyring.gpg && apt-get update
RUN apt-get -y upgrade  && apt-get install -y pbuilder sudo curl wget php composer locales


