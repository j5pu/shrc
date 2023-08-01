# shellcheck shell=bash

#######################################
# iCloud download directory
# Arguments:
#   1
#######################################
download() {
  local dir
  dir="$(realpath "${1:-.}")"
  #  find -L "${dir}" -type d -exec brctl download "{}" \;
  find -L "${dir}" -type f -name "*.icloud" -exec brctl download "{}" \;
}

#######################################
# iCloud evict directory
# Arguments:
#   1
#######################################
evict() {
  local dir
  dir="$(realpath "${1:-.}")"
  find -L "${dir}" -type d -exec brctl evict "{}" \;
  find -L "${dir}" -type f -not -name "*.icloud" -not -name ".DS_Store" -exec brctl evict "{}" \;
}

#######################################
# brctl status
# Globals:
#   HOME
# Arguments:
#   1
#   2
#   3
#######################################
status() {
  local i status status_show x
  status="$(brctl status com.apple.CloudDocs)"
  # show status
  status_show() { echo "${3-}${1}: $(grep -c -- "$2" <<<"${status}")"; }
  for i in apply downloader reader sync-up upload; do
    status_show "${i}" "> ${i}{"
    case "${i}" in
      apply)
        for x in pending-download pending-parent; do
          status_show "${x}" "${x}" "  "
        done
        echo "--------------------------------"
        ;;
      downloader)
        # shellcheck disable=SC2043
        for x in pending-disk; do
          status_show "${x}" "${x}" "  "
        done
        ;;
      reader)
        status_show "needs-read[lost]" "needs-read" "  "
        ;;
      sync-up)
        # shellcheck disable=SC2043
        for x in sync-up-scheduled; do
  status_show "${x}" "${x}" "  "
done
        ;;
      upload)
        for x in needs-sync-up needs-upload; do
          status_show "${x}" "${x}" "  "
        done
        ;;
    esac
  done
  echo "--------------------------------"
  total "${HOME}/Library/Mobile Documents/com~apple~CloudDocs"
  unset -f status_show
}

#######################################
# iCloud total files downloaded and evicted in directory
# Arguments:
#   1
#######################################
total() {
  local dir total
  dir="$(realpath "${1:-.}")"
  total="$(find -L "${dir}" -not -name ".DS_Store" -type f)"
  du -L -h -d1 "${dir}"
  echo
  echo "Total:        $(wc -l <<<"${total}")"
  echo "  evicted:    $(wc -l < <(grep ".icloud$" <<<"${total}"))"
  echo "  downloaded: $(wc -l < <(grep -v ".icloud$" <<<"${total}"))"
}
