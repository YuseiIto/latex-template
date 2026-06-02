NPM := npm
IMAGE_NAME:= yuseiito/texlive-ubuntu:latest

SOURCE_DIR:= src
SOURCE := $(SOURCE_DIR)/**/*.tex $(SOURCE_DIR)/*.tex
ENTRYPOINTS:= main

DOCS := *.md

DOCKER := docker
DOCKER_RUN:= $(DOCKER) run -v $(PWD)/src:/workdir --rm $(IMAGE_NAME)
# 依存解決(再コンパイル回数・bibtex 実行)は latexmk に委ねる。設定は src/.latexmkrc。
LATEXMK := $(DOCKER_RUN) latexmk -lualatex -shell-escape

.PHONY: setup
setup:
	$(NPM) install
	$(MAKE) image

.PHONY: image
image:
	$(MAKE) .image-built

.image-built: Dockerfile
	$(DOCKER) build -t $(IMAGE_NAME) .
	touch .image-built

.PHONY: test
test:
	$(NPM) run lint $(SOURCE) $(DOCS)

.PHONY: format
format:
	$(NPM) run lint:fix $(SOURCE) $(DOCS)

.PHONY: all
all: .image-built
	$(LATEXMK) $(ENTRYPOINTS)

.PHONY: clean
clean:
	@if [ -f .image-built ]; then $(LATEXMK) -C $(ENTRYPOINTS); fi
	rm -f .image-built
