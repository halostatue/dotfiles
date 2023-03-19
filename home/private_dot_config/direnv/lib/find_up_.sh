find_up_() {
  (
    while true; do
      for v in "$@"; do
        if [[ -f "${v}" ]]; then
          echo "${PWD}/${v}"
          return 0
        fi
      done

      if [[ "${PWD}" == / ]] || [[ "${PWD}" == // ]]; then
        return 1
      fi

      cd ..
    done
  )
}
