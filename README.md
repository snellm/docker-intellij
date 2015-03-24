# Overview

This project defines a Docker image that allows development in an Ubuntu VM using IntelliJ IDEA, Java 8, Git and Maven,
accessed via X (typically from a Windows workstation).

# Running from Windows

## Initial setup

- Install [Docker for Windows](https://docs.docker.com/installation/windows/).
- Install an X client, such as [MobaXTerm](http://mobaxterm.mobatek.net/). NB ensure that the X client access control
is disabled - this is the default on MobaXTerm, but eg XMing needs to be run with the -ac option.

## Starting

- Ensure X client is running.
- Run "Boot2Docker Start". This will open a Boot2Docker window.
- Run the following command in the Boot2Docker window, substituting &lt;DISPLAY&gt; and &lt;USERNAME&gt;:
`docker run -d -e DISPLAY=<DISPLAY>; -v /c/Users/<USERNAME>/Docker-IntelliJ:/home/dev snellm/intellij`
  - &lt;DISPLAY&gt; is the X client display address. Typically this will be your workstation IP address plus ":0.0".
  - &lt;USERNAME&gt; is your Windows username. This path is used to persist the dev users home directory between restarts
of the VM.
- A terminal windows should open on your desktop from the VM. To start IntelliJ IDEA, run "idea".