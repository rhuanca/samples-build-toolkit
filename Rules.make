#platform
PLATFORM=omapl138-lcdk

#Architecture
ARCH=armv5te

#u-boot machine
UBOOT_MACHINE=omapl138_lcdk_config

#Points to the root of the TI SDK
export TI_SDK_PATH=/root/ti-sdk-omapl138-lcdk-01.00.00

#root of the target file system for installing applications
DESTDIR=/arm9NFS

#Points to the root of the Linux libraries and headers matching the
#demo file system.
export LINUX_DEVKIT_PATH=$(TI_SDK_PATH)/linux-devkit

#Cross compiler prefix
export CROSS_COMPILE=$(LINUX_DEVKIT_PATH)/bin/arm-arago-linux-gnueabi-

#Location of environment-setup file
export ENV_SETUP=$(LINUX_DEVKIT_PATH)/environment-setup

#The directory that points to the SDK kernel source tree
LINUXKERNEL_INSTALL_DIR=$(TI_SDK_PATH)/board-support/linux-3.1.10_lcdk_v0

