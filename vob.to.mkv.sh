#!/bin/bash
set -e
# Description: Convert VOB to MKV.
script_name=$(basename "$0")

input_file=$1

# Error handling.
  if [ ! -f "${input_file}" ]; then
    echo "Error: ${input_file} is not a file. Aborted!"
    echo "   e.g.: ${script_name} file.vob"
    exit 1
  fi
  input_file=$(readlink -ev "${input_file}")


# Convert.
  current_dir=$(cdir)
  opt_map=$("${current_dir}"/vob.map.sh "${input_file}" 2> /dev/null)
  output_file=$(basename "${input_file}")
  #thread_num=$(grep -c ^processor /proc/cpuinfo)
  #  -threads 7 \

  ffmpeg \
    -analyzeduration 150M -probesize 150M \
    -i "${input_file}" \
    ${opt_map} \
    -codec:v libx264 -crf 21 \
    -codec:a libmp3lame -qscale:a 2 \
    -codec:s copy \
    "${output_file}".mkv < /dev/null
