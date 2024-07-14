#!/bin/bash

###############################################################################################
# A script to trust the mitmproxy root CA, which requires the proxy to be running and activated
###############################################################################################

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ..

echo 'Trusting the mitmproxy root certificate ...'
if [ "$PLATFORM" == 'windows' ]; then

  #
  # On Windows, use the certutil tool to add certificate trust
  #
  certutil.exe -addstore root ~/.mitmproxy/mitmproxy-ca-cert.cer 1>/dev/null
  if [ $? -ne 0 ]; then
    echo 'Problem encountered trusting the mitmproxy root CA'
    exit 1
  fi
else

  #
  # On other platforms, download the root certificate
  #
  DOWNLOAD_URL='http://mitm.it/cert/pem'
  FILENAME='./mitmproxy-root.crt'
  if [ "$(curl -sw '%{http_code}' $DOWNLOAD_URL -o $FILENAME)" != '200' ]; then
    echo 'Problem encountered downloading the mitmproxy root CA'
    exit 1
  fi

  #
  # Then update the system trust store
  #
  sudo cp $FILENAME /usr/local/share/ca-certificates/
  sudo update-ca-certificates
  if [ $? -ne 0 ]; then
    echo 'Problem encountered trusting the mitmproxy root CA'
    exit 1
  fi
fi
