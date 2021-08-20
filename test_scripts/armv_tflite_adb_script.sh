#!/bin/sh
############################################################IMPORTANT############################################################
#Before running this script some modification are needed in Main.cpp and semanticSegmentationEngine.cpp (ie. argc argv and directories are not set by default)
#############################################################_Description_#############################################################
#First program will push images from system to device, SYS_INPUT_IMAGE_DIR , DEVICE_INPUT_IMAGE_DIR
#Next it will execute the main file in device with the pushed images and will store the output images in DEVICE_OUTPUT_IMAGE_DIR
#filnally it will pull all the the output images to system SYS_OUTPUT_IMAGE_DIR
#######################################################################################################################################
#adb kill-server
#sudo adb start-server
#adb root

#------------------------------------------------Select PROJECT_NAME------------------------------------------------
#PROJECT_NAME=pj_tflite_ss_deeplabv3_mnv2_armv7
PROJECT_NAME=pj_tflite_ss_person_mask_armv7
#-------------------------------------------------------------------------------------------------------------------

SYS_INPUT_IMAGE_DIR=/home/jaruko/Projects/tflite/play_with_tflite/arm_test_images/.
#SYS_INPUT_IMAGE_DIR=/home/jaruko/Projects/tflite/play_with_tflite/resource/.
DEVICE_INPUT_IMAGE_DIR=/data/camera/tflite/play_with_tflite/resource/.

#---------------------------------------------Select OUTPUT_FOLDER_TYPE---------------------------------------------
#OUTPUT_FOLDER_TYPE=images
OUTPUT_FOLDER_TYPE=blur_images
#-------------------------------------------------------------------------------------------------------------------
SYS_OUTPUT_IMAGE_DIR=/home/jaruko/Projects/tflite/results/armv7_outputs/$PROJECT_NAME/$OUTPUT_FOLDER_TYPE/.
DEVICE_OUTPUT_IMAGE_DIR=/data/camera/tflite/play_with_tflite/tflite_models_output/$PROJECT_NAME/$OUTPUT_FOLDER_TYPE/.



echo "Project Name : $PROJECT_NAME"

#1. push input image into path
echo "-------------------------------- pushing all images to device --------------------------------"
adb push $SYS_INPUT_IMAGE_DIR $DEVICE_INPUT_IMAGE_DIR
echo "-------------------------------- all images are pushed successfully --------------------------------"
echo " "


#2. run main with input image path
echo "-------------------------------- Initializing TensorFlow Lite --------------------------------"
export file=`cd $SYS_INPUT_IMAGE_DIR ; ls *.jpg`
declare -a arrPics
unset arrPics

for all_img in "$SYS_INPUT_IMAGE_DIR"/*.jpg
do
    arrPics=("${arrPics[@]}" "$all_img")
done
TOTAL_NO_OF_IMAGES=${#arrPics[@]}

for((current_img=1; current_img<$TOTAL_NO_OF_IMAGES+1 ; current_img++))
do
    IMG=$(echo $file | cut -d' ' -f$current_img)
    adb shell ./data/camera/tflite/play_with_tflite/$PROJECT_NAME/armv7/main $IMG
    echo "DONE_FOR_IMAGE : $IMG [$current_img/$TOTAL_NO_OF_IMAGES]"
    echo " "
done
echo "-------------------------------- TensorFlow Lite Output Images are generated successfully --------------------------------"
echo " "


#3. pull output from path
echo "-------------------------------- pulling all images to system --------------------------------"
adb pull $DEVICE_OUTPUT_IMAGE_DIR $SYS_OUTPUT_IMAGE_DIR
echo "-------------------------------- all images are pulled successfully --------------------------------"
echo " "

echo "images are stored in path: $SYS_OUTPUT_IMAGE_DIR"