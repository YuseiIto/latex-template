FROM ubuntu:latest
RUN mkdir /workdir
WORKDIR /workdir


ENV  DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y texlive-lang-japanese
RUN apt-get install -y texlive-luatex
RUN apt-get install -y texlive-latex-recommended
RUN apt-get install -y texlive-latex-extra
RUN apt-get install -y fonts-lmodern
RUN apt-get install -y texlive-xetex
RUN apt-get install -y latex-cjk-common
RUN apt-get install -y texlive-fonts-extra
RUN apt-get install -y xzdec
RUN apt-get install -y texlive-science

# For mint package
RUN apt-get install -y python3-pip
RUN pip install Pygments

CMD ["/bin/bash"]
