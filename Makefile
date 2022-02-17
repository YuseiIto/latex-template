NPM := npm
IMAGE_NAME:= yuseiito/texlive-ubuntu:latest

SOURCE_DIR:= src
SOURCE := $(SOURCE_DIR)/**/*.tex $(SOURCE_DIR)/*.tex
ENTRYPOINTS:= main.tex
BIBTEX_FILES := references.bib

DOCS := *.md

DOCKER := docker
DOCKER_RUN:= $(DOCKER) run -v $(PWD)/src:/workdir --rm $(IMAGE_NAME) 
LUATEX := $(DOCKER_RUN) lualatex --shell-escape
BIBTEX := $(DOCKER_RUN) pbibtex

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


%.aux: .image-built $(SOURCE_DIR)/%.tex
		$(LUATEX) $*
	
%.bbl: %.aux .image-built $(BIBTEX_FILES:%=$(SOURCE_DIR)/%)
	$(BIBTEX) $*
	$(LUATEX) $*

%.pdf: .image-built %.aux %.bbl
	$(LUATEX) $*

.PHONY: all
all: $(ENTRYPOINTS:%.tex=%.pdf)

.PHONY: clean
clean:
	rm -f $(ENTRYPOINTS:%.tex=$(SOURCE_DIR)/%.aux)
	rm -f $(ENTRYPOINTS:%.tex=$(SOURCE_DIR)/%.log)
	rm -f $(ENTRYPOINTS:%.tex=$(SOURCE_DIR)/%.pdf)
	rm -f $(ENTRYPOINTS:%.tex=$(SOURCE_DIR)/%.out)
	rm -f $(ENTRYPOINTS:%.tex=$(SOURCE_DIR)/%.toc)
	rm -f $(ENTRYPOINTS:%.tex=$(SOURCE_DIR)/%.bbl)
	rm -f $(ENTRYPOINTS:%.tex=$(SOURCE_DIR)/%.blg)
	rm -f .image-built
