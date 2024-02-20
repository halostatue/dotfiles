# This is a wrapper around `use_mise` if it exists.
use_rtx() {
  if has use_mise; then
    use_mise "$@"
  elif has mise; then
    direnv_load mise direnv exec
  else
    direnv_load rtx direnv exec
  fi
}
