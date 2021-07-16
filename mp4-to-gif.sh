#!/bin/sh
rm -rf ./output/video.gif && ffmpeg -i ./input/video.mp4 -vf "fps=60,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ./output/video.gif -hide_banner