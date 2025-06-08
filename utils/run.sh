#!/bin/bash

#########################################################
# A script to run the mitmproxy so that output is visible
#########################################################

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ..

echo 'Running mitmproxy ...'
if [ "$(uname -s)" == 'Darwin' ]; then
  mitmweb -p 8888 --web-port 8889 --ssl-insecure --script init.py
else
  ./mitmweb -p 8888 --web-port 8889 --ssl-insecure --script init.py
fi
if [ $? -ne 0 ]; then
  echo 'Problem encountered running mitmproxy'
  read -n 1
  exit 1
fi
