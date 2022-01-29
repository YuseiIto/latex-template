FROM ubuntu:latest
RUN mkdir /workdir
WORKDIR /workdir

RUN apt-get update

ENV  DEBIAN_FRONTEND noninteractive
RUN apt-get install -y texlive-lang-japanese
RUN apt-get install -y texlive-luatex
RUN apt-get install -y texlive-latex-recommended
RUN apt-get install -y texlive-latex-extra
RUN apt-get install -y fonts-lmodern
RUN apt-get install -y texlive-xetex
RUN apt-get install -y latex-cjk-common
RUN apt-get install -y texlive-fonts-extra
RUN apt-get install -y xzdec

CMD ["/bin/bash"]
