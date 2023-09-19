.PHONY: all

all: docker/Dockerfile docker/.tmux.conf docker/nvim/init.vim docker/nvim/docker-init.vim
	cd docker && \
	docker build -t ivy_2to3_new:latest --build-arg FROM_IMAGE="ubuntu:jammy" .

rebuild: docker/Dockerfile docker/.tmux.conf docker/nvim/init.vim docker/nvim/docker-init.vim
	cd docker && \
	docker build --no-cache -t ivy_2to3_new:latest --build-arg FROM_IMAGE="ubuntu:jammy" .
