# Based on Ubuntu 14.04 Trust Tahir base image
FROM ubuntu:trusty

MAINTAINER michael@snell.com

# Use add-apt-repository (which requires software-properties-common) to add webupd8team, since Java 8 is not available from
# Ubuntu directly
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
RUN apt-get -y upgrade

# Install Java 8, accepting the license, and set up env variables and Java defaults
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer
RUN apt-get -y install oracle-java8-set-default
RUN update-java-alternatives -s java-8-oracle
