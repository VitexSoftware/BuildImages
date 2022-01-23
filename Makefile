all: stretch buster bullseye bookworm focal hirsute impish

stretch:
	docker build -t vitexsoftware/debian:lts -t vitexsoftware/debian:stretch  -f stretch/Dockerfile stretch/

buster:
	docker build -t vitexsoftware/debian:oldstable -t vitexsoftware/debian:buster -f buster/Dockerfile buster/

bullseye:
	docker build -t vitexsoftware/debian:stable -t vitexsoftware/debian:bullseye   -f bullseye/Dockerfile bullseye/

bookworm:
	docker build -t vitexsoftware/debian:testing -t vitexsoftware/debian:bookworm -f bookworm/Dockerfile bookworm/

focal:
	docker build -t vitexsoftware/ubuntu:latest -t vitexsoftware/ubuntu:focal -f focal/Dockerfile focal/

hirsute:
	docker build -t vitexsoftware/ubuntu:stable -t vitexsoftware/ubuntu:hirsute -f hirsute/Dockerfile hirsute/

impish:
	docker build -t vitexsoftware/ubuntu:rolling -t vitexsoftware/ubuntu:impish -f impish/Dockerfile impish/


clean:
	docker system prune -a -f
	docker rmi $$(docker images 'vitexsoftware/debian:lts' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:oldstable' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:stable' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:testing' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:stable' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:testing' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:rolling' -a -q)

reset: clean all

push:
	docker push vitexsoftware/debian:lts
	docker push vitexsoftware/debian:oldstable
	docker push vitexsoftware/debian:stable
	docker push vitexsoftware/debian:testing
	docker push vitexsoftware/debian:rolling
	docker push vitexsoftware/ubuntu:stable
	docker push vitexsoftware/ubuntu:testing

publish: all push

