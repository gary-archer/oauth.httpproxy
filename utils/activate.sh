#!/bin/bash

########################################
# A script that activates the HTTP proxy
########################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Prompt the user to safely update the network proxy settings to use mitmproxy
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

  echo "You must update your network connection settings under 'Proxy'"
  echo " - Set 'Configuration' to 'Manual'"
  echo " - Set 'HTTP Proxy' to 'URL=127.0.0.1' and 'Port=8888'"
  echo " - Set 'HTTPS Proxy' to 'URL=127.0.0.1' and 'Port=8888'"
  gnome-control-center network
fi
