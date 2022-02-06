all: buster bullseye bookworm focal hirsute impish

stretch:
	docker build -t vitexsoftware/debian:lts -t vitexsoftware/debian:stretch  -f debian:stretch/Dockerfile debian:stretch/

buster:
	docker build -t vitexsoftware/debian:oldstable -t vitexsoftware/debian:buster -f debian:buster/Dockerfile debian:buster/

bullseye:
	docker build -t vitexsoftware/debian:stable -t vitexsoftware/debian:bullseye   -f debian:bullseye/Dockerfile debian:bullseye/

bookworm:
	docker build -t vitexsoftware/debian:testing -t vitexsoftware/debian:bookworm -f debian:bookworm/Dockerfile debian:bookworm/

focal:
	docker build -t vitexsoftware/ubuntu:latest -t vitexsoftware/ubuntu:focal -f ubuntu:focal/Dockerfile ubuntu:focal/

hirsute:
	docker build -t vitexsoftware/ubuntu:stable -t vitexsoftware/ubuntu:hirsute -f ubuntu:hirsute/Dockerfile ubuntu:hirsute/

impish:
	docker build -t vitexsoftware/ubuntu:rolling -t vitexsoftware/ubuntu:impish -f ubuntu:impish/Dockerfile ubuntu:impish/

update:
	ansible-playbook 

clean:
	docker system prune -a -f
	docker rmi $$(docker images 'vitexsoftware/debian:buster' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:bullseye' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:bookworm' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:focal' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:hirsute' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:impish' -a -q)

reset: clean all

push:
	docker push vitexsoftware/debian:buster
	docker push vitexsoftware/debian:bullseye
	docker push vitexsoftware/debian:bookworm
	docker push vitexsoftware/ubuntu:focal
	docker push vitexsoftware/ubuntu:hirsute
	docker push vitexsoftware/ubuntu:impish

publish: all push

