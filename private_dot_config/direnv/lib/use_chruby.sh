# vim: ft=bash

use_chruby() {
  local version
  version="$1"

  [[ "${version}" == --auto ]] && version="$(read_version_file .ruby-version)"
  [[ -z "${version}" ]] && return

  local chruby

  if has brew; then
    local brew_prefix
    brew_prefix="$(brew --prefix)"

    if [[ -e "${brew_prefix}/opt/chruby/share/chruby/chruby.sh" ]]; then
      chruby="${brew_prefix}/opt/chruby/share/chruby/chruby.sh"
    fi
  fi

  [[ -z "${chruby}" ]] && [[ -e /usr/local/share/chruby/chruby.sh ]] &&
    chruby=/usr/local/share/chruby/chruby.sh

  [[ -z "${chruby}" ]] && return

  unsafe source "${chruby}"
  unsafe chruby "${version}"
}
