# shellcheck shell=bash

#######################################
# generate jetbrains variables
# Arguments:
#  None
#######################################
generate_jetbrains() {
  local application

  : "${JETBRAINS?}"
  : "${SHRC_PROFILE_D_GENERATED_D?}"
  : "${JETBRAINS_CONFIG?}"
  : "${JETBRAINS_GENERATED?}"

  echo "# shellcheck shell=sh" > "${JETBRAINS_GENERATED}"
  for application in ${JETBRAINS_APPLICATIONS}; do
    {
      echo "export ${application^^}_PROPERTIES=\"${JETBRAINS_CONFIG}/${application}/.properties\""
      echo "export ${application^^}_VM_OPTIONS=\"${JETBRAINS_CONFIG}/${application}/.vmoptions\""
    } >> "${JETBRAINS_GENERATED}"
  done
}

