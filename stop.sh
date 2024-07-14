#!/bin/bash

################################################################
# A script to stop the mitmproxy and deactivate the system proxy
################################################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Reset the system proxy
#
echo 'Deactivating the system proxy ...'
gsettings set org.gnome.system.proxy mode auto
if [ $? -ne 0 ]; then
  echo 'Problem encountered deactivating mitmproxy'
  exit 1
fi

#
# Stop the existing process
#
PID=$(pgrep mitmweb)
if [ "$PID" != '' ]; then
  echo 'Stopping mitmweb ...'
  sudo kill -9 $PID
  if [ $? -ne 0 ]; then
    echo 'Problem encountered stopping mitmweb'
    exit 1
  fi
fi
