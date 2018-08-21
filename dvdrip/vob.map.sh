#!/bin/bash
set -e
# Description: Create ffmpeg map of VOB file.
#   Return: list of map options for ffmpeg.
#     Reference: https://trac.ffmpeg.org/wiki/Map
script_name=$(basename "$0")

input_file=$1

# Error handling.
  if [ ! -f "${input_file}" ]; then
    echo "Error: ${input_file} is not a file. Aborted!"
    echo "   e.g.: ./${script_name} file.vob"
    exit 1
  fi
  input_file=$(readlink -ev "${input_file}")

# Create map options list for ffmpeg.
  map_options_list=$(ffmpeg -analyzeduration 150M -probesize 150M -i "${input_file}" 2>&1 || true) # Redirect stderr to stdout.
  map_options_list=$(echo "${map_options_list}" | grep '^ *Stream #')                      # Get all streams.
  >&2 echo "${map_options_list}"                         # DEBUG
  map_options_list=$(echo "${map_options_list}" | grep -vF 'Data: dvd_nav_packet')  # Remove navigation stream.
  map_options_list=$(echo "${map_options_list}" | sed 's/\[.*//')                   # Remove details.
  map_options_list=$(echo "${map_options_list}" | sed 's/Stream #/-map /' | xargs ) # Write -map option.

# Display results.
  echo "${map_options_list}"
  
