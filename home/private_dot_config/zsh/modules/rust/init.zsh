# vim: set ft=zsh
#
# rust: faithful port of @halostatue/fish-rust (v2.0.2)
#
# Prepends ${CARGO_HOME:-~/.cargo}/bin to PATH if it exists.
# fish: fish_add_path --prepend --path $cargo_bin
() {
  local cargo_bin=${HOME}/.cargo/bin
  [[ -n ${CARGO_HOME:-} ]] && cargo_bin=${CARGO_HOME}/bin
  zpath_prepend ${cargo_bin}
}
