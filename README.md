# shrc

shell rc

Other repositories add hooks to:

```shell
# SHRC external completions compat directory. BASH_COMPLETION_USER_DIR
# "Dinamically loaded by __load_completion()/_completion_loader() functions,
# they add 'completions' to $BASH_COMPLETION_USER_DIR".
# Sourced when homebrew profile.d completions are being sourced
export SHRC_EXTERNAL_COMPLETION_D="${SHRC}/bash_completion.d"
export BASH_COMPLETION_USER_DIR="${SHRC_EXTERNAL_COMPLETION_D}"
# SHRC external custom dir for other repositories. They are sourced at the end of profile
#
export SHRC_EXTERNAL_PROFILE_D="${SHRC_EXTERNAL}/profile.d"
```

To debug and see files being sourced and order:

```shell
SHRC_SHOW_FILES=1 rebash
```

To do something when a shell is sourcing directly shrc/profile,
i.e: avoid completions to be sourced when is sourced from an script

```shell
[ "${SHELL_ARGZERO-}" ] || return 0  # 
```

## jetbrains
jetbrains plist to start the LaunchAgent

## [config](config)

Application configurations that can be configured with global variables and do not contain secrets.

