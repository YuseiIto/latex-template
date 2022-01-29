DOCKER := docker
NPM := npm
SOURCE := src/*.tex
IMAGE_NAME:= yuseiito/texlive-ubuntu:latest

.PHONY: image
image: Dockerfile
	$(DOCKER) build -t $(IMAGE_NAME) .

.PHONY: setup
setup:
	$(NPM) install
	$(MAKE) build-image

.PHONY: test
test:
	$(NPM) lint $(SOURCE)

.PHONY: format
format:
	$(NPM) run lint:fix $(SOURCE)
