# shellcheck shell=sh

export MEDIA_PROJECT="${HOME}/media"
pathadd "${MEDIA_PROJECT}/bin" "${MEDIA_PROJECT}/scripts" "${MEDIA_PROJECT}/scripts/run"
pythonpathadd "${MEDIA_PROJECT}"
