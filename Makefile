all: stretch buster bullseye bookworm focal hirsute

stretch:
	docker build -t vitexsoftware/debian:lts -f Stretch/Dockerfile Stretch/

buster:
	docker build -t vitexsoftware/debian:oldstable -f Buster/Dockerfile Buster/

bullseye:
	docker build -t vitexsoftware/debian:stable -f Bullseye/Dockerfile Bullseye/

bookworm:
	docker build -t vitexsoftware/debian:testing -f Bookworm/Dockerfile Bookworm/

focal:
	docker build -t vitexsoftware/ubuntu:stable -f Focal/Dockerfile Focal/

hirsute:
	docker build -t vitexsoftware/ubuntu:testing -f Hirsute/Dockerfile Hirsute/

clean:
	docker system prune -a -f
	docker rmi $$(docker images 'vitexsoftware/debian:lts' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:oldstable' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:stable' -a -q)
	docker rmi $$(docker images 'vitexsoftware/debian:testing' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:stable' -a -q)
	docker rmi $$(docker images 'vitexsoftware/ubuntu:testing' -a -q)

reset: clean all

push:
	docker push vitexsoftware/debian:lts
	docker push vitexsoftware/debian:oldstable
	docker push vitexsoftware/debian:stable
	docker push vitexsoftware/debian:testing
	docker push vitexsoftware/ubuntu:stable
	docker push vitexsoftware/ubuntu:testing

publish: all push

