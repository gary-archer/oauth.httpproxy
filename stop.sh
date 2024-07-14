#!/bin/bash

############################################################
# A script to deactivate mitmproxy after it has been stopped
############################################################

cd "$(dirname "${BASH_SOURCE[0]}")"

./utils/deactivate.sh
