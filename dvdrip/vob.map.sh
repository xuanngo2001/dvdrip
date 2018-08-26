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
  
  map_options_list=$(echo "${map_options_list}" | sed 's/\[.*//')                   # Remove details from VOB file.
  map_options_list=$(echo "${map_options_list}" | sed 's/(.*//')                    # Remove details from WMV file.
  map_options_list=$(echo "${map_options_list}" | sed 's/: Audio:.*//' | sed 's/: Video:.*//')  # Remove details from RMVB file.
  
  map_options_list=$(echo "${map_options_list}" | sed 's/Stream #/-map /' | xargs ) # Write -map option.

# Display results.
  echo "${map_options_list}"

# WMV streams:
#    Stream #0:0(jpn): Video: wmv3 (Main) (WMV3 / 0x33564D57), yuv420p, 1280x720, 5000 kb/s, 59.94 fps, 59.94 tbr, 1k tbn, 1k tbc
#    Stream #0:1(jpn): Audio: wmav2 (a[1][0][0] / 0x0161), 48000 Hz, stereo, fltp, 128 kb/s

# VOB streams:
#    Stream #0:0[0x1e0]: Video: mpeg1video, yuv420p(tv), 352x288 [SAR 178:163 DAR 1958:1467], 820 kb/s, 25 fps, 25 tbr, 90k tbn, 25 tbc
#    Stream #0:1[0x1bf]: Data: dvd_nav_packet
#    Stream #0:2[0x1c0]: Audio: mp2, 48000 Hz, mono, s16p, 32 kb/s
#    Stream #0:3[0x1c1]: Audio: mp2, 48000 Hz, mono, s16p, 32 kb/s

# RMVB streams:
#    Stream #0:0: Audio: cook (cook / 0x6B6F6F63), 44100 Hz, stereo, fltp, 64 kb/s
#    Stream #0:1: Video: rv40 (RV40 / 0x30345652), yuv420p, 1024x576, 888 kb/s, 25 fps, 25 tbr, 1k tbn, 1k tbc
