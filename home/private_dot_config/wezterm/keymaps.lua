local wezterm = require("wezterm")
local action = wezterm.action
local direction_keys = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
  -- reverse lookup
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "CTRL|SHIFT" or "ALT|SHIFT",
    action = wezterm.action_callback(function(win, pane)
      if resize_or_move == "resize" then
        win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
      else
        win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
      end
    end),
  }
end

return {
  leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    -- move between split panes
    split_nav("move", "h"),
    split_nav("move", "j"),
    split_nav("move", "k"),
    split_nav("move", "l"),
    -- resize panes
    split_nav("resize", "h"),
    split_nav("resize", "j"),
    split_nav("resize", "k"),
    split_nav("resize", "l"),

    {
      key = "n",
      mods = "LEADER",
      action = action.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "\\",
      mods = "LEADER",
      action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "|",
      mods = "LEADER|SHIFT",
      action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "-",
      mods = "LEADER",
      action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "t",
      mods = "LEADER",
      action = action.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "[",
      mods = "LEADER",
      action = action.ActivateTabRelative(-1),
    },
    {
      key = "]",
      mods = "LEADER",
      action = action.ActivateTabRelative(1),
    },
    -- Detach from current domain
    {
      key = "D",
      mods = "LEADER",
      action = action.DetachDomain("CurrentPaneDomain"),
    },
    { key = "l", mods = "LEADER", action = action.ShowLauncher },
    { key = "n", mods = "LEADER", action = action.SpawnWindow },
    { key = "_", mods = "CTRL|SHIFT", action = action.DecreaseFontSize },
    { key = "0", mods = "CTRL|SHIFT", action = action.ResetFontSize },
    { key = "=", mods = "CTRL|SHIFT", action = action.IncreaseFontSize },
    { key = "y", mods = "LEADER", action = action.CopyTo("Clipboard") },
    { key = "p", mods = "LEADER", action = action.PasteFrom("PrimarySelection") },
    { key = "f", mode = "COMMAND", action = wezterm.action.ToggleFullScreen },
  },
}
