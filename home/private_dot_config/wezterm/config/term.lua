return function(config, wezterm)
  if #wezterm.glob(string.format("%s/.terminfo/*/wezterm", wezterm.home_dir)) > 0 then
    config.term = "wezterm"
  end
end
