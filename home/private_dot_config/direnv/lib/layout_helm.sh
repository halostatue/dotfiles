# vim: ft=bash

layout_helm() {
  layout bin

  local arch package url package_path version bin
  version="${1:-3.11.0}"
  arch="$(uname -s | tr "[:upper:]" "[:lower:]")-$(uname -m)"
  package="helm-v${version}-${arch}.tar.gz"
  url="https://get.helm.sh/${package}"
  package_path="${DIRENV_TMP_DIR}/${package}"
  bin="$(direnv_layout_dir)/bin"

  if [[ ! -e "${bin}/helm" ]]; then
    echo "===> Getting helm:${version}:${arch}..."
    curl -sSL "${url}" -o "${package_path}"
    tar zx -f "${package_path}" -C "${DIRENV_TEMP_DIR}"
    mv "${DIRENV_TMP_DIR}/${arch}/helm" "${bin}"
    chmod 700 "${bin}/helm"
    rm -f "${package_path}" "${DIRENV_TMP_DIR}/${arch}"
  fi
}
