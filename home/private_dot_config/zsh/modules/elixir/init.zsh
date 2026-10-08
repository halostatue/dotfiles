# vim: set ft=zsh
#
# elixir: faithful port of @halostatue/fish-elixir (v2.0.4)
#
# Appends ~/.mix and ~/.mix/escripts if ~/.mix exists.
# fish: fish_add_path --path --append $HOME/.mix $HOME/.mix/escripts
() {
  [[ -d ${HOME}/.mix ]] || return 0
  zpath_append ${HOME}/.mix ${HOME}/.mix/escripts
}
