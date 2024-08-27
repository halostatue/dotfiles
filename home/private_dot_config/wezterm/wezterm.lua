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
  require("events.gui-startup"),
  require("events.new-tab-button"),
  require("events.tab-title"),
  require("events.update-status"),
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

return config
