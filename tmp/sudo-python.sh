#
# Add sudo to python if owner is root and sudo installed.

macos() {
  export python
  python="$( xcode-select -print-path 2>/dev/null )/usr/bin/python3"
  return $?
}

main() {
  PATH="$(dirname "$0"):${PATH}"

  py="python3"
  for python in "/bin/${py}" "/usr/bin/${py}"; do
    [ ! -x "${python}" ] || break
  done
  if [ ! "${python-}" ]; then
    if "${VIRTUAL_ENV-}"; then
      deactivate
    fi
    if command -v xcode-select >/dev/null; then
      if xcode-select --install 2>/dev/null; then
        until macos; do
          sleep 3
        done
      fi
    else
      python="$( which -a "${py}"  2>/dev/null | grep -v brew )"
    fi
  fi
  if command -v sudo 2>/dev/null; then
    sudo="sudo -H"
  fi

  if [ "${python-}" ]; then
    ${sudo} "${python}" "${@}"
  else
    return 1
  fi
}

main "${@}"
