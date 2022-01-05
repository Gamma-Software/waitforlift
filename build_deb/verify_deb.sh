#!/bin/bash
echo -e "Version to verify: $1"

# Change dir to the script location
cd build_deb
. ./common # import common variables and functions

# Name of the deb package to verify
DEBFOLDERNAME=${PCK_NAME}_${1}-${REVISION}_${ARCHITECTURE}

# Check that the deb package correctly created
if [ $DEBFOLDERNAME.deb ]; then
    success_msg "1/8 The deb package has been created -> OK"
else
    error_exit "1/8 Deb package not created -> FAIL" 1
fi

# Install the deb package
dpkg -i $DEBFOLDERNAME.deb
if [ $? -eq 0 ]; then
    success_msg "2/8 The deb package has been installed -> OK"
else
    error_exit "2/8 Deb package not installed -> FAIL" 2
fi

# Verify that the auto completion has been correctly installed and the auto completion is working
if [ -f $SOURCEBINPATH/${SOURCEBIN} ]; then
    success_msg "3/8 The script has been installed -> OK"
else
    error_exit "3/8 Script not installed -> FAIL" 3
fi

source ~/.bashrc
complete | grep -q waitforlift
if [ $? -eq 0 ]; then
    success_msg "4/8 The autocompletion has been installed -> OK"
else
    error_exit "4/8 Autocompletion not installed -> FAIL" 4
fi


# Make sure the deb package is correctly installed
dpkg -l | grep -q $PCK_NAME
if [ $? -eq 0 ] ; then
    success_msg "5/8 The deb package is installed -> OK"
else
    error_exit "5/8 The deb package is not installed -> FAIL" 5
fi

# Remove the deb package
dpkg -P $PCK_NAME
if [ $? -eq 0 ]; then
    success_msg "6/8 The deb package has been uninstalled -> OK"
else
    error_exit "6/8 Deb package not uninstalled -> FAIL" 6
fi

# Make sure the deb package is removed
dpkg -l | grep -q $PCK_NAME
if [ $? -eq 1 ] ; then
    success_msg "7/8 The deb package is removed after uninstallation-> OK"
else
    error_exit "7/8 The deb package is not removed after uninstallation-> FAIL" 7
fi

# Make sure the auto completion is removed
source ~/.bashrc
complete | grep -q waitforlift
if [ $? -eq 1 ]; then
    success_msg "8/8 The autocompletion is removed -> OK"
else
    error_exit "8/8 The script is not removed -> FAIL" 8
fi