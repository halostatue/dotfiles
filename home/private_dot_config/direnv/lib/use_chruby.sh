# vim: ft=bash

use_chruby() {
  local -a rubies install_roots
  local root dir match version
  rubies=()
  install_roots=()

  if [[ -n "${RUBY_INSTALL_ROOTS}" ]]; then
    if [[ $(declare -p RUBY_INSTALL_ROOTS >/dev/null) =~ "declare -a" ]]; then
      install_roots=("${RUBY_INSTALL_ROOTS[@]}")
    else
      mapfile -t install_roots < <(echo "${RUBY_INSTALL_ROOTS}")
    fi
  else
    install_roots=(
      "$HOME/.rubies" /opt/local/opt/rubies /opt/homebrew/opt/rubies
      /usr/local/opt/rubies
    )
  fi

  for root in "${install_roots[@]}"; do
    [[ -d "${root}" ]] && [[ -n "$(ls -A "${root}")" ]] && rubies+=("${root}"/*)
  done

  version="$1"

  [[ "${version}" == --auto ]] && version="$(read_version_file .ruby-version)"
  [[ -z "${version}" ]] && return

  if [[ -n "${RUBY_ROOT}" ]]; then
    PATH=":${PATH}:"
    PATH="${PATH//:${RUBY_ROOT}\/bin:/:}"

    if ((UID != 0)); then
      [[ -n "${GEM_HOME}" ]] && PATH="${PATH//:${GEM_HOME}\/bin:/:}"
      [[ -n "${GEM_ROOT}" ]] && PATH="${PATH//:${GEM_ROOT}\/bin:/:}"

      GEM_PATH=":$GEM_PATH:"

      [[ -n "${GEM_HOME}" ]] && GEM_PATH="${GEM_PATH//:${GEM_HOME}:/:}"
      [[ -n "${GEM_ROOT}" ]] && GEM_PATH="${GEM_PATH//:${GEM_ROOT}:/:}"

      GEM_PATH="${GEM_PATH#:}"
      GEM_PATH="${GEM_PATH%:}"

      unset GEM_ROOT GEM_HOME

      [[ -z "${GEM_PATH}" ]] && unset GEM_PATH
    fi

    PATH="${PATH#:}"
    PATH="${PATH%:}"
    unset RUBY_ROOT RUBY_ENGINE RUBY_VERSION RUBYOPT
  fi

  [[ "${version}" == system ]] && return

  for dir in "${rubies[@]}"; do
    dir="${dir%%/}"
    root="${dir##*/}"

    [[ "${root}" == "${version}" ]] && match="${dir}" && break
    [[ "${root}" == *"${version}"* ]] && match="${dir}"
  done

  if [[ -z "${match}" ]]; then
    echo "chruby: unknown Ruby: ${version}" >&2
    return 1
  fi

  if [[ ! -x "${match}/bin/ruby" ]]; then
    echo "chruby: $1/bin/ruby not executable" >&2
    return 1
  fi

  RUBY_ROOT="${match}"
  RUBYOPT="$2"
  PATH="${RUBY_ROOT}/bin:${PATH}"
  RUBY_ENGINE="$("${RUBY_ROOT}/bin/ruby" -e 'puts defined?(RUBY_ENGINE) ? RUBY_ENGINE : "ruby"')"
  RUBY_VERSION="$("${RUBY_ROOT}/bin/ruby" -e 'puts RUBY_VERSION')"

  root="$("${RUBY_ROOT}/bin/ruby" -e 'puts Gem.default_dir')"
  [[ -n "${root}" ]] && GEM_ROOT="${root}"

  if (("${UID}" != 0)); then
    GEM_HOME="${HOME}/.gem/${RUBY_ENGINE}/${RUBY_VERSION}"
    GEM_PATH="${GEM_HOME}${GEM_ROOT:+:${GEM_ROOT}}${GEM_PATH:+:${GEM_PATH}}"
    PATH="${GEM_HOME}/bin${GEM_ROOT:+:${GEM_ROOT}/bin}:${PATH}"
  fi

  export GEM_HOME GEM_PATH GEM_ROOT PATH RUBYOPT RUBY_ENGINE RUBY_ROOT RUBY_VERSION
}
