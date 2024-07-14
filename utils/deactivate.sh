#!/bin/bash

##########################################
# A script that deactivates the HTTP proxy
##########################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Update the network proxy to no longer use mitmproxy
#
echo 'Updating the network connection to use mitmproxy ...'

if [ "$PLATFORM" == 'macos' ]; then

  echo 'macos deactivate'

elif [ "$PLATFORM" == 'windows' ]; then
    
  #
  # On Windows there does not seem to be a safe automated way to change proxy settings
  #
  echo '*** On Windows you must deactivate using Manual proxy setup ***'
  start ms-settings:network-proxy

elif [ "$PLATFORM" == 'linux' ]; then

  #
  # On Linux we use the gnome settings
  #
  gsettings set org.gnome.system.proxy mode auto
  if [ $? -ne 0 ]; then
    echo 'Problem encountered deactivating mitmproxy'
    exit 1
  fi
fi
