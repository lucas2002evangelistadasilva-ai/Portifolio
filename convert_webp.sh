#!/bin/bash
FFMPEG="./node_modules/ffmpeg-static/ffmpeg"
find public -type f \( -name "*.png" -o -name "*.jpg" \) | while read f; do
    echo "Converting $f to webp..."
    out="${f%.*}.webp"
    "$FFMPEG" -y -i "$f" -vcodec libwebp -lossless 0 -q:v 75 "$out"
    if [ $? -eq 0 ]; then
        rm "$f"
    fi
done
