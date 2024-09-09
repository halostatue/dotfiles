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

return config
