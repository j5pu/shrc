# shellcheck shell=bash

#######################################
# generate jetbrains variables
# Arguments:
#  None
#######################################
generate_jetbrains() {
  local application tmp

  : "${JETBRAINS?}"
  : "${SHRC_PROFILE_D_GENERATED_D?}"
  : "${JETBRAINS_CONFIG?}"
  : "${JETBRAINS_GENERATED?}"

  tmp="$(mktemp)"

  echo "# shellcheck shell=sh" > "${tmp}"
  for application in ${JETBRAINS_APPLICATIONS}; do
    {
      echo "export ${application^^}_PROPERTIES=\"${JETBRAINS_CONFIG}/${application}/.properties\""
      echo "export ${application^^}_VM_OPTIONS=\"${JETBRAINS_CONFIG}/${application}/.vmoptions\""
    } >> "${tmp}"
  done
  cmp -s "${JETBRAINS_GENERATED}" "${tmp}" || { mv "${tmp}" "${JETBRAINS_GENERATED}"; git a; }
}

