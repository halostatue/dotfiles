# vim: ft=bash

layout_bin() {
  mkdir -p "$(direnv_layout_dir)/bin"
  PATH_add PATH "$(direnv_layout_dir)/bin"
}
