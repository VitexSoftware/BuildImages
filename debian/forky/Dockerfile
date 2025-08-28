# Debian Forky with VitexSoftware APT repo configured
FROM debian:forky-slim

ARG REPO_URL=https://repo.vitexsoftware.com
ARG KEY_URL=https://repo.vitexsoftware.com/KEY.gpg

ENV DEBIAN_FRONTEND=noninteractive

COPY scripts/add-vitexsoftware-apt.sh /usr/local/bin/add-vitexsoftware-apt.sh
RUN chmod +x /usr/local/bin/add-vitexsoftware-apt.sh \
    && echo 'Acquire::Check-Valid-Until "false";' >> /etc/apt/apt.conf.d/10no-check-valid-until \
    && echo 'Acquire::AllowInsecureRepositories "true";' >> /etc/apt/apt.conf.d/99allow-insecure \
    && echo 'APT::Get::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/99allow-unauth \
    && apt-get update \
    && apt-get install -y --allow-unauthenticated --no-install-recommends ca-certificates curl gnupg debconf-utils \
    && echo 'pbuilder pbuilder/mirrorsite string http://deb.debian.org/debian' | debconf-set-selections \
    && add-vitexsoftware-apt.sh forky "$REPO_URL" "$KEY_URL" \
    && apt-get update \
&& apt-get install -y --no-install-recommends \
       build-essential devscripts pbuilder sudo aptitude fakeroot git \
       php php-intl php-xml php-mbstring phpunit composer \
       gettext locales locales-all \
       exim4 mailutils unzip lsb-release \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "cs_CZ.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 cs_CZ.UTF-8 \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US:en \
    && sed -i -e '/sendmail_path/c\sendmail_path="cat - >> /tmp/mailfile"' /etc/php/*/*/php.ini \
    && touch /tmp/mailfile \
    && chmod uog+rw /tmp/mailfile \
    && (getent group 222 >/dev/null || groupadd -g 222 jenkins) \
    && (id -u 222 >/dev/null 2>/dev/null || useradd -m -u 222 -g 222 -s /bin/bash -G sudo jenkins) \
    && echo 'jenkins ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/jenkins \
    && chmod 0440 /etc/sudoers.d/jenkins \
    && rm -rf /var/lib/apt/lists*

CMD ["bash"]

