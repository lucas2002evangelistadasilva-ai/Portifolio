#!/bin/bash
cd "/Users/olivio/Trabalho/Projetos pessoais/Site Lucas/public/videos"
mkdir -p compressed
FFMPEG="/Users/olivio/Trabalho/Projetos pessoais/Site Lucas/node_modules/ffmpeg-static/ffmpeg"

for f in *.mp4; do
    echo "Compressing $f (keeping original size/aspect)..."
    # Scale down for web but keep exact original aspect ratio and rotation
    "$FFMPEG" -y -i "$f" -vcodec libx264 -crf 30 -preset fast -acodec aac -b:a 96k -vf "scale='min(1080,iw)':'min(1920,ih)':force_original_aspect_ratio=decrease,scale=trunc(iw/2)*2:trunc(ih/2)*2" -movflags +faststart "compressed/$f"
done
echo "All videos compressed without cropping!"
