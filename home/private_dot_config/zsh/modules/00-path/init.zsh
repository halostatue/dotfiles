# vim: set ft=zsh
#
# 00-path: deduplicated path/PATH, move-aware helpers, and the deterministic
# base ordering that mirrors the effective fish $PATH tail.
#
# zsh ties the `path` array to the `PATH` scalar. Marking it -U (unique) keeps
# only the first occurrence of each entry. That alone does NOT relocate an
# existing entry on re-add, so to reproduce fish's `fish_add_path --move`
# (remove-then-add) we provide explicit helpers below.
typeset -gU path fpath PATH FPATH

# zpath_prepend DIR...  -- prepend dirs (move if already present), fish's
#                          `fish_add_path --prepend --move`. Last arg ends up
#                          first, matching `set --prepend` applied left-to-right
#                          is NOT what we want; we iterate in reverse so the
#                          given order is preserved at the front.
zpath_prepend() {
  local dir
  local -a add=()
  for dir in "$@"; do
    [[ -d ${dir} ]] || continue
    add+=(${dir})
  done
  (( ${#add} )) || return 0
  # remove existing occurrences, then place at front in given order
  path=(${add} ${path:|add})
}

# zpath_append DIR...   -- append dirs (move if already present), fish's
#                          `fish_add_path --append --move`.
zpath_append() {
  local dir
  local -a add=()
  for dir in "$@"; do
    [[ -d ${dir} ]] || continue
    add+=(${dir})
  done
  (( ${#add} )) || return 0
  path=(${path:|add} ${add})
}

# Seed the macOS-managed base that no other module owns: the cryptex and
# paths.d entries. These sit beneath the personal/package-manager dirs that
# later modules prepend, and above nothing in particular -- they are the floor.
#
# We deliberately do NOT seed /opt/* or /usr/* here; the macports and brew
# modules own the ordered opt+system block and will prepend it so MacPorts and
# Homebrew land ahead of /usr/bin (the whole point of this exercise).
zpath_append \
  /System/Cryptexes/App/usr/bin \
  /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin \
  /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin \
  /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin \
  /pkg/env/global/bin \
  /Library/Apple/usr/bin
