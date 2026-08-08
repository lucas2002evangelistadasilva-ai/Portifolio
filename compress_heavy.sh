#!/bin/bash
FFMPEG="/Users/olivio/Trabalho/Projetos pessoais/Site Lucas/node_modules/ffmpeg-static/ffmpeg"

echo "Compressing videos in public/videos..."
cd "public/videos"
for f in *.mp4; do
    if [ $(stat -f%z "$f") -gt 10000000 ]; then
        echo "Compressing $f..."
        "$FFMPEG" -y -i "$f" -vcodec libx264 -crf 35 -preset fast -acodec aac -b:a 64k -vf "scale='min(720,iw)':-2" -movflags +faststart "compressed_$f"
        mv "compressed_$f" "$f"
    fi
done

cd compressed
for f in *.mp4; do
    if [ $(stat -f%z "$f") -gt 10000000 ]; then
        echo "Compressing $f..."
        "$FFMPEG" -y -i "$f" -vcodec libx264 -crf 35 -preset fast -acodec aac -b:a 64k -vf "scale='min(720,iw)':-2" -movflags +faststart "compressed_$f"
        mv "compressed_$f" "$f"
    fi
done
cd ../..

echo "Compressing videos in public/eventos..."
cd "public/eventos"
for f in *.mp4; do
    if [ $(stat -f%z "$f") -gt 10000000 ]; then
        echo "Compressing $f..."
        "$FFMPEG" -y -i "$f" -vcodec libx264 -crf 35 -preset fast -acodec aac -b:a 64k -vf "scale='min(720,iw)':-2" -movflags +faststart "compressed_$f"
        mv "compressed_$f" "$f"
    fi
done

echo "Compressing heavy PNGs in public/eventos..."
for f in *.png; do
    if [ $(stat -f%z "$f") -gt 2000000 ]; then
        echo "Compressing $f to JPG..."
        sips -s format jpeg -s formatOptions 40 "$f" --out "${f%.png}.jpg"
        rm "$f"
    fi
done
