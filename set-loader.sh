#!/bin/bash
if [[ "$1" != "mp4" ]] && [[ "$1" != "gif" ]]; then

	echo "invalid argument type: $1 . valid: mp4|gif";
	exit

fi
CDIR=$(pwd)

type="$1";

./"$type"-to-png.sh \
	&& rm -rf ./loader-content/progress-*[0-9].png
	
for f in ./output/video-"$type"-*[0-9].png; do b=$(basename "$f"); cp -rfp "$f" ./loader-content/"${b/video-$type/progress}" ; done

OUTPUT_FILES_COUNT=$(ls -l "$CDIR"/loader-content/*.png | wc -l)

echo "Wrote $OUTPUT_FILES_COUNT png contents to: $CDIR/loader-content"
echo "Done. Please run: 'update-initramfs -u' or 'plymouth-set-default-theme -R plantae' and reboot to see changes"
