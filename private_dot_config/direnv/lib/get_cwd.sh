# vim: ft=bash

get_cwd() {
  p="$(expand_path "$1")"
  # http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash#comment14090830_1403489
  local t="${p%${p##*/}}"
  echo "${t%/}"
}
