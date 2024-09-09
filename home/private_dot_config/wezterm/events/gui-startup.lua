return function(_config, wezterm)
  wezterm.on("gui-startup", function(cmd)
    local main_screen = wezterm.gui.screens().main

    cmd = cmd
      or {
        position = {
          x = main_screen.width - 1440,
          y = 0,
          origin = "MainScreen",
        },
      }

    wezterm.mux.spawn_window(cmd)
  end)
end
