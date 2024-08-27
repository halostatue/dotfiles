local platform = require("utils.platform")

return function(config, wezterm)
  -- I don't use Windows or Linux as a daily driver, so key bindings are ignored on
  -- non-macOS platforms.
  if not platform.is_mac then
    return
  end

  local act = wezterm.action

  config.disable_default_key_bindings = true
  -- config.disable_default_mouse_bindings = true

  config.leader = { key = "\\", mods = "CTRL", timeout_milliseconds = 1000 }

  local NextTab = act.ActivateTabRelative(1)
  local PrevTab = act.ActivateTabRelative(-1)
  local NewHomeWindow = act.SpawnCommandInNewWindow({ cwd = wezterm.home_dir })
  local ActivateLeftPane = act.ActivatePaneDirection("Left")
  local ActivateRightPane = act.ActivatePaneDirection("Right")
  local ActivateUpPane = act.ActivatePaneDirection("Up")
  local ActivateDownPane = act.ActivatePaneDirection("Down")

  config.keys = {
    -- Ctrl-Tab: Next Tab
    { key = "Tab", mods = "CTRL", action = NextTab },
    -- Cmd-Shift-]: Next Tab
    { key = "]", mods = "CMD|SHIFT", action = NextTab },
    -- Ctrl-Shift-Tab: Previous Tab
    { key = "Tab", mods = "SHIFT|CTRL", action = PrevTab },
    -- Cmd-Shift-[: Previous Tab
    { key = "[", mods = "CMD|SHIFT", action = PrevTab },
    -- Cmd-1 .. Cmd-8: Select Tabs 1..8
    { key = "1", mods = "CMD", action = act.ActivateTab(0) },
    { key = "2", mods = "CMD", action = act.ActivateTab(1) },
    { key = "3", mods = "CMD", action = act.ActivateTab(2) },
    { key = "4", mods = "CMD", action = act.ActivateTab(3) },
    { key = "5", mods = "CMD", action = act.ActivateTab(4) },
    { key = "6", mods = "CMD", action = act.ActivateTab(5) },
    { key = "7", mods = "CMD", action = act.ActivateTab(6) },
    { key = "8", mods = "CMD", action = act.ActivateTab(7) },
    -- Cmd-9: Selects Last Tab
    { key = "9", mods = "CMD", action = act.ActivateTab(-1) },

    -- Cmd-Enter: Full Screen Toggle
    { key = "Enter", mods = "CMD", action = act.ToggleFullScreen },

    -- Cmd-Q: Quit Application
    { key = "q", mods = "CMD", action = act.QuitApplication },

    -- Cmd-W: Close Current Pane, Tab, or Window
    { key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
    -- Cmd-Ctrl-W: Close Current Pane, Tab, or Window without confirming
    { key = "w", mods = "CMD|CTRL", action = act.CloseCurrentPane({ confirm = false }) },

    -- Cmd-R: Reload Configuration
    { key = "r", mods = "CMD", action = act.ReloadConfiguration },

    -- Cmd-T: Create a Tab
    { key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
    -- Cmd-Shift-T: Show the tab navigator
    { key = "t", mods = "CMD|SHIFT", action = act.ShowTabNavigator },

    -- Cmd-U: Character Select to Clipboard
    {
      key = "u",
      mods = "CMD",
      action = act.CharSelect({
        copy_on_select = true,
        copy_to = "ClipboardAndPrimarySelection",
      }),
    },
    -- Cmd-Shift-U: Quick Select URLs
    {
      key = "u",
      mods = "CMD|SHIFT",
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

    -- Cmd-P: Activate Command Palette
    { key = "p", mods = "CMD", action = act.ActivateCommandPalette },
    -- Cmd-Shift-P: Activate Pane Selection
    {
      key = "p",
      mods = "CMD|SHIFT",
      action = act.PaneSelect({ mode = "SwapWithActive" }),
    },

    -- -- -- Cmd-D: Horizontal Split
    -- {
    --   key = "d",
    --   mods = "CMD",
    --   action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    -- },
    -- -- -- Cmd-Shift-D: Vertical Split
    -- {
    --   key = "d",
    --   mode = "SHIFT|CMD",
    --   action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    -- },

    -- Cmd-F: Search (default to current selection)
    { key = "f", mods = "CMD", action = act.Search("CurrentSelectionOrEmptyString") },

    -- Cmd-H: Hide the application
    { key = "h", mods = "CMD", action = act.HideApplication },
    -- Cmd-Ctrl-H: Activate the pane to the left
    { key = "h", mods = "CMD|CTRL", action = ActivateLeftPane },
    -- Cmd-Shift-H: Search for git ref-alikes
    {
      key = "h",
      mods = "CMD|SHIFT",
      action = act.Search({ Regex = "[a-fA-F0-9]{6,}" }),
    },

    -- Cmd-Ctrl-J: Activate the pane below
    { key = "j", mods = "CMD|CTRL", action = ActivateDownPane },

    -- Cmd-K: Clear the scrollback
    { key = "k", mods = "CMD", action = act.ClearScrollback("ScrollbackOnly") },
    -- Cmd-Ctrl-K: Activate the pane above
    { key = "k", mods = "CMD|CTRL", action = ActivateUpPane },
    -- Cmd-Shift-K: Clear the scrollback and clear the terminal
    {
      key = "k",
      mods = "CMD|SHIFT",
      action = act.Multiple({
        act.ClearScrollback("ScrollbackAndViewport"),
        act.SendKey({ key = "L", mods = "CTRL" }),
      }),
    },

    -- Cmd-Ctrl-L: Activate the pane to the right
    { key = "l", mods = "CMD|CTRL", action = ActivateRightPane },
    -- Cmd-Shift-L: Show the Debug Overlay
    { key = "l", mods = "CMD|SHIFT", action = act.ShowDebugOverlay },
    -- Ctrl-Shift-L: Show the Debug Overlay
    { key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
    { key = "L", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },

    -- Cmd-Z: Toggle the active pane's zoom state
    { key = "z", mods = "CMD", action = act.TogglePaneZoomState },

    -- Cmd-X: Activate Copy Mode
    { key = "x", mods = "CMD", action = act.ActivateCopyMode },
    -- Cmd-C: Copy to Clipboard
    { key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
    -- Cmd-V: Paste from Clipboard
    { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

    -- Cmd-N: Open a new window (~)
    { key = "n", mods = "CMD", action = NewHomeWindow },

    -- Cmd-M: Minimize the current window
    { key = "m", mods = "CMD", action = act.Hide },

    -- Cmd-,: Open the main wezterm config file
    {
      key = ",",
      mods = "CMD",
      action = act.SpawnCommandInNewWindow({
        cwd = wezterm.config_dir,
        args = {
          os.getenv("SHELL"),
          "-c",
          "$EDITOR " .. wezterm.shell_quote_arg(wezterm.config_file),
        },
      }),
    },

    -- Ctrl-Shift Spacebar: Activate Quick Select
    { key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },

    -- I don't have a keyboard with page up and page down, but keep these anyway
    { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
    { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },

    -- Shift-Ctrl-*Arrow activates the pane in that direction
    { key = "LeftArrow", mods = "SHIFT|CTRL", action = ActivateLeftPane },
    { key = "RightArrow", mods = "SHIFT|CTRL", action = ActivateRightPane },
    { key = "UpArrow", mods = "SHIFT|CTRL", action = ActivateUpPane },
    { key = "DownArrow", mods = "SHIFT|CTRL", action = ActivateDownPane },

    -- Option-LeftArrow: Backward Word
    { key = "LeftArrow", mods = "OPT", action = act.SendString("\x1bb") },
    -- Cmd-LeftArrow: Beginning of Line
    { key = "LeftArrow", mods = "CMD", action = act.SendString("\x1bOH") },
    -- Option-RightArrow: Forward Word
    { key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") },
    -- CMD-RightArrow: End of Line
    { key = "RightArrow", mods = "CMD", action = act.SendString("\x1bOF") },

    -- Leader Bindings. Leader is Ctrl-\
    { key = "k", mods = "LEADER", action = ActivateUpPane },
    { key = "j", mods = "LEADER", action = ActivateDownPane },
    { key = "h", mods = "LEADER", action = ActivateLeftPane },
    { key = "l", mods = "LEADER", action = ActivateRightPane },
    { key = "n", mods = "LEADER", action = NewHomeWindow },
    { key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

    -- key-tables

    -- leader launcher
    {
      key = "l",
      mods = "LEADER",
      action = act.ActivateKeyTable({
        name = "leader_launcher",
        one_shot = true,
        timeout_milliseconds = 500,
      }),
    },
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
    -- manage panes
    {
      key = "p",
      mods = "LEADER",
      action = act.ActivateKeyTable({
        name = "manage_panes",
        one_shot = false,
        timemout_miliseconds = 1000,
      }),
    },
  }

  config.key_tables = {
    leader_launcher = {
      { key = "Enter", action = act.ShowLauncher },
      { key = "t", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
      { key = "w", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
      { key = "Escape", action = act.PopKeyTable },
      { key = "q", action = act.PopKeyTable },
    },

    resize_font = {
      { key = "k", action = act.IncreaseFontSize },
      { key = "j", action = act.DecreaseFontSize },
      { key = "r", action = act.ResetFontSize },
      { key = "Escape", action = act.PopKeyTable },
      { key = "q", action = act.PopKeyTable },
    },

    manage_panes = {
      {
        key = "\\",
        action = act.Multiple({
          act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
          act.PopKeyTable,
        }),
      },
      {
        key = "|",
        action = act.Multiple({
          act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
          act.PopKeyTable,
        }),
      },
      {
        key = "-",
        action = act.Multiple({
          act.SplitVertical({ domain = "CurrentPaneDomain" }),
          act.PopKeyTable,
        }),
      },
      { key = "k", action = act.AdjustPaneSize({ "Up", 3 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 3 }) },
      { key = "h", action = act.AdjustPaneSize({ "Left", 3 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 3 }) },
      { key = "Escape", action = act.PopKeyTable },
      { key = "q", action = act.PopKeyTable },
    },

    copy_mode = {
      { key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
      { key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
      { key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
      {
        key = "Escape",
        mods = "NONE",
        action = act.Multiple({ act.ScrollToBottom, act.CopyMode("Close") }),
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
        action = act.Multiple({ act.ScrollToBottom, act.CopyMode("Close") }),
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
        action = act.Multiple({ act.ScrollToBottom, act.CopyMode("Close") }),
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
        action = act.Multiple({ act.ScrollToBottom, act.CopyMode("Close") }),
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
          act.CopyTo("ClipboardAndPrimarySelection"),
          act.ScrollToBottom,
          act.CopyMode("Close"),
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
          act.CopyTo("PrimarySelection"),
          act.CopyMode("Close"),
          act.PasteFrom("PrimarySelection"),
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
    -- Cmd-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CMD",
      action = act.OpenLinkAtMouseCursor,
    },
  }

  config.mouse_wheel_scrolls_tabs = false
end
