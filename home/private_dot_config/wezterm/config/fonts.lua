local platform = require("utils.platform")

return function(config, wezterm)
  config.font = wezterm.font({
    family = "JetBrains Mono",
    harfbuzz_features = { "ss02", "ss19", "zero", "calt", "clig" },
  })
  config.font_size = platform.is_mac and 10 or 9
end
