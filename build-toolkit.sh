#!/bin/sh
SDK_FILE=ti-sdk-omapl138-lcdk-01.00.00.bz2
if [ ! -f "$SDK_FILE" ] 
then
  wget http://software-dl.ti.com/dsps/dsps_public_sw/c6000/web/omapl138_lcdk_sdk/latest/exports/$SDK_FILE
fi


