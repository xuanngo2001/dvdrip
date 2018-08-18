  MAX=0
  for ((i=1; i <= MAX ; i++)); do
    
    MAX_VTS=4
    for ((j=1; j <= MAX_VTS ; j++)); do
      vob_filelist=$(ls -1 /tmp/condor/0${i}/VIDEO_TS/VTS_0${j}_*.VOB | grep -vF '_0.VOB' | xargs)
      vob_final_file="condor-0${i}-${j}.vob"
      cat ${vob_filelist} > "${vob_final_file}"
      ./f.sh "${vob_final_file}"
      rm -f "${vob_final_file}"
    done

  done


  MAX=15
  for ((i=10; i <= MAX ; i++)); do

    MAX_VTS=4
    for ((j=1; j <= MAX_VTS ; j++)); do
      vob_filelist=$(ls -1 /tmp/condor/${i}/VIDEO_TS/VTS_0${j}_*.VOB | grep -vF '_0.VOB' | xargs)
      vob_final_file="condor-${i}-${j}.vob"
      cat ${vob_filelist} > "${vob_final_file}"
      ./f.sh "${vob_final_file}"
      rm -f "${vob_final_file}"
    done

  done

