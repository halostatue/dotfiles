local platform = require("utils.platform")

return function(config, wezterm)
  config.font = wezterm.font({
    family = "JetBrains Mono",
    weight = "Regular",
    harfbuzz_features = { "ss02=1", "ss19=1", "zero=1", "calt=1", "clig=1", "liga=1" },
  })
  config.font_size = platform.is_mac and 10 or 9
  config.line_height = 1.2
  config.freetype_load_flags = "NO_HINTING"
  config.freetype_load_target = "Light"
  config.freetype_render_target = "HorizontalLcd"
end
