# Based on Ubuntu 14.04 Trust Tahr base image
FROM ubuntu:trusty

MAINTAINER michael@snell.com

# Use add-apt-repository (which requires software-properties-common) to add webupd8team, since Java 8 is not available
# from Ubuntu directly, and then update and upgrade current packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:webupd8team/java
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Install additional packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install lxterminal # xterm replacement
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim # Vim editor
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git # Git version control
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install maven # Maven build tool
# TODO Chrome stable?

# Sensible defaults
RUN ln -s /usr/bin/vim /usr/bin/emacs

# Install Java 8, accepting the license, and set up env variables and Java defaults
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-installer
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-set-default
RUN update-java-alternatives -s java-8-oracle

# Install IntelliJ IDEA and add convenience start script
ADD http://download.jetbrains.com/idea/ideaIC-14.0.3.tar.gz /tmp/intellij.tar.gz
RUN mkdir -p /opt/intellij && \
    tar -xf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij && \
    rm /tmp/intellij.tar.gz
COPY idea.sh /usr/bin/idea

# Mark dev user home as data volume
VOLUME /home/$USERNAME

# Create "dev" user with "dev" password and grant passwordless sudo permission
ENV USERNAME dev
RUN adduser --disabled-password --gecos '' $USERNAME
RUN echo dev:dev | chpasswd
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN sudo adduser dev sudo

# Start an X terminal as dev user
USER $USERNAME
WORKDIR /home/$USERNAME
ENTRYPOINT lxterminal
