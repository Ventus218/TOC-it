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
cd "${SCRIPT_DIR}"

if ! which npm > /dev/null; then
    echoError "npm is missing, have you run the setup script (\"./setup.sh\") for installing TOC-it dependencies?"
    exit 1
fi

if ! npm install; then
    echoError "Something went wrong while installing dependencies through npm install"
    exit 1
fi

if ! which browserify > /dev/null; then
    echoError "Browserify is missing, have you run the setup script (\"./setup.sh\") for installing TOC-it dependencies?"
    exit 1
fi

if ! browserify "index.js" -o "bundle.js"; then
    echoError "Something went wrong while browserifying the index.js file"
    exit 1
fi

if ! which uglifyjs > /dev/null; then
    echoError "Uglifyjs is missing, have you run the setup script (\"./setup.sh\") for installing TOC-it dependencies?"
    exit 1
fi

if ! uglifyjs --compress --mangle -- "bundle.js" > "bundle.min.js"; then
    echoError "Something went wrong while uglifying the bundle.js file"
    exit 1
fi

if ! rm "bundle.js"; then
    echoWarning "Unable to remove temporary file bundle.js."
    echoWarning "This may not be a big problem, so the script will continue"
fi

echoMessage "Done!"
exit 0
