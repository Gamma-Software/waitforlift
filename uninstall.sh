#!/bin/bash

# return error if script is not run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Uninstalling waitforlift script..."
echo "Removing waitforlift script from /usr/bin..."

# return eror if waitforlift script is not installed
if [ ! -f /usr/bin/waitforlift ]; then
   echo "waitforlift script is not installed" 1>&2
   exit 1
else
    rm /usr/bin/waitforlift
fi

# remove the completion if it exists
echo "uninstall autocompletion capabilities for waitforlift script"
if [ -f /etc/bash_completion.d/waitforlift ]; then
   rm /etc/bash_completion.d/waitforlift
fi

echo "log out -> log to finish the uninstallation"
echo "or run 'source ~/.bashrc'"