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
PID=$(ps -ef | grep '[m]itmweb')
if [ "$PID" == '' ]; then
  
  if [ "$PLATFORM" == 'macos' ]; then

    open -a Terminal ./utils/run.sh

  elif [ "$PLATFORM" == 'windows' ]; then
    
    GIT_BASH="C:\Program Files\Git\git-bash.exe"
    "$GIT_BASH" -c ./utils/run.sh &

  elif [ "$PLATFORM" == 'linux' ]; then

    gnome-terminal -- ./utils/run.sh
  fi
fi

#
# Wait for the process
#
echo 'Waiting for mitmweb to be started as root ...'
while [ "$(ps -ef | grep '[m]itmweb')" == '' ]; do
  sleep 2
done

#
# Activate the mitmproxy
#
./utils/activate.sh
if [ $? -ne 0 ]; then
  exit 1
fi

#
# Install the root CA when installing the proxy
#
if [ "$INSTALL" == 'true' ]; then
  ./utils/install-cert.sh
  if [ $? -ne 0 ]; then
    exit 1
  fi
fi

#
# On operating systems where mitmweb is not opened, run it in the default system browser
#
if [ "$PLATFORM" == 'macos' ]; then

  echo 'Opening mitmweb in the system browser ...'
  open -a Terminal ./utils/run.sh

elif [ "$PLATFORM" == 'linux' ]; then

  echo 'Opening mitmweb in the system browser ...'
  gnome-terminal -- ./utils/run.sh
fi
