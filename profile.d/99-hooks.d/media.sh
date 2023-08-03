# shellcheck shell=sh

export MEDIA_PROJECT="${HOME}/media"
export PATH="${MEDIA_PROJECT}/bin:${MEDIA_PROJECT}/scripts:${MEDIA_PROJECT}/scripts/run:${PATH}"
export PYTHONPATH="${MEDIA_PROJECT}${PYTHONPATH:+:${PYTHONPATH}}"
