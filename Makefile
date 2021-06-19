all: buster bullseye focal hirsute

buster:
	docker build -t vitexsoftware/debian:stable -f Buster/Dockerfile Buster/

bullseye:
	docker build -t vitexsoftware/debian:testing -f Bullseye/Dockerfile Bullseye/

focal:
	docker build -t vitexsoftware/ubuntu:stable -f Focal/Dockerfile Focal/

hirsute:
	docker build -t vitexsoftware/ubuntu:testing -f Hirsute/Dockerfile Hirsute/

clean:
	docker system prune -a -f
	docker rmi $$(docker images 'vitexsoftware/debian:stable' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:testing' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:stable' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:testing' -a -q)

reset: clean all
