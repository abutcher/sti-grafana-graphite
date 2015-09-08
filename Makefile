
IMAGE_NAME = grafana-graphite

docker-build:
	docker build -t $(IMAGE_NAME) .

squash:
	@if [ ! -f "${HOME}/.local/bin/docker-scripts" ]; then\
	    easy_install -q --user docker_py==1.2.3 docker-scripts==0.4.2;\
	fi;
	${HOME}/.local/bin/docker-scripts squash ${IMAGE_NAME}

build: docker-build squash

.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
