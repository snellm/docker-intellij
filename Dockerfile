# Based on Ubuntu 14.04 Trust Tahir base image
FROM ubuntu:trusty

MAINTAINER michael@snell.com

# Hide some noise from apt
ENV DEBIAN_FRONTEND noninteractive

# Use add-apt-repository (which requires software-properties-common) to add webupd8team, since Java 8 is not available
# from Ubuntu directly, and then update and upgrade current packages
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
RUN apt-get -y upgrade

# Install additional packages
RUN apt-get -y install lxterminal # xterm replacement
RUN apt-get -y install vim # Vim editor
RUN apt-get -y install git # Git version control
RUN apt-get -y install maven # Maven build tool
# TODO Chromium?

# Sensible defaults
RUN ln -s /usr/bin/vim /usr/bin/emacs

# Install Java 8, accepting the license, and set up env variables and Java defaults
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer
RUN apt-get -y install oracle-java8-set-default
RUN update-java-alternatives -s java-8-oracle

# Install IntelliJ
# TODO Use ADD instead of wget
RUN wget http://download.jetbrains.com/idea/ideaIC-14.0.3.tar.gz -O /tmp/intellij.tar.gz -q && \
    echo 'Installing IntelliJ IDEA' && \
    mkdir -p /opt/intellij && \
    tar -xf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij && \
    rm /tmp/intellij.tar.gz
# TODO Create idea command to run it

# TODO Docker file syntax highlighting
# TODO Use ADD instead of wget
# wget -O ~/.IdeaIC14/config/filetypes/Dockerfile.xml https://raw.githubusercontent.com/masgari/docker-intellij-idea/master/Dockerfile.xml
ADD https://raw.githubusercontent.com/masgari/docker-intellij-idea/master/Dockerfile.xml ~/.IdeaIC14/config/filetypes/Dockerfile.xml


# Create dev user
ENV USERNAME dev
RUN adduser --disabled-password --gecos '' $USERNAME

# Mark dev user home as data volume
VOLUME /home/$USERNAME

# Reset DEBIAN_FRONTEND
ENV DEBIAN_FRONTEND=newt

# Start an X terminal as dev user
USER $USERNAME
WORKDIR /home/$USERNAME
CMD lxterminal
