# Overview

This project defines a Docker image that allows development in an Ubuntu VM using IntelliJ IDEA, Java 8, Git, Maven etc,
accessed via X (typically from a Windows workstation).

# Running from Windows

## Initial setup

- Install [Docker for Windows](https://docs.docker.com/installation/windows/).
- Install an X client, such as [MobaXTerm](http://mobaxterm.mobatek.net/). NB ensure that the X client access control
is disabled - this is the default on MobaXTerm, but eg XMing needs to be run with the -ac option.

## Starting

- Ensure X client is running.
- Run "Boot2Docker Start" - this will open a Boot2Docker console.
- Run the following command in the Boot2Docker console, substituting &lt;DISPLAY&gt; and &lt;USERNAME&gt;:    
`docker run -d -e DISPLAY=<DISPLAY> -v /c/Users/<USERNAME>/Docker-IntelliJ:/home/dev -name intellij snellm/intellij`
  - &lt;DISPLAY&gt; is the X client display address. Typically this will be your workstation IP address plus ":0.0".
  - &lt;USERNAME&gt; is your Windows username. This path is used to persist the VM "dev" users home directory between
  restarts.
- A terminal window should open on your desktop from the VM. To start IntelliJ IDEA, run "idea". To start Google Chrome,
run "chrome".

# Notes

- The VM is based on Ubuntu 14.04 (Trusty Tahr) with Oracle Java 8 and IntelliJ IDEA 14.1 Community Edition added.
- Development is as the "dev" user, password "dev".
- Passwordless sudo rights have been granted to the the "dev" user, but note that any changes made outside of the "dev"
users home directory will be lost between restarts.
- The "dev" users home directory (/home/dev) is mapped to the host path set when starting, so will be preserved between
restarts and even if Docker is for Windows is uninstalled/reinstalled.

# Caveats

- Not extensively tested.
- If running inside Boot2Docker on Windows:
  - Memory is limited to the size of the Boot2Docker VirtualBox VM (default to 2GB).
  - An issue with mounting /home/dev to Windows causes problems with Chrome and Firefox profile creation.