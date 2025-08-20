all: bullseye bookworm trixie forky focal jammy noble

stretch:
	docker build -t vitexsoftware/debian:lts -t vitexsoftware/debian:stretch  -f debian:stretch/Dockerfile debian:stretch/

buster:
	docker build -t vitexsoftware/debian:buster -f debian:buster/Dockerfile debian:buster/

bullseye:
	docker build -t vitexsoftware/debian:bullseye   -f debian:bullseye/Dockerfile debian:bullseye/

bookworm:
	docker build -t vitexsoftware/debian:bookworm -f debian:bookworm/Dockerfile debian:bookworm/

forky:
	docker build -t vitexsoftware/debian:forky -f debian:forky/Dockerfile debian:forky/

bionic:
	docker build -t vitexsoftware/ubuntu:latest -t vitexsoftware/ubuntu:bionic -f ubuntu:bionic/Dockerfile ubuntu:bionic/

focal:
	docker build -t vitexsoftware/ubuntu:latest -t vitexsoftware/ubuntu:focal -f ubuntu:focal/Dockerfile ubuntu:focal/

hirsute:
	docker build -t vitexsoftware/ubuntu:hirsute -f ubuntu:hirsute/Dockerfile ubuntu:hirsute/

impish:
	docker build -t vitexsoftware/ubuntu:impish -f ubuntu:impish/Dockerfile ubuntu:impish/

jammy:
	docker build -t vitexsoftware/ubuntu:stable -t vitexsoftware/ubuntu:jammy -f ubuntu:jammy/Dockerfile ubuntu:jammy/

kinetic:
	docker build -t vitexsoftware/ubuntu:stable -t vitexsoftware/ubuntu:kinetic -f ubuntu:kinetic/Dockerfile ubuntu:kinetic/

noble:
	docker build -t vitexsoftware/ubuntu:noble -f ubuntu:noble/Dockerfile ubuntu:noble/

trixie:
	docker build -t vitexsoftware/debian:unstable -t vitexsoftware/debian:trixie -f debian:trixie/Dockerfile debian:trixie/

update:
	ansible-playbook

buildx-buster:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/debian:buster debian:buster

buildx-bullseye:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/debian:bullseye debian:bullseye

buildx-bookworm:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/debian:bookworm debian:bookworm

buildx-trixie:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/debian:trixie debian:trixie

buildx-forky:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/debian:forky debian:forky

buildx-focal:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/ubuntu:focal ubuntu:focal

buildx-hirsute:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/ubuntu:hirsute ubuntu:hirsute

buildx-impish:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/ubuntu:impish ubuntu:impish

buildx-jammy:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/ubuntu:jammy ubuntu:jammy

buildx-kinetic:
	docker buildx build --push --platform linux/arm/v7,linux/amd64/v3,linux/arm64/v8 --tag vitexsoftware/ubuntu:kinetic ubuntu:kinetic

buildx-noble:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/ubuntu:noble ubuntu:noble

buildx: buildx-bullseye buildx-bookworm buildx-trixie buildx-forky buildx-focal buildx-jammy buildx-noble

clean:
	docker system prune -a -f
	docker rmi $$(docker images 'vitexsoftware/debian:buster' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:bullseye' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:bookworm' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:trixie' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:forky' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:bionic' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:focal' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:hirsute' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:impish' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:jammy' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:kinetic' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:noble' -a -q)
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

reset: clean all

push:
	docker push vitexsoftware/debian:buster
	docker push vitexsoftware/debian:bullseye
	docker push vitexsoftware/debian:bookworm
	docker push vitexsoftware/debian:trixie
	docker push vitexsoftware/debian:forky
	docker push vitexsoftware/ubuntu:focal
	docker push vitexsoftware/ubuntu:hirsute
	docker push vitexsoftware/ubuntu:impish
	docker push vitexsoftware/ubuntu:jammy
	docker push vitexsoftware/ubuntu:kinetic
	docker push vitexsoftware/ubuntu:noble

publish: all push
