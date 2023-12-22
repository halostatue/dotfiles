version = "0.21.1"

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -d '%s/.git' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

require("xpm").setup({
  plugins = {
    "dtomvan/ouch.xplr",
    "dtomvan/xpm.xplr",
    "junker/nuke.xplr",
    "sayanarijit/dual-pane.xplr",
    "sayanarijit/fzf.xplr",
    "sayanarijit/preview-tabbed.xplr",
    "sayanarijit/registers.xplr",
    "sayanarijit/tri-pane.xplr",
    "sayanarijit/type-to-nav.xplr",
    "sayanarijit/zentable.xplr",
    "sayanarijit/zoxide.xplr",
  },
  auto_install = true,
  auto_cleanup = true,
})

xplr.config.modes.builtin.default.key_bindings.on_key.x = {
  help = "xpm",
  messages = {
    "PopMode",
    { SwitchModeCustom = "xpm" },
  },
}

-- General Configuration
xplr.config.general.enable_mouse = true
xplr.config.general.show_hidden = true
-- xplr.config.general.enable_recover_mode = true

-- xplr.fn.builtin.try_complete_path
--   Tries to auto complete the path in the input buffer
-- xplr.fn.builtin.fmt_general_table_row_cols_0
--   Renders the first column in the table
-- xplr.fn.builtin.fmt_general_table_row_cols_1
--   Renders the second column in the table
-- xplr.fn.builtin.fmt_general_table_row_cols_2
--   Renders the third column in the table
-- xplr.fn.builtin.fmt_general_table_row_cols_3
--   Renders the fourth column in the table
-- xplr.fn.builtin.fmt_general_table_row_cols_4
--   Renders the fifth column in the table
-- xplr.fn.custom
--   This is where the custom functions can be added.
--
--   There is currently no restriction on what kind of functions can be
--   defined in xplr.fn.custom.
--
--   You can also use nested tables such as
--   xplr.fn.custom.my_plugin.my_function to define custom functions.

-- Hooks
-- This section of the configuration cannot be overwritten by another config
-- file or plugin, since this is an optional lua return statement specific
-- to each config file. It can be used to define things that should be
-- explicit for reasons like performance concerns, such as hooks.
--
-- Plugins should expose the hooks, and require users to subscribe to them
-- explicitly.
--
-- Example:
--   return {
--     -- Add messages to send when the xplr loads.
--     -- This is similar to the `--on-load` command-line option.
--     --
--     -- Type: list of [Message](https://xplr.dev/en/message#message)s
--     on_load = {
--       { LogSuccess = "Configuration successfully loaded!" },
--       { CallLuaSilently = "custom.some_plugin_with_hooks.on_load" },
--     },

--     -- Add messages to send when the directory changes.
--     --
--     -- Type: list of [Message](https://xplr.dev/en/message#message)s
--     on_directory_change = {
--       { LogSuccess = "Changed directory" },
--       { CallLuaSilently = "custom.some_plugin_with_hooks.on_directory_change" },
--     },

--     -- Add messages to send when the focus changes.
--     --
--     -- Type: list of [Message](https://xplr.dev/en/message#message)s
--     on_focus_change = {
--       { LogSuccess = "Changed focus" },
--       { CallLuaSilently = "custom.some_plugin_with_hooks.on_focus_change" },
--     }

--     -- Add messages to send when the mode is switched.
--     --
--     -- Type: list of [Message](https://xplr.dev/en/message#message)s
--     on_mode_switch = {
--       { LogSuccess = "Switched mode" },
--       { CallLuaSilently = "custom.some_plugin_with_hooks.on_mode_switch" },
--     }

--     -- Add messages to send when the layout is switched
--     --
--     -- Type: list of [Message](https://xplr.dev/en/message#message)s
--     on_layout_switch = {
--       { LogSuccess = "Switched layout" },
--       { CallLuaSilently = "custom.some_plugin_with_hooks.on_layout_switch" },
--     }
--   }
