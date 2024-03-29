# vim: ft=bash

layout_haskell() {
  [[ -d ~/.cabal/bin ]] || return

  PATH_rm ~/.cabal/bin .cabal-sandbox/bin

  PATH_add ~/.cabal/bin

  [[ -d .cabal-sandbox ]] || cabal sandbox init
  PATH_add .cabal-sandbox/bin

  export GHC_PACKAGE_PATH
  GHC_PACKAGE_PATH="$(cabal exec -- sh -c "echo \$GHC_PACKAGE_PATH")"
}
