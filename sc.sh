#!/bin/sh
# take a screenshot 

ffmpeg -f x11grab -video_size 1680x1050 -i $DISPLAY -vframes 1 \
 ~/Screens/`date "+%Y_%m_%d_%H_%M_%S"`.png
