# vim: ft=bash

# https://github.com/direnv/direnv/wiki/Customizing-cache-location (human-readable version)

if (("${BASH_VERSINFO[0]}" > 3)); then
  : "${XDG_CACHE_HOME:=$HOME/.cache}"
  declare -A direnv_layout_dirs

  direnv_layout_dir() {
    if ! [[ "${direnv_layout_dirs["${PWD}"]+isset}" ]]; then
      local hash
      hash="$(sha1sum - <<<"${PWD}" | cut -c-7)"
      local path="${PWD//[^a-zA-Z0-9]/-}"
      direnv_layout_dirs["${PWD}"]="$(echo "${XDG_CACHE_HOME}/direnv/layouts/${hash}${path}")"
    fi

    echo "${direnv_layout_dirs["${PWD}"]}"
  }
fi
