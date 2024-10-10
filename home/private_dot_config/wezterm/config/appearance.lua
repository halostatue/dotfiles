local platform = require("utils.platform")

return function(config, wezterm)
  -- scrollbar
  config.enable_scroll_bar = true
  config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.65,
  }

  if platform.is_mac then
    -- prevent lagging on "Mission Control" zoom out
    -- https://github.com/wez/wezterm/issues/2669
    config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
    -- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE|MACOS_FORCE_DISABLE_SHADOW"
  else
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  end

  config.initial_cols = 118
  config.initial_rows = 65

  local color_scheme = platform.is_dark() and "Tiniri Dark" or "Tiniri Light"
  color_scheme = "Tiniri Dark"

  config.color_scheme = color_scheme

  if color_scheme:find("Tiniri") ~= nil then
    local background_file = wezterm.config_dir
      .. "/colors/"
      .. color_scheme:gsub("%s+", "-")
      .. ".png"

    wezterm.log_info(color_scheme, background_file)

    config.background = {
      {
        source = {
          File = background_file,
        },
        width = 600,
        height = 600,
        repeat_x = "Mirror",
        repeat_y = "Mirror",
      },
    }
  end

  config.window_background_opacity = 0.95
  if platform.is_mac then
    config.macos_window_background_blur = 30
  end

  config.char_select_font_size = 14
  config.command_palette_font_size = 14

  config.tab_max_width = 64

  config.window_frame = {
    font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
    font_size = 12,
  }
end
