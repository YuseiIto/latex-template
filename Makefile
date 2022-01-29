NPM := npm
IMAGE_NAME:= yuseiito/texlive-ubuntu:latest

SOURCE_DIR:= src
SOURCE := $(SOURCE_DIR)/*.tex
MAIN_FILE:= main

DOCKER := docker
DOCKER_RUN:= $(DOCKER) run -v $(PWD)/src:/workdir --rm $(IMAGE_NAME) 


.PHONY: setup
setup:
	$(NPM) install
	$(MAKE) build-image


.PHONY: image
image:
	$(MAKE) .image-built

.image-built: Dockerfile
	$(DOCKER) build -t $(IMAGE_NAME) .
	touch .image-built

.PHONY: test
test:
	$(NPM) run lint $(SOURCE)

.PHONY: format
format:
	$(NPM) run lint:fix $(SOURCE)

main.pdf: .image-built
	$(DOCKER_RUN) lualatex main.tex

.PHONY: all
all: main.pdf

.PHONY: clean
clean:
	rm src/*.aux src/*.log src/*.pdf .image-built
