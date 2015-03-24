#!/usr/bin/env bash

#
# Convenience start script for Google Chrome
#

# TODO This is neccesary because of a POSIX file system error when writing to ~/.config/ - fix
google-chrome --user-data-dir=/tmp/google-chrome/ &> /tmp/google-chrome.log &
