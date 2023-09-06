# shellcheck shell=sh

# Depends on: [00-functions.d/cmd.sh](../00-functions.d/cmd.sh)
#

export BASH_SILENCE_DEPRECATION_WARNING=1

export BATS_NUMBER_OF_PARALLEL_JOBS=400

# CDPATH                                      Once the CDPATH is set, the cd command will search only
#                                             in the directories present in the CDPATH variable only.
#                                             It SHOULD always be the first component of the CDPATH.
# unset CDPATH

export CLICOLOR=1

####################################### GOOGLE CLOUD CONFIG
# https://cloud.google.com/compute/docs/gcloud-compute
# https://cloud.google.com/sdk/gcloud/reference/config
# CLOUDSDK_<SECTION>_<PROPERTY>:
# CLOUDSDK_CORE_PROJECT                       Google Cloud SDK core project.
#
#export CLOUDSDK_CORE_PROJECT=""
# CLOUDSDK_COMPUTE_REGION                     Google Cloud compute region.
#
#export CLOUDSDK_COMPUTE_REGION="EUROPE-WEST1"
# CLOUDSDK_COMPUTE_ZONE                       Google Cloud compute zone..
#
#export CLOUDSDK_COMPUTE_ZONE="EUROPE-WEST1-B"

###################################### DOCKER
# https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds
# https://docs.docker.com/engine/reference/commandline/cli/
# DOCKER_BUILDKIT:       If set, enables building images with BuildKit. performance, storage management,
#                        feature functionality, and security.
# https://docs.docker.com/buildx/working-with-buildx/
# Docker Buildx is included in Docker Desktop and Docker Linux packages when installed using the DEB or RPM packages.
# --platform (for example, linux/amd64, linux/arm64, or darwin/amd64).
# You can also download the latest buildx binary from the Docker buildx releases page on GitHub,
# copy it to ~/.docker/cli-plugins folder with name docker-buildx and change the permission to execute:
export DOCKER_BUILDKIT=1
# https://docs.docker.com/engine/reference/commandline/cli/#experimental-features
export DOCKER_CLI_EXPERIMENTAL="enabled"
export DOCKER_COMPLETION_SHOW_CONFIG_IDS=yes
export DOCKER_COMPLETION_SHOW_CONTAINER_IDS=yes
export DOCKER_COMPLETION_SHOW_IMAGE_IDS=all
export DOCKER_COMPLETION_SHOW_NODE_IDS=yes
export DOCKER_COMPLETION_SHOW_PLUGIN_IDS=yes
export DOCKER_COMPLETION_SHOW_SECRET_IDS=yes
export DOCKER_COMPLETION_SHOW_SERVICE_IDS=yes
export DOCKER_COMPLETION_SHOW_TAGS=yes

export EDITOR="vi"


# FIGNORE                                     A colon-separated list of suffixes to ignore when performing filename
#                                             completion. A filename whose suffix matches one of the
#                                             entries in 'FIGNORE' is excluded from the list of matched
#                                             filenames.  A sample value is '.o:~
#export FIGNORE=".o:~:Application Scripts"

export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# GH_HOST                                     GitHub hostname for commands that would otherwise assume the
#                                              'github.com' host when not in a context of an existing repository.
export GH_HOST="github.com"
# GLAMOUR_STYLE                               Style to use for rendering Markdown.
export GLAMOUR_STYLE="dark"

###################################### GIT
# https://git-scm.com/docs/git-config
# https://git-scm.com/docs/git-init
# GIT_COMPLETION_SHOW_ALL                     Show --arguments in completions.
export GIT_AUTHOR_EMAIL="root@example.com"
export GIT_AUTHOR_NAME="root"
export GIT_COMPLETION_SHOW_ALL="1"
export GIT_COMPLETION_SHOW_ALL_COMMANDS="1"
export GIT_DISCOVERY_ACROSS_FILESYSTEM="1"
export GIT_PAGER="less"

export GREP_OPTIONS="--color=auto"
export GREP_COLOR="1;35;40"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"

export HISTCONTROL=erasedups
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_history_unlimited

###################################### HOMEBREW
# https://docs.brew.sh/Manpage#bundle-subcommand
export HOMEBREW_BAT=1
export HOMEBREW_BUNDLE_FILE="${SHRC_PACKAGES?}/${UNAME}/${HOST}/Brewfile"
#  export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_CASK_OPTS="--appdir=/Applications --no-quarantine"
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
# export HOMEBREW_CACHE="/Volumes/USB-2TB/Library/Caches/Homebrew"
# HOMEBREW_CLEANUP_PERIODIC_FULL_DAY          If set, brew install, brew upgrade and brew reinstall will cleanup all
#                                             formulae when this number of days has passed.
export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=7
# HOMEBREW_COLOR                              If set, force colour output on non-TTY outputs.
#
export HOMEBREW_COLOR=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_PRY=1
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
# export HOMEBREW_TEMP="/Volumes/USB-2TB/tmp"
# HOMEBREW_UPDATE_REPORT_ONLY_INSTALLED       If set, brew update only lists updates to installed software.
export HOMEBREW_UPDATE_REPORT_ONLY_INSTALLED=1

#export LANG='en_US.UTF-8'

#export LC_ALL='en_US.UTF-8'

export LESS="-F -R -X"

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

if cmd most; then
  export MANPAGER=most
else
  export MANPAGER=less
fi

export PAGER=less

###################################### PIP
# https://pip.pypa.io/en/stable/topics/configuration/
# PIP_<UPPER_LONG_COMMAND_LINE_OPTION_NAME>  Dashes (-) have to be replaced with underscores (_).
# PIP_DISABLE_PIP_VERSION_CHECK             If set, don’t periodically check PyPI to determine whether
#                                            a new version of pip is available for download.
export PIP_DISABLE_PIP_VERSION_CHECK=1

# Overrides location of app installations. Apps are symlinked or copied here
#
export PIPX_BIN_DIR="/usr/local/bin"

# https://docs.pytest.org/en/stable/reference/reference.html#envvar-PYTEST_THEME_MODE
#
export PYTEST_THEME="github-dark"
export PYTEST_THEME_MODE="dark"

# PYTHONASYNCIODEBUG                          If this environment variable is set to a non-empty string,
#                                             enable the debug mode of the asyncio module.
#
export PYTHONASYNCIODEBUG=0
# Configure Python to print tracebacks on crash [2], and to not buffer stdout and stderr [3].
# [1] https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE
# [2] https://docs.python.org/3/using/cmdline.html#envvar-PYTHONFAULTHANDLER
# [3] https://docs.python.org/3/using/cmdline.html#envvar-PYTHONUNBUFFERED
# PYTHONDONTWRITEBYTECODE                     If set, python won’t try to write .pyc files on the import of source
#                                             modules. This is equivalent to specifying the -B option.
export PYTHONDONTWRITEBYTECODE=1
export PYTHONFAULTHANDLER=1
export PYTHONUNBUFFERED=1
# PYTHONNOUSERSITE                            If this is set, Python won’t add the user site-packages
#                                             directory to sys.path.
export PYTHONNOUSERSITE=0

export SENTRY_DSN=""

#export TERM='xterm-256color'

export UMASK="0022"
export VISUAL="${EDITOR}"

export -f history_prompt