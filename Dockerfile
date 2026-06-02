FROM ubuntu:24.04

WORKDIR /workdir

# minted は pygmentize を、本テンプレは latexmk をビルドに用いる。
# luatexja で日本語を扱うため、XeTeX や latex-cjk-common は導入しない。
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends \
        texlive-lang-japanese \
        texlive-luatex \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-fonts-extra \
        texlive-science \
        fonts-lmodern \
        latexmk \
        python3-pygments \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
