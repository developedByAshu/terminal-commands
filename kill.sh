#!/bin/bash

pkill --oldest chrome
# pkill mattermost
# pkill mailspring
pkill nautilus
pkill Discord
pkill postman
# pkill slack
# pkill xdman
pkill java
pkill zoom
pkill code
pkill kontena-lens
# (xdotool key --clearmodifiers "alt+s" && wmctrl -a "carbon");
#pkill carbon

kill -25 $PPID
