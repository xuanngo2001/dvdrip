
if [ $# -eq 0 ]; then
  echo "Error: Need to input video files. Aborted!"
  exit 1
fi

  for file in "${@}"; do # Skip the first argument.
    # Audio out of sync:
    #   time mpv --no-terminal "${file}" -o "${file}".avi --vf=fps=25 -ovc mpeg4    -ovcopts qscale=4                               -oac libmp3lame -oacopts ab=48k     
    
    # time mpv --no-terminal "${file}" -o "${file}".mkv             -ovc libx264  -ovcopts preset=medium,crf=23,profile=baseline  -oac libvorbis  -oacopts qscale=3   
    time mpv --no-terminal "${file}" -o "${file}".mp4             -ovc libx264  -ovcopts preset=medium,crf=23,profile=baseline  -oac aac        -oacopts ab=48k     
    
    # Low image quality:
    #   time mpv --no-terminal "${file}" -o "${file}".webm -of webm   -ovc libvpx   -ovcopts qmin=6,b=1000000k                      -oac libvorbis  -oacopts qscale=3   
  done


#~ real	8m47.761s
#~ user	16m14.041s
#~ sys	0m46.847s

#~ real	27m24.771s
#~ user	178m24.238s
#~ sys	1m49.715s

#~ real	27m29.848s
#~ user	178m10.314s
#~ sys	2m9.724s

#~ real	142m50.903s
#~ user	152m0.375s
#~ sys	1m0.433s

#~ -rw-r--r-- 1 root root 867M Aug 15 21:15 shediao_disk1.mdf.avi
#~ -rw-r--r-- 1 root root 2.0G Aug 15 21:43 shediao_disk1.mdf.mkv
#~ -rw-r--r-- 1 root root 1.9G Aug 15 22:10 shediao_disk1.mdf.mp4
#~ -rw-r--r-- 1 root root 598M Aug 16 00:33 shediao_disk1.mdf.webm
