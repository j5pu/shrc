# shellcheck shell=sh

export JETBRAINS="${DEFAULT_HOME?}/JetBrains"
export JETBRAINS_APPLICATIONS="Aqua AppCode CLion DataGrip DataSpell Gateway GoLand Idea PyCharm RubyMine Toolbox\
 WebStorm"
# Configuration directory for JetBrains applications
#
export JETBRAINS_CONFIG="${JETBRAINS}/config"
# Generated library for JetBrains application configurations
#
export JETBRAINS_GENERATED="${SHRC_PROFILE_D_GENERATED_D?}/jetbrains.sh";
