return function(config, _wezterm)
  config.launch_menu = {
    { args = { "top" } },
    {
      label = "Bash",
      args = { "bash", "-l" },
    },
  }
end
