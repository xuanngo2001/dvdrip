#!/bin/bash
set -e
# Description: DVDrip
script_name=$(basename "$0")

video_ts_dir=$1
output_file_prefix=$2  # Optional.

# Error handling.
  if [ ! -d "${video_ts_dir}" ]; then
    echo "Error: ${video_ts_dir} is not a directory. Aborted!"
    echo "   e.g.: ${script_name} /path/to/VIDEO_TS/ [output_file_prefix]"
    exit 1
  fi
  video_ts_dir=$(readlink -ev "${video_ts_dir}")



  while IFS='' read -r base_path || [[ -n "${base_path}" ]]; do
    chapter_name=$(basename "${base_path}")
    vob_filelist=$(ls -1 "${base_path}"*.VOB | grep -vF '_0.VOB')
    
    # Merge VOB.
      output_vob_file="${output_file_prefix}${chapter_name}.vob"
      echo "${vob_filelist}" | sed 's/^/"/' | sed 's/$/"/' | xargs cat > "${output_vob_file}"
    
    # Encode to MKV
      current_dir=$(cdir)
      "${current_dir}"/vob.to.mkv.sh "${output_vob_file}"

    exit
    
    # Delete merged VOB.
      rm -f "${output_vob_file}"

  done < <( ls -1 "${video_ts_dir}"/VTS_*.VOB | sed 's/_.\.VOB//' | sort | uniq )
