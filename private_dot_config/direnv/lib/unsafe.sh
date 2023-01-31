if has unstrict_env; then
  unsafe() {
    unstrict_env "$@"
  }
else
  unsafe() {
    local res

    set +u

    "$@"

    res=${?}
    set -u

    return "${res}"
  }
fi
