# vim: ft=bash

use_zig() {
  zig_inst -q "$1"
  ZIG_DIR="${HOME}/.local/share/zig/$1"
  ZIG_UPDATE="${ZIG_DIR}/zig_update"
  if [[ ! -f "${ZIG_UPDATE}" ]]; then
    echo -e "#!/bin/bash\nzig_inst -q -f $1\n" >"${ZIG_UPDATE}"
    chmod a+x "${ZIG_UPDATE}"
  fi
  PATH_add "${ZIG_DIR}" "./zig-cache/bin" "./zig-out/bin"
  echo "Using zig $1"
}
