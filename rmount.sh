  MAX=10
  for ((i=1; i < MAX ; i++)); do
    mkdir -p /tmp/condor/0${i}
    mount "shediao_disk${i}.mdf" /tmp/condor/0${i}
  done

  MAX=16
  for ((i=10; i < MAX ; i++)); do
    mkdir -p /tmp/condor/${i}
    mount "shediao_disk${i}.mdf" /tmp/condor/${i}
  done

