#!/bin/bash
set -e
# Description: Update Firstboot vbox script.

fb_run_dir=$(readlink -ev /media/master/github/firstboot/firstboot/scripts/ess-mpv-dvdrip/run)
dvdrip_script_dir=$(readlink -ev ./dvdrip)

# Update dvdrip to firstboot.
  yes | cp -v "${dvdrip_script_dir}"/* "${fb_run_dir}"

# Commit dvdrip at firstboot.
  (
    cd "${fb_run_dir}"
    # Git commands execution order is important.
    git ls-files --deleted -z | xargs -r -0 git rm && git commit -m 'dvdrip: commit deleted files.' || true
    git ls-files --modified -z | xargs -r -0 git commit -m 'dvdrip: commit changed files.'
    git ls-files --others -z | xargs -r -0 git add && git commit -m 'dvdrip: commit new files.' || true
  )  