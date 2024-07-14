#!/bin/bash

#########################################################
# A script that is dot sourced to activate the HTTP proxy
#########################################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Set the system proxy used by desktop tools
#
echo 'Updating the system to use mitmproxy ...'
gsettings set org.gnome.system.proxy mode manual
gsettings set org.gnome.system.proxy.http host 127.0.0.1
gsettings set org.gnome.system.proxy.https host 127.0.0.1
gsettings set org.gnome.system.proxy.http port 8888
gsettings set org.gnome.system.proxy.https port 8888
if [ $? -ne 0 ]; then
  echo 'Problem encountered activating mitmproxy'
  exit
fi

#
# Also set the command line proxy if required
#
#export http_proxy='http://127.0.0.1:8888'
#export https_proxy='http://127.0.0.1:8888'
