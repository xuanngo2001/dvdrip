input=$1
output="${input}"
ffmpeg \
  -analyzeduration 500M -probesize 500M \
  -threads 7 \
  -i "${input}" \
  -map 0:1 -map 0:2 -map 0:3 -map 0:4 -map 0:5 -map 0:6 \
  -codec:v libx264 -crf 21 \
  -codec:a libmp3lame -qscale:a 2 \
  -codec:s copy \
  "${output}".mkv
