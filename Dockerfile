# Based on Ubuntu 14.04 Trust Tahr base image
FROM ubuntu:trusty

MAINTAINER Michael Snell <michael@snell.com>

# Configure apt to make Oracle Java available, upgrade, update, and install additional packages
RUN apt-get -y install software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y -q dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y -q upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y -q install \
        firefox \
        git \
        lxterminal \
        maven \
        vim && \
    apt-get clean && \
    ln -s /usr/bin/vim /usr/bin/emacs

# Install Java 8, accepting the license, and set up env variables and Java defaults
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get -y -q install \
        oracle-java8-installer \
        oracle-java8-set-default && \
    apt-get clean && \
    update-java-alternatives -s java-8-oracle

# Install IntelliJ IDEA and add convenience start script
RUN wget http://download.jetbrains.com/idea/ideaIC-14.1.tar.gz -O /tmp/intellij.tar.gz -q && \
    mkdir -p /opt/intellij && \
    tar -xf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij && \
    rm /tmp/intellij.tar.gz
COPY idea.sh /usr/bin/idea

# Mark dev user home as data volume
VOLUME /home/$USERNAME

# Create "dev" user with "dev" password and grant passwordless sudo permission
ENV USERNAME dev
RUN adduser --disabled-password --gecos '' $USERNAME && \
    echo dev:dev | chpasswd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sudo adduser dev sudo

# Start an X terminal as dev user
USER $USERNAME
WORKDIR /home/$USERNAME
ENTRYPOINT lxterminal
