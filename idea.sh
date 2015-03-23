#!/usr/bin/env bash

#
# Convinience start script for IntelliJ IDEA
#

# Install syntax highligting for Docker files if not present
if [ ! -f ~/.IdeaIC14/config/filetypes/Dockerfile.xml ]; then
    wget -O -q ~/.IdeaIC14/config/filetypes/Dockerfile.xml https://raw.githubusercontent.com/masgari/docker-intellij-idea/master/Dockerfile.xml
fi

# Start IDEA with all output redirected
/opt/intellij/bin/idea.sh &> /tmp/idea.log &
