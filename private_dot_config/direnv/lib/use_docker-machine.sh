# vim: ft=bash

use_docker-machine() {
  local env machine_cmd
  env="${1:-default}"
  echo Docker machine: "${env}"
  machine_cmd=$(docker-machine env --shell bash "${env}")
  eval "${machine_cmd}"
}
