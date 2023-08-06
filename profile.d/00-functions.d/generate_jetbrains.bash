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
    config="${JETBRAINS_CONFIG}/${application}"
    plugins="${JETBRAINS}/plugins/${application}"
    properties="${config}/.properties"
    {
      echo "export ${application^^}_PROPERTIES=\"${properties}\""
      echo "export ${application^^}_VM_OPTIONS=\"${config}/.vmoptions\""
    } >> "${tmp}"
    sed -i "" 's|idea.config.path=.*|idea.config.path=${config}|' "${properties}"
    sed -i "" 's|idea.plugins.path=.*|idea.plugins.path=${plugins}|' "${properties}"
    sed -i "" 's|idea.scratch.path=.*|idea.scratch.path=${JETBRAINS}/scratch|' "${properties}"
    sed -i "" 's|idea.system.path=.*|idea.system.path=${JETBRAINS}/cache/${application}|' "${properties}"
    sed -i "" 's|idea.log.path=.*|idea.log.path=${JETBRAINS}/log/${application}|' "${properties}"
    rm "${properties}".bk
 │ idea.plugins.path=/Users/Shared/JetBrains/plugins/PyCharm
   4   │ idea.scratch.path=/Users/Shared/JetBrains/scratch
   5   │ idea.system.path=/Users/Shared/JetBrains/cache/PyCharm
   6   │ idea.log.path=/Users/Shared/JetBrains/log/PyCharm
  done
  cmp -s "${JETBRAINS_GENERATED}" "${tmp}" || {
    cd "${JETBRAINS_GENERATED%/*}"
    mv "${tmp}" "${JETBRAINS_GENERATED}"
    git add "${JETBRAINS_GENERATED}"
    git commit -m "${JETBRAINS_GENERATED}" "${JETBRAINS_GENERATED}"
    git push
    }
}

