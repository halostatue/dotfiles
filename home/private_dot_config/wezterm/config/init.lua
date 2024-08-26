local wezterm = require("wezterm")

return function(functions)
  local config = wezterm.config_builder()

  for _, fn in pairs(functions) do
    if type(fn) == "function" then
      fn(config, wezterm)
    end
  end

  return { wezterm = wezterm, config = config }
end
