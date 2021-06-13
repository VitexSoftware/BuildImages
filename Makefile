all: buster bullseye focal hirsute

buster:
	docker build -t vitexsoftware/debian:stable -f Buster/Dockerfile Buster/

bullseye:
	docker build -t vitexsoftware/debian:testing -f Bullseye/Dockerfile Bullseye/

focal:
	docker build -t vitexsoftware/ubuntu:stable -f Focal/Dockerfile Focal/

hirsute:
	docker build -t vitexsoftware/ubuntu:testing -f Hirsute/Dockerfile Hirsute/
