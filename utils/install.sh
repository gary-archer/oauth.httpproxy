#!/bin/bash

######################################################################################
# A script to download and unpack the mitmproxy binaries so that they are ready to run
######################################################################################

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ..
echo 'Checking whether mitmproxy is installed ...'

#
# On macOS I would rather use binaries but this method meets macOS code signing requirements
#
if [ $PLATFORM == 'macos' ]; then
  
  brew install mitmproxy
  if [ $? -ne 0 ]; then
    exit 1
  fi
  exit 0
fi

#
# Get platform specific values
#
if [ $PLATFORM == 'windows' ]; then
  ARCH='x86_64'
  EXT='zip'
elif [ $PLATFORM == 'linux' ]; then
  ARCH='x86_64'
  EXT='tar.gz'
fi

#
# Download the zip file
#
VERSION='11.1.2'
FILENAME="mitmproxy-$VERSION-$PLATFORM-$ARCH.$EXT"
rm $FILENAME 2>/dev/null
DOWNLOAD_URL="https://downloads.mitmproxy.org/$VERSION/$FILENAME"
echo "Downloading the mitmproxy release from $DOWNLOAD_URL ..."
if [ "$(curl -sw '%{http_code}' $DOWNLOAD_URL -o $FILENAME)" != '200' ]; then
  echo 'Problem encountered downloading the mitmproxy release'
  exit 1
fi

#
# Unzip files
#
echo 'Unzipping mitmproxy files ...'
if [ $PLATFORM == 'windows' ]; then
  unzip $FILENAME
else
  tar xf $FILENAME
fi
if [ $? -ne 0 ]; then
  echo 'Problem encountered unpacking the mitmproxy package'
  exit 1
fi
rm $FILENAME
