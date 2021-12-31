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