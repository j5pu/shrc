# shellcheck shell=bash disable=SC2043,SC2181

# JULIA - JUDICIAL

#######################################
# Copy Mail attachments and remove duplicates
# Globals:
#   HOME
# Arguments:
#   1
#   2
#######################################
attachments() {
  local copy dir=/Volumes/USB-2TB/Attachments extension file sum
  # copy
  copy() {
    ! test -f "$2" && cp -pv "$1" "$2"
  }
  while read -r file; do
    extension="$(extension "${file}")"
    test -s "${file}" || continue
    [ "$(stat -f "%z" "${file}")" -ne 0 ] || continue
    if ! copy "${file}" "${dir}/${file##*/}"; then
      sum="$(md5sum "${file}" | awk '{ print $1 }')"
      if ! find "${dir}" -type f -exec md5sum "{}" \; | awk '{ print $1 }' | grep -q "${sum}"; then
        copy "${file}" "${dir}/$(stem "${file}") (${sum})${extension:+.${extension}}"
      fi
    fi
  done < <(find "${HOME}/Library/Mail/V9" -path "*/Attachments/*" -type f)
  unset -f copy
}

#######################################
# copy audios from iCloud and text
# Arguments:
#  None
#######################################
audios() {
  local c=0 dir dest files readable='@' src suffix="pdf" total
  dir="/Volumes/USB-2TB/Documents/Julia/Backups - Audios - Sacadas Ordenador - \
Capturas Pantalla /Audios y Transcripciones/Mio"
  files="$(find "${dir}" -type f -iname "*.m4a"  | sort -R)"
  total="$(echo "${files}" | wc -l | sed 's/ //g')"

  while read -r src; do
    ((c += 1))
    suffix="$(extension "${src}")"
    dest="${src%/*}/$(basename "${src}" ".${suffix}")${readable}.${suffix/m4a/txt}"
    if ! test -f "${dest}" || [ "${src}" -nt "${dest}" ]; then
      echo "${dest}"
      ~/Tools/hear/products/hear --language es-ES -i "${src}" >"${dest}"
      file="  \e[32m${src}\e[0m"
      [ $? -eq 0 ] || file="  \e[31m${src}\e[0m"
      outof "${c}" "${total}" "${file}"
    fi
  done <<<"${files}"
}

#######################################
# description
# Arguments:
#  None
#######################################
audio() {
  local dir file
  dir="/Volumes/USB-2TB/Documents/Julia/Backups - Audios - Sacadas Ordenador - \
Capturas Pantalla /Audios y Transcripciones/Mio"

  while read -r file; do
    echo Starting: "${file}" "${file/.m4a/@.txt}"
    test -f "${file/.m4a/@.txt}" || ~/Tools/hear/products/hear --language es-ES -i "${file}" > "${file/.m4a/@.txt}"
  done < <(find "${dir}" -type f -name "*.m4a")
}

#######################################
# sort files by date in documents and create PDF
# Globals:
#   HOME
# Arguments:
#   1
#######################################
dates() {
  local dir file keys tmp files
  dir="${HOME}/Documents/Julia"
  declare -A files
  while read -r file; do
    ! echo "${file##*/}" | grep -q -- " -" || files["${file##*/}"]="${file}"
  done < <(find "${dir}" -type f -name "20*" | sed "s|${dir}/||g")
  keys="$(printf "%s\n" "${!files[@]}" | sort)"
  # create file
  to_file() {
    tmp="$(mktemp)"
    rm -f "$1"
    while read -r file; do
      echo "${file} ${files[${file}]}" >>"${tmp}"
    done <<<"${keys}"
    cupsfilter -o landscape "${tmp}" >"$1"
  }
  tmp="$(mktemp)"
  echo "${keys}" >"${tmp}"
  cupsfilter -o landscape "${tmp}" >"${dir}/LISTA.pdf"
  to_file "${dir}/LISTA_TODOS.pdf"
  keys="$(echo "${keys}" | grep JUZGADO)"
  to_file "${dir}/LISTA_JUZGADO.pdf"
}

#######################################
# pdf, png and jpeg ocr directory
# Arguments:
#   1
#######################################
ocr() {
  local c=0 dir dest files log readable='@' src suffix="pdf" total
  dir="$(realpath "${1:-/Volumes/USB-2TB/Documents/Julia}")"
  files="$(find "${dir}" -type f \
    \( -iname "*.pdf" -or -iname "*.png" -or -iname "*.jpg" \) \
    \( -not -iname "*${readable}.*" -and -not -name "LISTA*" \) | sort -R)"
  log="$(mktemp)"
  total="$(echo "${files}" | wc -l | sed 's/ //g')"

  while read -r src; do
    ((c += 1))
    suffix="$(extension "${src}")"
    dest="${src%/*}/$(basename "${src}" ".${suffix}")${readable}.${suffix/PNG/txt}"
    if ! test -f "${dest}" || [ "${src}" -nt "${dest}" ]; then
      if [ "${suffix}" = "pdf" ]; then
        ocrmypdf -l spa+eng --force-ocr "${src}" "${dest}" 1>"${log}" 2>&1
      else
        easyocr -l es en -f "${src}" >"${dest}" 2>>"${log}"
      fi
      file="  \e[32m${src}\e[0m"
      [ $? -eq 0 ] || file="  \e[31m${src}\e[0m"
      outof "${c}" "${total}" "${file}"
    fi
  done <<<"${files}"

  ! test -s "${log}" || echo "${log}"
  grep "File name too long" "${log}" || true
}

#######################################
# description
# Arguments:
#  None
#######################################
ocrall() {
  local i
  while read -r i; do
    ocr "" &
  done < <(seq 30)
}

#######################################
# description
# Arguments:
#  None
#######################################
dry() { rsync_preserve -n "$@"; }

#######################################
# description
# Arguments:
#  None
#######################################
video() {
  local i dest="/Volumes/USB-2TB/Recovered/Windows/converted - video"
  mkdir -p "${dest}"
  while read -r i; do
    ffmpeg -nostdin -y -i "$i" "${dest}/$(stem "$i")".mp4 &
    sleep 3
  done < <(find "/Volumes/USB-2TB/Recovered/Wondershare - DATA/Recoverit 2022-08-19 at 03.20.20/Unsourced files/Video" \
    -type f )
}

#######################################
# description
# Arguments:
#  None
#######################################
windows_all() { windows HDD; windows DATA; }

#######################################
# description
# Arguments:
#  None
#######################################
windows_rm() {
  local i
  for i in bak bin cfg class com db dll exe gif htm idx ini jar js log net ocx sys txt; do
    sudo find ~/Windows/All -type f -iname "*.${i}" -delete
  done
}

#######################################
# description
# Arguments:
#  None
#######################################
wma() {
  local i dest="/Volumes/USB-2TB/Recovered/Windows/Music/converted"
  while read -r i; do
    ffmpeg -nostdin -y -i "$i" "${dest}/$(stem "$i")".m4a &
    sleep 3
  done < <(find "/Volumes/USB-2TB/Recovered/Wondershare - DATA/Recoverit 2022-08-19 at 03.20.20/Unsourced files/Audio" \
    -type f )
}

/usr/local/bin/jet-service

! test -f ~/media/.bashrc || . ~/media/.bashrc
