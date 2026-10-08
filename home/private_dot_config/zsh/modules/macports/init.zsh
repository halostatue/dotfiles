# vim: set ft=zsh
#
# macports: faithful port of @halostatue/fish-macports (v1.1.1)
#
# Builds the ordered bin/sbin block (MacPorts, optional Homebrew, system) and
# appends it with move semantics -- fish's `fish_add_path --append --move`.
# Because 00-path only seeded the cryptex/paths.d floor, appending this block
# with move relocates /usr/local/bin, /usr/bin, /bin beneath the opt dirs,
# putting MacPorts/Homebrew ahead of the system bins.
#
# Guarded by `--if-command port` in .zimrc.
() {
  if (( ! ${+commands[port]} )) && [[ ! -x /opt/local/bin/port ]]; then
    return 0
  fi

  local -a bin=(/usr/bin /bin)
  local -a sbin=(/usr/sbin /sbin)

  if (( ${+commands[brew]} )); then
    local prefix="$(brew --prefix)"

    if [[ ${prefix} != /usr/local ]]; then
      bin=(/usr/local/bin ${bin})
      sbin=(/usr/local/sbin ${sbin})
    fi

    case ${__halostatue_macports_homebrew_order:-macports} in
      homebrew)
        bin=(${prefix}/bin /opt/local/bin ${bin})
        sbin=(${prefix}/sbin /opt/local/sbin ${sbin})
        ;;
      macports)
        bin=(/opt/local/bin ${prefix}/bin ${bin})
        sbin=(/opt/local/sbin ${prefix}/sbin ${sbin})
        ;;
      *)
        print -u2 "warning: invalid __halostatue_macports_homebrew_order value: ${__halostatue_macports_homebrew_order}"
        ;;
    esac
  fi

  (( ${bin[(I)/opt/local/bin]} ))   || bin=(/opt/local/bin ${bin})
  (( ${sbin[(I)/opt/local/sbin]} )) || sbin=(/opt/local/sbin ${sbin})

  zpath_append ${bin} ${sbin}
}
