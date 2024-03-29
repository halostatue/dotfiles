# vim: ft=bash

use_nvm() {
  local version
  version="$1"

  [[ "${version}" == --auto ]] && version="$(read_version_file .node-version .nvmrc)"
  [[ -z "${version}" ]] && return

  if [[ -e ~/.nvm/nvm.sh ]]; then
    unsafe source ~/.nvm/nvm.sh
    nvm use "${version}"
  elif [[ -f ~/.local/share/nvm/.index ]]; then
    # This works with jorgebucaran/fish.nvm v2, a fish-specific alternative to
    # nvm. The version of Node requested must be installed before use.
    local installed_re
    installed_re="$(echo ~/.local/share/nvm/* | sed -e "s!$HOME/.local/share/nvm/!!g" -e 's/v//g' -e 's/ /|/g')"

    version="$(
      ruby -e \
        "puts ARGF.readlines.grep(/${installed_re}/).grep(%r{${version}}).sort.last.split.first" \
        ~/.local/share/nvm/.index
    )"

    [[ -z "${version}" ]] && return

    if [[ -d ~/.local/share/nvm/"${version}"/bin ]]; then
      local nvm
      nvm="$(
        cd ~/.local/share/nvm || exit
        pwd -P
      )"

      PATH_rm "${nvm}/*/bin"
      PATH_add "${nvm}/${version}"/bin

      export NVM_BIN
      NVM_BIN=~/.local/share/nvm/"${version}"/bin
    fi

    set +x
  elif [[ -f ~/.config/nvm/index ]]; then
    # This works with jorgebucaran/fish-nvm (v1), a fish-specific alternative to
    # nvm. The version of Node requested must be installed before use.
    version="$(
      ruby -e $'
        version=ARGV.shift
        version=version.strip.gsub(/^v/, "").gsub(%r{lts/}, "lts|")
        match=ARGF.readlines.find { |l| l =~ /#{Regexp.escape(version)}/ }
        puts match.split(/\\t/).first if match
      ' "${version}" ~/.config/nvm/index
    )"

    [[ -z "${version}" ]] && return

    if [[ -d ~/.config/nvm/"${version}"/bin ]]; then
      local nvm
      nvm="$(
        cd ~/.config/nvm || exit
        pwd -P
      )"

      PATH_rm "${nvm}/*/bin"
      PATH_add "${nvm}/${version}"/bin

      export NVM_BIN
      NVM_BIN=~/.config/nvm/"${version}"/bin
    fi
  fi
}
