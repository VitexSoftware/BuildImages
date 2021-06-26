![Title image](build-images.svg?raw=truue)

# BuildImages
Source of Docker images used for Debian package building

simply run

```shell
make
```

to prepare Debian/Ubuntu Docker imges with all requied for packaging process inside.

Add [JenkinsfileDEB](JenkinsfileDEB) into your package source as Jenkinsfile or use as Pipeline code to build package(s) and it's
testing install into docker container





