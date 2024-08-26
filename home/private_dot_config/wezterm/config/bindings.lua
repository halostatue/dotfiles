local platform = require("utils.platform")

return function(config, wezterm)
  local act = wezterm.action
  -- Do not conflict with Windows key shortcuts
  local SUPER = platform.is_mac and "SUPER" or "ALT"
  local SUPER_REV = platform.is_mac and "SUPER|CTRL" or "ALT|CTRL"

  config.leader = { key = "\\", mods = "CTRL", timeout_milliseconds = 1000 }

  if platform.is_mac then
    config.disable_default_key_bindings = true
  end
  -- config.disable_default_mouse_bindings = true

  config.keys = {
    -- tabs: navigation
    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "Enter", mods = SUPER, action = act.ToggleFullScreen },
    { key = "[", mods = SUPER, action = act.ActivateTabRelative(-1) },
    { key = "]", mods = SUPER, action = act.ActivateTabRelative(1) },
    { key = "[", mods = SUPER_REV, action = act.MoveTabRelative(-1) },
    { key = "]", mods = SUPER_REV, action = act.MoveTabRelative(1) },
    { key = "1", mods = "SHIFT|CTRL", action = act.ActivateTab(0) },
    { key = "1", mods = "SUPER", action = act.ActivateTab(0) },
    { key = "2", mods = "SHIFT|CTRL", action = act.ActivateTab(1) },
    { key = "2", mods = "SUPER", action = act.ActivateTab(1) },
    { key = "3", mods = "SHIFT|CTRL", action = act.ActivateTab(2) },
    { key = "3", mods = "SUPER", action = act.ActivateTab(2) },
    { key = "4", mods = "SHIFT|CTRL", action = act.ActivateTab(3) },
    { key = "4", mods = "SUPER", action = act.ActivateTab(3) },
    { key = "5", mods = "SHIFT|CTRL", action = act.ActivateTab(4) },
    { key = "5", mods = "SUPER", action = act.ActivateTab(4) },
    { key = "6", mods = "SHIFT|CTRL", action = act.ActivateTab(5) },
    { key = "6", mods = "SUPER", action = act.ActivateTab(5) },
    { key = "7", mods = "SHIFT|CTRL", action = act.ActivateTab(6) },
    { key = "7", mods = "SUPER", action = act.ActivateTab(6) },
    { key = "8", mods = "SHIFT|CTRL", action = act.ActivateTab(7) },
    { key = "8", mods = "SUPER", action = act.ActivateTab(7) },
    { key = "9", mods = "SHIFT|CTRL", action = act.ActivateTab(-1) },
    { key = "9", mods = "SUPER", action = act.ActivateTab(-1) },

    { key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
    { key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    { key = "F", mods = "CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "F", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
    {
      key = "F",
      mods = "SHIFT|CTRL",
      action = act.Search("CurrentSelectionOrEmptyString"),
    },
    { key = "H", mods = "SUPER", action = act.HideApplication },
    { key = "K", mods = "SUPER", action = act.ClearScrollback("ScrollbackOnly") },
    {
      key = "K",
      mods = "SUPER|SHIFT",
      action = act.Multiple({
        act.ClearScrollback("ScrollbackAndViewport"),
        act.SendKey({ key = "L", mods = "CTRL" }),
      }),
    },

    { key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
    { key = "L", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
    { key = "M", mods = "SUPER", action = act.Hide },
    { key = "M", mods = "SHIFT|CTRL", action = act.Hide },
    { key = "N", mods = "CTRL", action = act.SpawnWindow },
    { key = "N", mods = "SHIFT|CTRL", action = act.SpawnWindow },
    { key = "P", mods = "CTRL", action = act.ActivateCommandPalette },
    { key = "P", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
    { key = "Q", mods = "CTRL", action = act.QuitApplication },
    { key = "Q", mods = "SHIFT|CTRL", action = act.QuitApplication },
    { key = "R", mods = "CTRL", action = act.ReloadConfiguration },
    { key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
    { key = "T", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "T", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },

    {
      key = "U",
      mods = "CTRL",
      action = act.CharSelect({
        copy_on_select = true,
        copy_to = "ClipboardAndPrimarySelection",
      }),
    },
    {
      key = "U",
      mods = "SHIFT|CTRL",
      action = act.CharSelect({
        copy_on_select = true,
        copy_to = "ClipboardAndPrimarySelection",
      }),
    },
    { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
    { key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    { key = "W", mods = "CTRL", action = act.CloseCurrentTab({ confirm = true }) },
    { key = "W", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
    { key = "X", mods = "CTRL", action = act.ActivateCopyMode },
    { key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
    { key = "Z", mods = "CTRL", action = act.TogglePaneZoomState },
    { key = "Z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
    { key = "[", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
    { key = "^", mods = "CTRL", action = act.ActivateTab(5) },
    { key = "^", mods = "SHIFT|CTRL", action = act.ActivateTab(5) },
    { key = "_", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
    { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
    {
      key = "f",
      mods = "SHIFT|CTRL",
      action = act.Search("CurrentSelectionOrEmptyString"),
    },
    { key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "h", mods = "SHIFT|CTRL", action = act.HideApplication },
    { key = "h", mods = "SUPER", action = act.HideApplication },
    { key = "k", mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
    { key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackOnly") },
    { key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
    { key = "m", mods = "SHIFT|CTRL", action = act.Hide },
    { key = "m", mods = "SUPER", action = act.Hide },
    {
      key = "n",
      mods = "SHIFT|CTRL",
      action = act.SpawnCommandInNewWindow({ cwd = wezterm.home_dir }),
    },
    {
      key = "n",
      mods = "SUPER",
      action = act.SpawnCommandInNewWindow({ cwd = wezterm.home_dir }),
    },
    { key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
    { key = "q", mods = "SHIFT|CTRL", action = act.QuitApplication },
    { key = "q", mods = "SUPER", action = act.QuitApplication },
    { key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
    { key = "r", mods = "SUPER", action = act.ReloadConfiguration },
    { key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
    {
      key = "u",
      mods = "SHIFT|CTRL",
      action = act.CharSelect({
        copy_on_select = true,
        copy_to = "ClipboardAndPrimarySelection",
      }),
    },
    { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
    { key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
    { key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
    { key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
    { key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
    { key = "{", mods = "SUPER", action = act.ActivateTabRelative(-1) },
    { key = "{", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
    { key = "}", mods = "SUPER", action = act.ActivateTabRelative(1) },
    { key = "}", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
    { key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
    { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
    { key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(-1) },
    { key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
    { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
    { key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
    {
      key = "LeftArrow",
      mods = "SHIFT|CTRL",
      action = act.ActivatePaneDirection("Left"),
    },
    {
      key = "LeftArrow",
      mods = "SHIFT|ALT|CTRL",
      action = act.AdjustPaneSize({ "Left", 1 }),
    },
    {
      key = "RightArrow",
      mods = "SHIFT|CTRL",
      action = act.ActivatePaneDirection("Right"),
    },
    {
      key = "RightArrow",
      mods = "SHIFT|ALT|CTRL",
      action = act.AdjustPaneSize({ "Right", 1 }),
    },
    { key = "UpArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
    {
      key = "UpArrow",
      mods = "SHIFT|ALT|CTRL",
      action = act.AdjustPaneSize({ "Up", 1 }),
    },
    {
      key = "DownArrow",
      mods = "SHIFT|CTRL",
      action = act.ActivatePaneDirection("Down"),
    },
    {
      key = "DownArrow",
      mods = "SHIFT|ALT|CTRL",
      action = act.AdjustPaneSize({ "Down", 1 }),
    },
    { key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
    { key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },

    -- misc/useful --
    { key = "F1", mods = "NONE", action = "ActivateCopyMode" },
    { key = "F2", mods = "NONE", action = act.ActivateCommandPalette },
    { key = "F3", mods = "NONE", action = act.ShowLauncher },
    {
      key = "F4",
      mods = "NONE",
      action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }),
    },
    {
      key = "F5",
      mods = "NONE",
      action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },
    { key = "F11", mods = "NONE", action = act.ToggleFullScreen },
    { key = "F12", mods = "NONE", action = act.ShowDebugOverlay },
    { key = "f", mods = SUPER, action = act.Search({ CaseInSensitiveString = "" }) },
    {
      key = "u",
      mods = SUPER,
      action = act.QuickSelectArgs({
        label = "open url",
        patterns = {
          "\\((https?://\\S+)\\)",
          "\\[(https?://\\S+)\\]",
          "\\{(https?://\\S+)\\}",
          "<(https?://\\S+)>",
          "\\bhttps?://\\S+[)/a-zA-Z0-9-]+",
        },
        action = wezterm.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          wezterm.log_info("opening: " .. url)
          wezterm.open_with(url)
        end),
      }),
    },

    -- cursor movement --
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    { key = "LeftArrow", mods = "OPT", action = act({ SendString = "\x1bb" }) },
    -- Make Option-Right equivalent to Alt-f; forward-word
    { key = "RightArrow", mods = "OPT", action = act({ SendString = "\x1bf" }) },
    { key = "LeftArrow", mods = SUPER, action = act.SendString("\x1bOH") },
    { key = "RightArrow", mods = SUPER, action = act.SendString("\x1bOF") },
    { key = "Backspace", mods = SUPER, action = act.SendString("\x15") },
    -- ctrl-backspace does what ctrl-u does, clears an entire input line
    {
      key = "Backspace",
      mods = "CTRL",
      action = act.SendKey({ key = "u", mods = "CTRL" }),
    },
    -- search for things that look like git hashes
    {
      key = "h",
      mods = "SHIFT|CTRL",
      action = act.Search({ Regex = "[a-fA-F0-9]{6,}" }),
    },

    {
      key = ",",
      mods = SUPER,
      action = act.SpawnCommandInNewWindow({
        cwd = wezterm.config_dir,
        args = {
          os.getenv("SHELL"),
          "-c",
          "$EDITOR " .. wezterm.shell_quote_arg(wezterm.config_file),
        },
      }),
    },
    {
      key = "t",
      mods = SUPER .. "|SHIFT",
      action = act.ShowTabNavigator,
    },

    -- copy/paste --
    { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

    -- tabs --
    -- tabs: spawn+close
    { key = "t", mods = SUPER, action = act.SpawnTab("DefaultDomain") },
    {
      key = "w",
      mods = SUPER_REV,
      action = act.CloseCurrentTab({ confirm = false }),
    },

    -- window --
    -- spawn windows
    -- new window should start at ~ not current PWD
    {
      key = "n",
      mods = SUPER,
      action = act.SpawnCommandInNewWindow({ cwd = wezterm.home_dir }),
    },

    -- panes --
    -- panes: split panes
    {
      key = [[\]],
      mods = SUPER,
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = [[\]],
      mods = SUPER_REV,
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },

    -- panes: zoom+close pane
    { key = "Enter", mods = SUPER, action = act.TogglePaneZoomState },
    {
      key = "w",
      mods = SUPER,
      action = act.CloseCurrentPane({ confirm = false }),
    },

    -- panes: navigation
    { key = "k", mods = SUPER_REV, action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = SUPER_REV, action = act.ActivatePaneDirection("Down") },
    { key = "h", mods = SUPER_REV, action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = SUPER_REV, action = act.ActivatePaneDirection("Right") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    -- Detach from current domain
    {
      key = "D",
      mods = "LEADER",
      action = act.DetachDomain("CurrentPaneDomain"),
    },
    { key = "l", mods = "LEADER", action = act.ShowLauncher },
    {
      key = "n",
      mods = "LEADER",
      action = act.SpawnCommandInNewWindow({ cwd = wezterm.home_dir }),
    },
    { key = "y", mods = "LEADER", action = act.CopyTo("Clipboard") },
    { key = "p", mods = "LEADER", action = act.PasteFrom("PrimarySelection") },
    {
      key = "p",
      mods = SUPER_REV,
      action = act.PaneSelect({
        alphabet = "1234567890",
        mode = "SwapWithActiveKeepFocus",
      }),
    },

    -- key-tables --
    -- resizes fonts
    {
      key = "f",
      mods = "LEADER",
      action = act.ActivateKeyTable({
        name = "resize_font",
        one_shot = false,
        timemout_miliseconds = 1000,
      }),
    },
    -- resize panes
    {
      key = "p",
      mods = "LEADER",
      action = act.ActivateKeyTable({
        name = "resize_pane",
        one_shot = false,
        timemout_miliseconds = 1000,
      }),
    },
    {
      key = "\\",
      mods = "LEADER",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "|",
      mods = "LEADER|SHIFT",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "-",
      mods = "LEADER",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "t",
      mods = "LEADER",
      action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "[",
      mods = "LEADER",
      action = act.ActivateTabRelative(-1),
    },
    {
      key = "]",
      mods = "LEADER",
      action = act.ActivateTabRelative(1),
    },
  }

  config.key_tables = {
    resize_font = {
      { key = "k", action = act.IncreaseFontSize },
      { key = "j", action = act.DecreaseFontSize },
      { key = "r", action = act.ResetFontSize },
      { key = "Escape", action = "PopKeyTable" },
      { key = "q", action = "PopKeyTable" },
    },

    resize_pane = {
      { key = "k", action = act.AdjustPaneSize({ "Up", 3 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 3 }) },
      { key = "h", action = act.AdjustPaneSize({ "Left", 3 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 3 }) },
      { key = "Escape", action = "PopKeyTable" },
      { key = "q", action = "PopKeyTable" },
    },

    copy_mode = {
      { key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
      { key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
      { key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
      {
        key = "Escape",
        mods = "NONE",
        action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }),
      },
      {
        key = "Space",
        mods = "NONE",
        action = act.CopyMode({ SetSelectionMode = "Cell" }),
      },
      { key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
      { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
      { key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
      { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
      { key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
      {
        key = "F",
        mods = "NONE",
        action = act.CopyMode({ JumpBackward = { prev_char = false } }),
      },
      {
        key = "F",
        mods = "SHIFT",
        action = act.CopyMode({ JumpBackward = { prev_char = false } }),
      },
      { key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
      { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
      { key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
      { key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
      { key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
      { key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
      { key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
      { key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
      { key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
      {
        key = "O",
        mods = "SHIFT",
        action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
      },
      {
        key = "T",
        mods = "NONE",
        action = act.CopyMode({ JumpBackward = { prev_char = true } }),
      },
      {
        key = "T",
        mods = "SHIFT",
        action = act.CopyMode({ JumpBackward = { prev_char = true } }),
      },
      { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
      { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
      { key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
      { key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
      { key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
      {
        key = "c",
        mods = "CTRL",
        action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }),
      },
      { key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
      { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
      {
        key = "f",
        mods = "NONE",
        action = act.CopyMode({ JumpForward = { prev_char = false } }),
      },
      { key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
      { key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
      { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
      {
        key = "g",
        mods = "CTRL",
        action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }),
      },
      { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
      { key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
      {
        key = "q",
        mods = "NONE",
        action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }),
      },
      {
        key = "t",
        mods = "NONE",
        action = act.CopyMode({ JumpForward = { prev_char = true } }),
      },
      { key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
      { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
      { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
      { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
      {
        key = "y",
        mods = "NONE",
        action = act.Multiple({
          { CopyTo = "ClipboardAndPrimarySelection" },
          { Multiple = { "ScrollToBottom", { CopyMode = "Close" } } },
        }),
      },
      { key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
      { key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
      { key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
      { key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
      { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
      { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
      { key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
      { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
    },

    search_mode = {
      -- { key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
      { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
      { key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
      { key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
      { key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
      { key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
      { key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
      { key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
      { key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
      { key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
      {
        key = "Enter",
        mods = "NONE",
        action = act.Multiple({
          { CopyTo = "PrimarySelection" },
          { CopyMode = "Close" },
          { PasteFrom = "PrimarySelection" },
        }),
      },
    },
  }

  config.mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = act.OpenLinkAtMouseCursor,
    },
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "SUPER",
      action = act.OpenLinkAtMouseCursor,
    },
  }

  config.mouse_wheel_scrolls_tabs = false

  -- config.leader = { key = 'Space', mods = SUPER_REV }
end
