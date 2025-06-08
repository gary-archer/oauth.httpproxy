#!/bin/bash

######################################################################################
# A script to run mitmproxy, activate the system proxy and open mitmweb in the browser
######################################################################################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Get the platform
#
case "$(uname -s)" in

  Darwin)
    export PLATFORM='macos'
 	;;

  MINGW64*)
    export PLATFORM='windows'
	;;

  Linux)
    export PLATFORM='linux'
	;;
esac

#
# Check whether we need to do an install
#
INSTALL='false'
if [ "$PLATFORM" == 'macos' ]; then
  mitmproxy --version 1>/dev/null
else 
  ./mitmproxy --version 1>/dev/null
fi
if [ $? -ne 0 ]; then
  INSTALL='true'
fi

#
# Install if required
#
if [ "$INSTALL" == 'true' ]; then
  ./utils/install.sh
  if [ $? -ne 0 ]; then
    exit 1
  fi
fi

#
# Run the HTTP proxy in a second terminal window
#
if [ "$PLATFORM" == 'macos' ]; then

  open -a Terminal ./utils/run.sh

elif [ "$PLATFORM" == 'windows' ]; then
  
  GIT_BASH="C:\Program Files\Git\git-bash.exe"
  "$GIT_BASH" -c ./utils/run.sh &

elif [ "$PLATFORM" == 'linux' ]; then

  gnome-terminal -- ./utils/run.sh
fi
sleep 5

#
# Install the root certificate if required
#
if [ "$INSTALL" == 'true' ]; then
  ./utils/install-cert.sh
  if [ $? -ne 0 ]; then
    exit 1
  fi
fi

#
# Activate the mitmproxy
#
./utils/activate.sh
if [ $? -ne 0 ]; then
  exit 1
fi

