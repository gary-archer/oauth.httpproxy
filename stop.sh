#!/bin/bash

############################################################
# A script to deactivate mitmproxy after it has been stopped
############################################################

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
# Deactivate the proxy
#
./utils/deactivate.sh
