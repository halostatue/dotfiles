# vim: set ft=zsh
#
# go: faithful port of @halostatue/fish-go (v2.1.2)
#
# fish prepends GOROOT/bin, then prepends GOPATH/bin, so GOPATH/bin ends up
# ahead of GOROOT/bin. Guarded by `--if-command go` in .zimrc.
() {
  (( ${+commands[go]} )) || return 0

  # Prepend GOROOT first, then GOPATH, so GOPATH lands in front.
  zpath_prepend "$(go env GOROOT)/bin"
  zpath_prepend "$(go env GOPATH)/bin"
}
