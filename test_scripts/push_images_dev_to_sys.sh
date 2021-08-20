#!/bin/sh

#############################################################_Description_#############################################################
#First program will push images from system to device, SYS_INPUT_IMAGE_DIR , DEVICE_INPUT_IMAGE_DIR
#######################################################################################################################################

#adb kill-server
#sudo adb start-server
#adb root

DEVICE_INPUT_IMAGE_DIR=/sdcard/DCIM/Camera/.
SYS_INPUT_IMAGE_DIR=/home/jaruko/Projects/tflite/play_with_tflite/arm_test_images


#1.push Images form device to system
echo "-------------------------------- pulling all images to system --------------------------------"
adb pull  $DEVICE_INPUT_IMAGE_DIR $SYS_INPUT_IMAGE_DIR
echo "-------------------------------- all images are pulled successfully --------------------------------"
echo ""
echo "images are stored in path: $SYS_INPUT_IMAGE_DIR"
