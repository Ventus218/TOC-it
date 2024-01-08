#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

INTERACTIVE_MODE=false
if which "sudo" > /dev/null; then
    SUDO="sudo "
else
    SUDO=""
fi


echoError() { echo -e "${red}$1${reset}" >&2; }
echoMessage() { echo -e "${cyan}$1${reset}"; }
echoWarning() { echo -e "${yellow}$1${reset}" >&2; }


echoMessage "\nThis script is going to prepare the development environment for TOC-it"

# ****** DEPENDENCIES INSTALL ******

DEPENDENCIES="curl node browserify uglifyjs"
DEPENDENCIES_TO_INSTALL=""

for DEP in ${DEPENDENCIES}; do
    if ! which "${DEP}" > /dev/null; then
        DEPENDENCIES_TO_INSTALL="${DEPENDENCIES_TO_INSTALL}${DEP} " # trailing space is mandatory
    fi
done

if [ -n "$DEPENDENCIES_TO_INSTALL" ]; then
    echoMessage "The following dependencies need to be installed:"
    for DEP in ${DEPENDENCIES_TO_INSTALL}; do echo -e "${yellow}\t* ${DEP}${reset}"; done

    if [ "${OSTYPE}" != "linux-gnu" ]; then
        echoWarning "Automatic dependency install in only available on gnu-linux systems."
        echoWarning "You should manually install those dependencies and then run again this script."
        exit 1
    fi

    if [ "${INTERACTIVE_MODE}" = true ]; then
        echoMessage "These can be installed automatically (via apt) or you can stop the script (^C), install them manually and then run again the script."
        
        read -p "${cyan}Do you want to proceed with automatic install? y/n: ${reset}" INSTALL_DEPENDENCIES
        if [[ "$INSTALL_DEPENDENCIES" != y && "$INSTALL_DEPENDENCIES" != n ]]; then echoError "Unvalid input. Aborting..."; exit 1; fi

        if [[ "$INSTALL_DEPENDENCIES" == n ]]; then
            echoMessage "Exiting..."; exit 0
        fi
    fi

    if ! which apt > /dev/null; then echoError "Can't find apt. Aborting..."; exit 1; fi

    echoMessage "Running \"${SUDO}apt update\""
    if ! ${SUDO}apt update; then echoError "Something went wrong while running apt update. Aborting..."; exit 1; fi

    for DEP in ${DEPENDENCIES_TO_INSTALL}; do
        echoMessage "Installing ${DEP}..."
        case $DEP in
            "node")
                echoMessage "Running node install script: https://github.com/nodesource/distributions#using-ubuntu"
                # https://github.com/nodesource/distributions#using-ubuntu
                curl -fsSL https://deb.nodesource.com/setup_21.x | ${SUDO}bash - &&\
                ${SUDO}apt-get install -y nodejs
                which npm > /dev/null
                ;;
            "browserify")
                echoMessage "Running \"npm install -g browserify\""
                npm install -g browserify
                which browserify > /dev/null
                ;;
            "uglifyjs")
                echoMessage "Running \"npm install -g uglify-js\""
                npm install -g uglify-js
                which uglifyjs > /dev/null
                ;;
            *)
                echoMessage "Running \"${SUDO}apt install ${DEP}\""
                ${SUDO}apt install -y ${DEP}
                ;;
        esac
        if [[ $? != 0 ]]; then echoError "Something went wrong installing ${DEP}. Aborting..."; exit 1; fi
        echo
    done
fi

echoMessage "Done!"
exit 0
