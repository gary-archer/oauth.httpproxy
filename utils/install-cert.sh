#!/bin/bash

###############################################################################################
# A script to trust the mitmproxy root CA, which requires the proxy to be running and activated
###############################################################################################

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ..

echo 'Trusting the mitmproxy root certificate ...'
if [ "$PLATFORM" == 'windows' ]; then

  #
  # On Windows use the certutil tool to add certificate trust
  #
  certutil.exe -addstore root ~/.mitmproxy/mitmproxy-ca-cert.cer 1>/dev/null

elif [ "$PLATFORM" == 'linux' ]; then
    
  #
  # On Linux use the update-ca-certificates tool to add certificate trust
  #
  sudo cp ~/.mitmproxy/mitmproxy-ca-cert.pem /usr/local/share/ca-certificates/mitmproxy-ca-cert.crt
  sudo update-ca-certificates
  
else

  #
  # On macOS use the security tool to add certificate trust
  #
  sudo security add-trusted-cert -d -p ssl -p basic -k /Library/Keychains/System.keychain ~/.mitmproxy/mitmproxy-ca-cert.pem
fi
if [ $? -ne 0 ]; then
  echo 'Problem encountered trusting the mitmproxy root CA'
  exit 1
fi

#
# Also copy the certificate to the desktop so that it can be configured in other trust stores
#
cp ~/.mitmproxy/mitmproxy-ca-cert.pem ~/Desktop/
