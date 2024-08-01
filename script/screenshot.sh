#!/usr/bin/env bash

function help_and_exit {
  if [ -n "${1}" ]; then
    echo "${1}"
  fi
  cat <<-EOF
    Usage: scregcp [-h|-s] [<screenshots_base_folder>]

    # screenshot the entire desktop, saved ~/.downloads/screenshots
    
        screenshot.sh ~/.downloads/screenshots

    # screenshot by selection, save to ~/.downloads/screenshots
    
        screenshot.sh -s  ~/.downloads/screenshots  

    Take screenshot of a whole screen or a specified region,
    save it to a specified folder (current folder is default)
    and copy it to a clipboard. 

       -h   - print help and exit
       -s   - take a screenshot of a screen region
EOF
  if [ -n "${1}" ]; then
    exit 1
  fi
  exit 0
}

# Set default base folder if not provided
base_folder="${PWD}"

if [ "${1}" == '-h' ]; then
  help_and_exit
elif [ "${1:0:1}" == '-' ]; then
  if [ "${1}" != '-s' ]; then
    help_and_exit "error: unknown option ${1}"
  fi
  if [ -n "${2}" ]; then
    base_folder="${2}"
  fi
  params="-s"
else
  if [ -n "${1}" ]; then
    base_folder="${1}"
  fi
  params=""
fi

today=$(date '+%d-%m-%Y')
file_dir="${base_folder}/${today}/"

val=0
file_path="${file_dir}screenshot_${val}.png"
while [ -f "${file_path}" ]; do
  ((val++))
  file_path="${file_dir}screenshot_${val}.png"
done

if [ ! -d "${file_dir}" ]; then
  mkdir -p "${file_dir}"
fi

echo "Using params ${params}"
if [ "${params}" == "-s" ]; then
  grim -g "$(slurp)" "${file_path}"
else
  grim "${file_path}"
fi
wl-copy <"${file_path}"
echo "Screenshot saved to ${file_path}"
