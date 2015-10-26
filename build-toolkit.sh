#!/bin/sh

#
# Get and uncompress sdk file
#

if [ ! -d "ti-sdk-omapl138-lcdk-01.00.00" ]
then 
  echo "TI SDK folder not found."  
  SDK_FILE=ti-sdk-omapl138-lcdk-01.00.00.bz2
  if [ ! -f "$SDK_FILE" ] 
  then
    echo "Getting from web TI SDK"
    wget http://software-dl.ti.com/dsps/dsps_public_sw/c6000/web/omapl138_lcdk_sdk/latest/exports/$SDK_FILE
  fi
  echo "Unpacking TI SDK"
  tar jxf $SDK_FILE
fi

echo "Building toolkit"
docker build -t mymstar/toolkit .
