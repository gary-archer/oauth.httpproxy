#!/bin/bash

######################################################################################
# A script to download and unpack the mitmproxy binaries so that they are ready to run
######################################################################################

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ..

#
# Download the zip file
#
VERSION='10.3.1'
ARCH=$(uname -i)
FILENAME="mitmproxy-$VERSION-$PLATFORM-$ARCH.tar.gz"
rm $FILENAME 2>/dev/null
DOWNLOAD_URL="https://downloads.mitmproxy.org/$VERSION/$FILENAME"
echo "Downloading the mitmproxy release from $DOWNLOAD_URL ..."
if [ "$(curl -sw '%{http_code}' $DOWNLOAD_URL -o $FILENAME)" != '200' ]; then
  echo 'Problem encountered downloading the mitmproxy release'
  exit 1
fi
rm response.txt

#
# Unzip files
#
echo 'Unzipping mitmproxy files ...'
tar xf $FILENAME
if [ $? -ne 0 ]; then
  echo 'Problem encountered unzipping the mitmproxy package'
  exit 1
fi
rm $FILENAME
