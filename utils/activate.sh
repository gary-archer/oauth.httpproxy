#!/bin/bash

########################################
# A script that activates the HTTP proxy
########################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Update the network proxy to use mitmproxy
#
echo 'Updating the network connection to use mitmproxy ...'

if [ "$PLATFORM" == 'macos' ]; then

  echo 'macos activate'

elif [ "$PLATFORM" == 'windows' ]; then
    
  #
  # On Windows there does not seem to be a safe automated way to change proxy settings
  #
  echo '*** On Windows you must set values under Manual proxy setup ***'
  start ms-settings:network-proxy

elif [ "$PLATFORM" == 'linux' ]; then

  #
  # On Linux we use the gnome settings
  #
  gsettings set org.gnome.system.proxy mode manual
  gsettings set org.gnome.system.proxy.http host 127.0.0.1
  gsettings set org.gnome.system.proxy.https host 127.0.0.1
  gsettings set org.gnome.system.proxy.http port 8888
  gsettings set org.gnome.system.proxy.https port 8888
fi
if [ $? -ne 0 ]; then
  echo 'Problem encountered activating mitmproxy'
  exit
fi
