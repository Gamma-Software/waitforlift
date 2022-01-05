#!/bin/bash

# return error if script is not run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Installing waitforlift script..."
echo "Copying waitforlift script to /usr/bin..."

# return error if script already exists
if [ -f /usr/bin/waitforlift ]; then
   echo "waitforlift script already exists" 1>&2
   exit 1
else
    cp waitforlift /usr/bin/waitforlift
fi

echo "install autocompletion capabilities for waitforlift script"
# create the bash-completion folder if needed
if [ ! -d /etc/bash_completion.d ]; then
    mkdir -p /etc/bash_completion.d
fi

# Permits the autocompletion of the waitforlift command
echo "complete -F _command waitforlift" > /etc/bash_completion.d/waitforlift

source ~/.bashrc