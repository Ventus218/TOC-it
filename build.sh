#!/bin/bash

if [ -t 0 ] ; then # True if FD is opened on a terminal.
    INTERACTIVE_MODE=true

    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    cyan=$(tput setaf 6)
    reset=$(tput sgr0)
else
    INTERACTIVE_MODE=false
fi

echoError() { echo -e "${red}$1${reset}" >&2; }
echoMessage() { echo -e "${cyan}$1${reset}" >&2; }
echoWarning() { echo -e "${yellow}$1${reset}" >&2; }

SCRIPT_DIR="$(dirname "$0")"

if ! which browserify > /dev/null; then
    echoError "Browserify is missing, have you run the setup script (\"./setup.sh\") for installing TOC-it dependencies?"
    exit 1
fi

browserify "${SCRIPT_DIR}/index.js" -o "${SCRIPT_DIR}/bundle.js"

if ! which uglifyjs > /dev/null; then
    echoError "Uglifyjs is missing, have you run the setup script (\"./setup.sh\") for installing TOC-it dependencies?"
    exit 1
fi

uglifyjs --compress --mangle -- "${SCRIPT_DIR}/bundle.js" > "${SCRIPT_DIR}/bundle.min.js"
rm "${SCRIPT_DIR}/bundle.js"

echoMessage "Done!"
exit 0