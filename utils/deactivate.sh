#!/bin/bash

##########################################
# A script that deactivates the HTTP proxy
##########################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Prompt the user to safely reset their network proxy settings
#
echo 'Updating the network connection to disable mitmproxy ...'

if [ "$PLATFORM" == 'macos' ]; then

  echo "You must update your network connection settings under 'Details / Proxies'"
  echo " - Disable 'Web Proxy (HTTP)'"
  echo " - Disable 'Secure Web Proxy (HTTP)'"
  open /System/Library/PreferencePanes/Network.prefPane/

elif [ "$PLATFORM" == 'windows' ]; then
    
  echo "You must update your network connection settings under 'Manual proxy setup'"
  echo " - Set 'Use a proxy server' to 'Off'"
  start ms-settings:network-proxy

elif [ "$PLATFORM" == 'linux' ]; then

  echo "You must update your network connection settings under 'Proxy'"
  echo " - Set 'Configuration' to 'Automatic'"
  gnome-control-center network
fi
