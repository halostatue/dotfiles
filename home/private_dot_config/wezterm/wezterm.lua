local config = require("config")({
  require("config.appearance"),
  require("config.bindings"),
  require("config.domains"),
  require("config.fonts"),
  require("config.general"),
  require("config.launch"),
  require("config.platform"),
  require("config.ssh"),
  require("config.term"),
  require("events.left-status"),
  require("events.new-tab-button"),
  require("events.right-status"),
  require("events.tab-title"),
}).config

local wezterm = require("wezterm")

-- function run_with_unicode_version_9() {
--   local label=$(uuidgen)
--   printf "\e]1337;UnicodeVersion=push %s\e\\" $label
--   printf "\e]1337;UnicodeVersion=9\e\\"
--   eval $@
--   local result=${PIPESTATUS[0]}
--   printf "\e]1337;UnicodeVersion=pop %s\e\\" $label
--   return $result
-- }
--
-- # Connect to a remote machine with an older version of unicode
-- run_with_unicode_version_9 ssh remote.machine

-- config.color_scheme = 'kanagawabones'
-- config.color_scheme = 'OneHalfBlack (Gogh)'
-- config.color_scheme = 'Scarlet Protocol'
-- config.color_scheme = "Solarized Dark Higher Contrast"
-- config.color_scheme = 'Modus-Vivendi'
-- config.color_scheme = 'MaterialDarker'
-- config.color_scheme = 'Nucolors (terminal.sexy)'

wezterm.on("gui-startup", function(cmd)
  if not cmd then
    local main_screen = wezterm.gui.screens().main
    local x = main_screen.width - 1440
    local y = 0

    cmd.position = {
      x = x,
      y = y,
      origin = "MainScreen",
    }
  end

  local _tab, _pane, window = wezterm.mux.spawn_window(cmd)
  -- local gui_window = window:gui_window()
  -- local dimensions = gui_window:get_dimensions()
  -- local main_screen = wezterm.gui.screens().main
  -- local x = main_screen.width - gui_window.pixel_width
  -- local y = main_screen.height - gui_window.pixel_height

  -- gui_window:set_position(x, y)
end)

-- wezterm.on('gui-startup', function(cmd)
--   local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
--   -- can we make it max height on right side of main screen?
-- end)

return config
