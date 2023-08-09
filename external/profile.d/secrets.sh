# shellcheck shell=sh disable=SC2034

# Secrets repository path
#
export SECRETS="${SHRC_PREFIX}/secrets/secrets.sh"

# source: secrets
#
source_files "${SECRETS}"
