#!/bin/sh
CDIR=$(pwd)
echo "Writing png contents to: $CDIR/output"

# make sure its 30 fps for the bootloader
rm -rf ./output/video-mp4-*[0-9].png && ffmpeg -i ./input/video.mp4 -vf "fps=30" ./output/video-mp4-%01d.png  -hide_banner -loglevel quiet -stats

