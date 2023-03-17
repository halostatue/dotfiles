.venvs | to_entries[] | .key as $name | .value.metadata | [
  (
    .main_package | [
      "pipx", "install", .package_or_url,
      if .include_dependencies then "--include-deps" else null end,
      if .pip_args != [] then ["--pip-args", .pip_args] else null end,
      if .suffix != "" then ["--suffix", .suffix] else null end
    ] | select(. != null) | flatten | join(" ")
  ),
  (
    .injected_packages | map([
      "pipx", "inject", $name, .package_or_url,
      if .include_dependencies then "--include-deps" else null end,
      if .include_apps then "--include-apps" else null end,
      if .pip_args != [] then ["--pip-args", .pip_args] else null end,
      if .suffix != "" then ["--suffix", .suffix] else null end
    ] | select(. != null) | flatten | join(" "))
  )
] | flatten | join("\n")
