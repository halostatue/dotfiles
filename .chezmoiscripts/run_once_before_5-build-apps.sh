#!/usr/bin/env bash

set -euo pipefail

echo run_once_before_5-build-apps.sh

case "${CHEZMOI_SKIP_SCRIPTS:-}" in
*build-apps* | true | '*' | 1) exit ;;
esac

cd "$(mktemp -d)"

# PG Modeler
build-pg-modeler() (
  [[ -d /Applications/pgModeler.app ]] && return 0

  if [[ "$(uname -s)" == Darwin ]] && [[ -d /opt/local/libexec/qt5/bin ]]; then
    PATH="/opt/local/libexec/qt5/bin:${PATH}"
  fi

  if ! command -v qmake; then
    echo "Cannot build pg-modeler; 'qmake' not found. Is Qt 5 installed?"
    return 1
  fi

  if ! command -v pg_config; then
    echo "Cannot build pg-modeler; 'pg_config' not found. Is Postgres installed?"
    return 1
  fi

  git clone https://github.com/pgmodeler/pgmodeler.git
  cd pgmodeler
  git checkout main

  /opt/local/libexec/qt5/bin/qmake \
    PGSQL_LIB="$(pg_config --libdir)/libpq.dylib" \
    PGSQL_INC="$(pg_config --includedir)" \
    -r pgmodeler.pro
  make -j "$(expr "$(getconf _NPROCESSORS_ONLN)" + 1)"
  make install
)

build-git-switch-user() (
  [[ -x "${HOME}"/.cargo/bin/git-switch-user ]] && return 0

  git clone https://github.com/cquintana92/git-switch-user.git
  cd git-switch-user
  cargo install --locked --path .
)

build-unused-code() (
  [[ -x "${HOME}"/.cargo/bin/unused ]] && return 0

  git clone https://github.com/unused-code/unused
  cd unused
  declare -a features

  if [[ "$(uname -s)" == Darwin ]] && [[ "$(uname -m)" != arm64 ]]; then
    features=(--features mimalloc)
  fi

  cargo install --locked --path . "${features[@]}"
)

build-tfschema() (
  [[ -x "${HOME}"/go/bin/unused ]] && return 0

  git clone https://github.com/minamijoyo/tfschema
  cd tfschema

  go install
)

build-pg-modeler
build-git-switch-user
build-unused-code
build-tfschema
