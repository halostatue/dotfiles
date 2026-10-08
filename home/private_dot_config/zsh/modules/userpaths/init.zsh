# vim: set ft=zsh
#
# userpaths: replicates the fish `fish_user_paths` entry for ~/.local/bin.
# zsh has no persistent universal-variable equivalent, so we assert it here.
# Ghostty injects its own bin dir via the `path` shell-integration feature;
# .bun/.deno are handled by their own modules.
() {
  zpath_prepend ${HOME}/.local/bin
}
