#!/bin/bash

######################################################################################
# A script to run mitmproxy, activate the system proxy and open mitmweb in the browser
######################################################################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Get the platform
#
export PLATFORM='linux'

#
# Install if required
#
INSTALL='false'
if [ ! -f ./mitmproxy ]; then
  INSTALL='true'
  ./utils/install.sh
  if [ $? -ne 0 ]; then
    exit 1
  fi
fi

#
# Run the HTTP proxy in a second terminal window
#
PID=$(pgrep mitmweb)
if [ "$PID" == '' ]; then
  gnome-terminal -- ./utils/run.sh
  if [ $? -ne 0 ]; then
    exit 1
  fi
fi

#
# Activate the system to use MITM
#
. ./utils/activate.sh
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..

#
# Get the root CA when installing the proxy
#
if [ "$INSTALL" == 'true' ]; then
  ./utils/install-cert.sh
  if [ $? -ne 0 ]; then
    exit 1
  fi
fi

#
# Run mitmweb in the default system browser
#
echo 'Opening mitmweb in the system browser ...'
xdg-open 'http://127.0.0.1:8889'
