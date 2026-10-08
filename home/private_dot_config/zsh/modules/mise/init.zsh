# vim: set ft=zsh
#
# mise: internal port of @halostatue/fish-mise (v1.0.1), replacing the remote
# joke/zim-mise module.
#
# Why internal: the remote module calls `mise activate zsh` with no flags,
# which runs `_mise_hook --force` at activation time. That initializes zsh
# completion (sets ${_comps}) before zimfw's `completion` module runs, which
# then emits "completion was already initialized before completion module".
#
# zimfw's contract: modules that provide completions must load before the
# `completion` module and must NOT call compinit themselves -- they only add to
# ${fpath}; the completion module performs the single compinit. We honor that
# by activating with `--no-hook-env` (suppresses the activate-time hook-env eval
# that triggers compinit) and by only appending mise's `_mise` completion to
# ${fpath}. mise's precmd/chpwd hooks are still installed, so env management
# works from the first prompt; the first precmd runs hook-env normally.
#
# Keeps zim-mise's speedups: the activate output is cached and zcompiled.
#
# Config (set before this module in .zshrc, mirroring the fish plugin):
#   mise_activate_mode  -- 'shims' or 'status' to pass --shims/--status
#   mise_completions    -- set to 0 to skip completion handling

() {
  emulate -L zsh

  # --- Locate mise, mirroring the fish plugin's candidate probing. ---
  local mise
  if (( ${+commands[mise]} )); then
    mise=${commands[mise]}
  else
    local -a candidates=(${HOME}/.local/bin ${HOME}/bin ${HOME}/.bin)
    (( ${+commands[port]} )) && candidates+=(/opt/local/bin)
    if (( ${+commands[brew]} )); then
      candidates+=("$(brew --prefix)/bin")
    else
      candidates+=(/opt/homebrew/bin)
    fi
    candidates+=(/usr/local/bin /usr/bin)

    local c
    for c in ${candidates}; do
      if [[ -x ${c}/mise ]]; then
        mise=${c}/mise
        break
      fi
    done
    [[ -n ${mise} ]] || return 1
  fi

  # --- Determine activate mode (--shims / --status), as in the fish plugin. ---
  local mode=
  case ${mise_activate_mode[1]:-} in
    shims|status) mode=--${mise_activate_mode[1]} ;;
  esac

  # --- Non-interactive shells: shims only, no hooks, no caching. ---
  if [[ ! -o interactive ]]; then
    eval "$(${mise} activate zsh --shims)"
    return
  fi

  # --- Interactive: cache the activate script, zcompile, source. ---
  # ${1} is the module root (passed via `} ${0:h}` below), used for cache files.
  local cachedir=${1}
  local activatefile=${cachedir}/mise-activate.zsh

  if [[ ! -e ${activatefile} || ${activatefile} -ot ${mise} ]]; then
    # --no-hook-env is the key difference from joke/zim-mise: it suppresses the
    # activate-time `_mise_hook --force` that would call compinit. The precmd
    # hook still runs hook-env on the first prompt.
    ${mise} activate zsh ${mode} --no-hook-env >| ${activatefile}
    zcompile -UR ${activatefile}
  fi
  source ${activatefile}

  # --- Completions: append mise's _mise to fpath; let the completion module
  #     run the single compinit. Mirrors the fish plugin's `usage` handling. ---
  if [[ ${mise_completions:-1} != 0 ]]; then
    local compfile=${cachedir}/functions/_mise
    [[ -d ${compfile:h} ]] || mkdir -p ${compfile:h}
    if [[ ! -e ${compfile} || ${compfile} -ot ${mise} ]]; then
      # usage drives mise's zsh completions; install it if absent, as fish does.
      if (( ! ${+commands[usage]} )) && ! ${mise} which usage >/dev/null 2>&1; then
        ${mise} use -g usage >/dev/null 2>&1
      fi
      ${mise} completion zsh >| ${compfile} 2>/dev/null
      zcompile -UR ${compfile} 2>/dev/null
    fi
    fpath+=(${compfile:h})
  fi
} ${0:h}
