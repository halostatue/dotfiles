local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.font = wezterm.font({ family = "JetBrains Mono" })
config.window_frame = {}

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"
config.initial_cols = 106
config.initial_rows = 56
config.window_background_opacity = 0.7
config.macos_window_background_blur = 10
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 75,
  fade_out_function = "EaseIn",
  fade_out_duration_ms = 75,
}
config.colors = {
  visual_bell = "#202020",
}
config.harfbuzz_features = {
  "zero", -- Use a slashed zero '0' (instead of dotted)
  "kern", -- (default) kerning (todo check what is really is)
  "liga", -- (default) ligatures
  "clig", -- (default) contextual ligatures
}

return config
