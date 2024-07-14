#!/bin/bash

###################################################################################
# A script to run the mitmproxy in a new terminal window, so that output is visible
###################################################################################

cd "$(dirname "${BASH_SOURCE[0]}")"

echo 'Starting the mitmproxy ...'
sudo ../mitmweb -p 8888 --web-port 8889 --ssl-insecure
if [ $? -ne 0 ]; then
  echo 'Problem encountered running mitmproxy'
  read -n 1
  exit 1
fi
