#!/bin/bash

########################################
# A script that activates the HTTP proxy
########################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Prompt the user to update the network proxy settings to use mitmproxy
#
if [ "$PLATFORM" == 'macos' ]; then

  echo "You must update your network connection settings under 'Details / Proxies'"
  echo " - Set 'Web Proxy (HTTP)' to 'Server=127.0.0.1' and 'Port=8888'"
  echo " - Set 'Secure Web Proxy (HTTP)' to 'Server=127.0.0.1' and 'Port=8888'"
  
  open /System/Library/PreferencePanes/Network.prefPane/

elif [ "$PLATFORM" == 'windows' ]; then

  echo "You must update your network connection settings under 'Manual proxy setup'"
  echo " - Set 'Use a proxy server' to 'On'"
  start ms-settings:network-proxy

elif [ "$PLATFORM" == 'linux' ]; then

  gsettings set org.gnome.system.proxy mode manual
  gsettings set org.gnome.system.proxy.http host 127.0.0.1
  gsettings set org.gnome.system.proxy.https host 127.0.0.1
  gsettings set org.gnome.system.proxy.http port 8888
  gsettings set org.gnome.system.proxy.https port 8888
fi
