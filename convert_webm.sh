#!/bin/bash
FFMPEG="./node_modules/ffmpeg-static/ffmpeg"

for f in $(find public -type f -name "*.mp4"); do
    echo "Converting $f to webm..."
    out="${f%.*}.webm"
    "$FFMPEG" -nostdin -y -i "$f" -vcodec libvpx-vp9 -crf 45 -b:v 0 -acodec libopus -cpu-used 4 "$out"
    if [ $? -eq 0 ]; then
        rm "$f"
    fi
done

echo "Updating index.html..."
sed -i '' 's/\.mp4/\.webm/g' index.html
sed -i '' 's/video\/mp4/video\/webm/g' index.html

echo "Committing to Git..."
git add -A
git commit --amend --no-edit

echo "Done! Ready to push!"
