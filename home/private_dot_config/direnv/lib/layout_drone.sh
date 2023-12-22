# vim: ft=bash

layout_drone() {
  layout bin

  local arch package url package_path version bin
  version="${1:-latest}"
  arch="$(uname -s | tr "[:upper:]" "[:lower:]")_$(uname -m)"
  package="drone_${arch}.tar.gz"
  url="https://github.com/drone/drone-cli/releases/${version}/download/${package}"
  package_path="${DIRENV_TMP_DIR}/${package}"
  bin="$(direnv_layout_dir)/bin"

  if [[ ! -e "${bin}/drone" ]]; then
    echo "===> Getting drone:${version}:${arch}..."
    curl -sSL "${url}" -o "${package_path}"
    tar zx -f "${package_path}" -C "${bin}"
    chmod 700 "${bin}/drone"
    rm -f "${package_path}"
  fi
}
