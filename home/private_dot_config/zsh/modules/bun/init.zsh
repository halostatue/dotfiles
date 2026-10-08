# vim: set ft=zsh
#
# bun: port of the ~/.bun/bin handling from config.fish. Adds ~/.bun/bin only
# when the bun binary exists, and exports BUN_INSTALL if unset.
() {
  [[ -x ${HOME}/.bun/bin/bun ]] || return 0
  : ${BUN_INSTALL:=${HOME}/.bun}
  export BUN_INSTALL
  zpath_prepend ${HOME}/.bun/bin
}
