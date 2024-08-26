local platform = require("utils.platform")

return function(config, _wezterm)
  if platform.is_mac then
    config.native_macos_fullscreen_mode = true
    config.unicode_version = 14
    config.set_environment_variables = {
      PATH = platform.add_path(os.getenv("PATH"), {
        "/Users/austin/.local/bin/",
        "/opt/local/bin",
        "/Users/austin/go/bin/",
        "/opt/local/lib/go/bin",
        "/Users/austin/.cargo/bin/",
        "/opt/homebrew/bin",
      }),
    }

    config.send_composed_key_when_left_alt_is_pressed = true
    config.send_composed_key_when_right_alt_is_pressed = false
  end
end
