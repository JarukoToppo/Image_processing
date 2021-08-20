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
PROJECT_NAME=person_mask_argv
#---------------------------------------------Select OUTPUT_FOLDER_TYPE---------------------------------------------
SYS_INPUT_IMAGE_DIR=/jaruko/Project/JarWrkSpc/tflite/Bokeh/test/test_input_images/.

echo "Project Name : $PROJECT_NAME"

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
    ##following is the path of executable file
    /jaruko/Project/RsysWrkSpc/deg-innovation/image-enhancement-features/Bokeh_Rsys/linux/src/person_mask_argv/build/main $IMG
    echo "DONE_FOR_IMAGE : $IMG [$current_img/$TOTAL_NO_OF_IMAGES]"
    echo " "
done
echo "-------------------------------- TensorFlow Lite Output Images are generated successfully --------------------------------"
echo " "
