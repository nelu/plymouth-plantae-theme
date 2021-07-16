#!/bin/sh
CDIR=$(pwd)
echo "Writing png contents to: $CDIR/output"
rm -rf ./output/video-gif-*[0-9].png && convert ./input/video.gif ./output/video-gif-%01d.png