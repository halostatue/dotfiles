re_join() {
  local IFS="$1"
  shift
  printf "%s" "$*"
}
