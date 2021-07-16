#!/bin/bash
if [[ "$1" != "mp4" ]] && [[ "$1" != "gif" ]]; then

	echo "invalid argument type: $1 . valid: mp4|gif";
	exit

fi
CDIR=$(pwd)

type="$1";

rm -rf ./output/video-"$type"-*[0-9].png \
	&& ffmpeg -i ./input/video."$type" -vf "fps=30" ./output/video-"$type"-%01d.png  -hide_banner -loglevel quiet -stats

rm -rf ./loader-content/progress-*[0-9].png;

for f in ./output/video-"$type"-*[0-9].png; do b=$(basename "$f"); cp -rfp "$f" ./loader-content/"${b/video-$type/progress}" ; done

OUTPUT_FILES_COUNT=$(ls -l ./loader-content/*.png | wc -l)

sed -i 's/imagesInSequence=.*;/imagesInSequence='$OUTPUT_FILES_COUNT';/' ./animated-boot.script

echo "Wrote $OUTPUT_FILES_COUNT png contents to: $CDIR/loader-content"
echo "Done. Please run: 'update-initramfs -u' or 'plymouth-set-default-theme -R plantae' and reboot to see changes"
