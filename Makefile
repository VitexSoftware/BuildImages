all: buster bullseye bookworm focal hirsute impish jammy kinetic

stretch:
	docker build -t vitexsoftware/debian:lts -t vitexsoftware/debian:stretch  -f debian:stretch/Dockerfile debian:stretch/

buster:
	docker build -t vitexsoftware/debian:oldstable -t vitexsoftware/debian:buster -f debian:buster/Dockerfile debian:buster/

bullseye:
	docker build -t vitexsoftware/debian:stable -t vitexsoftware/debian:bullseye   -f debian:bullseye/Dockerfile debian:bullseye/

bookworm:
	docker build -t vitexsoftware/debian:testing -t vitexsoftware/debian:bookworm -f debian:bookworm/Dockerfile debian:bookworm/

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

update:
	ansible-playbook 

buildx-buster:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/debian:buster debian:buster

buildx-bullseye:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/debian:bullseye debian:bullseye

buildx-bookworm:
	docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag vitexsoftware/debian:bookworm debian:bookworm

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

buildx: buildx-buster buildx-bullseye buildx-bookworm buildx-focal buildx-hirsute buildx-impish buildx-jammy buildx-kinetic


clean:
	docker system prune -a -f
	docker rmi $$(docker images 'vitexsoftware/debian:buster' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:bullseye' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:bookworm' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:focal' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:hirsute' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:impish' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:jammy' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:kinetic' -a -q)
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

reset: clean all

push:
	docker push vitexsoftware/debian:buster
	docker push vitexsoftware/debian:bullseye
	docker push vitexsoftware/debian:bookworm
	docker push vitexsoftware/ubuntu:focal
	docker push vitexsoftware/ubuntu:hirsute
	docker push vitexsoftware/ubuntu:impish
	docker push vitexsoftware/ubuntu:jammy
	docker push vitexsoftware/ubuntu:kinetic

publish: all push

