# shrc

shell rc

## Other repositories, use `shrc install` to add hooks to:

```shell
# SHRC external custom dir for other repositories, completions and profile.d
# They are installed with "shrc install"
export SHRC_EXTERNAL="${SHRC}/external"
# SHRC external bin shims dir for other repositories
# Subdirectories are added to path
export SHRC_EXTERNAL_BIN="${SHRC_EXTERNAL}/bin"
# SHRC external completions compat directory. BASH_COMPLETION_USER_DIR
# "Dynamically loaded by __load_completion()/_completion_loader() functions,
# 3rd-party tools completions are installed manually under "vendor"
# Patched completions are installed under "patches"
export SHRC_EXTERNAL_COMPLETION_D="${SHRC_EXTERNAL}/bash_completion.d"
export BASH_COMPLETION_USER_DIR="${SHRC_EXTERNAL_COMPLETION_D}"
# SHRC external man shims dir for other repositories
# Subdirectories are added to manpath
export SHRC_EXTERNAL_MAN="${SHRC_EXTERNAL}/share/man"
# SHRC external custom dir for other repositories
#
export SHRC_EXTERNAL_PROFILE_D="${SHRC_EXTERNAL}/profile.d"
# SHRC generated color bin directory
#
```

[shrc_external.sh](profile.d/99.d/shrc_external.sh) when sourced will execute hooks and add shims to `$PATH`/`$MANPATH`,
if a `.shrc` is present at the top of the repository executing `shrc install`

## To debug and see files being sourced and order:

```shell
SHRC_DEBUG=1 rebash
```

## To do something when a shell is sourcing directly shrc/profile,

i.e: avoid completions to be sourced when is sourced from a script

```shell
[ "${SH_ARGZERO-}" ] || return 0  # 
```

## jetbrains

jetbrains plist to start the LaunchAgent

## [config](config)

Application configurations that can be configured with global variables and do not contain secrets.

## Install
* run sudoers
* install brew
* run install

ov
icloud aliases
