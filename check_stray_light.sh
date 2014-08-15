#!/bin/bash
# Runs a check to see if the NuSTAR FoV is contaminated by stray light.
#
# Usage: check_stray_light RA DEC PA
#
# Brian Grefenstette, August 2014, Caltech
#


usage()
{
cat << EOF
usage: $0 RA DEC PA

All values must be in decimal degrees.

Example:
check_stray_light.sh 204.254 -29.8654 10

EOF
}

if [ "$#" -ne 3 ]; then
    usage
    exit 1
fi

# Record inputs=
export CHECK_RA=$1
export CHECK_DEC=$2
export CHECK_PA=$3

# Set the IDL startup script to point to the nustar-idl direcotry:
##### Change this for your own build!!! ###
CHECK_DIR=/home/nustar1/Web/NuSTAROperationSite/Operations/check_stray_light
##############################
export IDL_STARTUP=$CHECK_DIR/check_stray_startup.pro


# Check to make sure this file exists:
if [ ! -f $IDL_STARTUP ]
then
    echo "Change the IDL_STARTUP environment variable in $0 first!"
    echo "$IDL_STARTUP does not exist!"
    exit 1
fi

idl -quiet check_stray_light.bat
