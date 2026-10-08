# vim: set ft=zsh
#
# brew: faithful port of @halostatue/fish-brew (v4.0.0)
#
# Discovers Homebrew by probing known prefixes (honoring ${__homebrew_prefix}),
# puts brew on PATH, then appends the brew + system bin/sbin block with move
# semantics -- fish's `fish_add_path --append --move`.

# Find Homebrew via a known prefix if `brew` isn't already resolvable.
if (( ! ${+commands[brew]} )); then
  () {
    local -a prefixes=(${HOME}/.brew ${HOME}/.linuxbrew /opt/homebrew /usr/local)
    [[ -n ${__homebrew_prefix:-} ]] && prefixes=(${__homebrew_prefix} ${prefixes})

    local prefix
    for prefix in ${prefixes}; do
      [[ -x ${prefix}/bin/brew ]] || continue
      zpath_prepend ${prefix}/bin
      break
    done
  }
fi

if (( ${+commands[brew]} )); then
  () {
    local brew_prefix="$(brew --prefix)"
    zpath_append \
      ${brew_prefix}/bin \
      /usr/local/bin \
      /usr/bin \
      /bin \
      ${brew_prefix}/sbin \
      /usr/local/sbin \
      /usr/sbin \
      /sbin
  }
fi
