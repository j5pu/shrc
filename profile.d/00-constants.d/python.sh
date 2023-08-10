# shellcheck shell=sh

# Configure Python to print tracebacks on crash [2], and to not buffer stdout and stderr [3].
# [1] https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE
# [2] https://docs.python.org/3/using/cmdline.html#envvar-PYTHONFAULTHANDLER
# [3] https://docs.python.org/3/using/cmdline.html#envvar-PYTHONUNBUFFERED
export PYTHONDONTWRITEBYTECODE=1
export PYTHONFAULTHANDLER=1
export PYTHONUNBUFFERED=1
