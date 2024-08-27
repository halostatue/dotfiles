return function(_config, wezterm)
  wezterm.on("gui-startup", function(cmd)
    local main_screen = wezterm.gui.screens().main
    local position = {
      x = main_screen.width - 1440,
      y = 0,
      origin = "MainScreen",
    }

    cmd = cmd or { position = position }

    wezterm.mux.spawn_window(cmd)

    -- local _tab, _pane, window = wezterm.mux.spawn_window(cmd)
    -- local gui_window = window:gui_window()
    -- local dimensions = gui_window:get_dimensions()
    -- local main_screen = wezterm.gui.screens().main
    -- local x = main_screen.width - gui_window.pixel_width
    -- local y = 0

    -- gui_window:set_position(x, y)
  end)
end
