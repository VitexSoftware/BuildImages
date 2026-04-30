# BuildImages

![Title image](build-images.svg?raw=truue)

To add badges for GitHub Actions, you can use the following markdown:

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/VitexSoftware/BuildImages/docker-image.yml?branch=main)

Source of Docker images used for Debian/Ubuntu package building

simply run

```shell
make
```

to prepare Debian/Ubuntu Docker images with all requied for packaging process inside.

Add [JenkinsfileDEB](JenkinsfileDEB) into your package source as Jenkinsfile or use as Pipeline code to build package(s) and it's
testing install into docker container

Ready to use images
-------------------

* [Debian](https://hub.docker.com/r/vitexsoftware/debian/tags?page=1&ordering=last_updated)

Bookworm (stable)
-----------------

```shell
docker pull vitexsoftware/debian:bookworm
```

Trixie (testing)
----------------

```shell
docker pull vitexsoftware/debian:trixie
```

Forky (unstable)
----------------

```shell
docker pull vitexsoftware/debian:forky
```

* [Ubuntu](https://hub.docker.com/r/vitexsoftware/ubuntu/tags?page=1&ordering=last_updated)

Jammy Jellyfish (22.04 LTS)
----------------------------

```shell
docker pull vitexsoftware/ubuntu:jammy
```

Noble Numbat (24.04 LTS)
-------------------------

```shell
docker pull vitexsoftware/ubuntu:noble
```

Resolute Raccoon (26.04 LTS)
-----------------------------

```shell
docker pull vitexsoftware/ubuntu:resolute
```

![My Build farm](maliny-mini.jpg?raw=true)

Some packages built this way
----------------------------

* <https://github.com/Vitexus/factorio-headless-deb/>
* <https://github.com/Vitexus/factorio-demo-deb/>
* <https://github.com/VitexSoftware/php-ease-core/>
* <https://github.com/VitexSoftware/netbeans-php-tools/>
* <https://github.com/VitexSoftware/php-ease-twbootstrap4/>
* <https://github.com/VitexSoftware/apt-repo-vitexsoftware/>
* <https://github.com/Vitexus/libjs-font-awesome/>
* <https://github.com/VitexSoftware/BuildImages/>
* <https://github.com/VitexSoftware/DEBs-to-SQL/>
* <https://github.com/VitexSoftware/igdebi/>
* <https://github.com/VitexSoftware/php-ease-html/>
* <https://github.com/VitexSoftware/abraflexi-dark-gui/>
* <https://github.com/VitexSoftware/composer-debian/>
* <https://github.com/VitexSoftware/php-ease-fluentpdo/>
* <https://github.com/VitexSoftware/php-tools/>
* <https://github.com/Spoje-NET/apache2-auth-redmine/>
* <https://github.com/VitexSoftware/FirefoxDevelEditionDeb/>
* <https://github.com/VitexSoftware/netbeans.deb/>
* <https://github.com/Vitexus/ThunderbirdDailyDeb/>
* <https://github.com/VitexSoftware/phar-composer/>
* <https://github.com/Vitexus/WinBox.deb/>
* <https://github.com/Vitexus/zellij/>
* <https://github.com/Vitexus/FirefoxNightlyDeb/>
* <https://github.com/PureHTML/mcfly/>
* <https://github.com/Vitexus/phpDocumentor-deb/>
* <https://github.com/Vitexus/automated-time-tracking-with-toggl-on-linux/>

Update listing time using:

```shell
find /var/lib/jenkins/ -name "config.xml" | grep "jenkins" | xargs cat | grep projectUrl | sed 's/     <projectUrl>/ \* /g' | sed 's/<\/projectUrl>//g'
```
