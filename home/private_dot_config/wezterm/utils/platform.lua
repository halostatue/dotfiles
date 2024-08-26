local wezterm = require("wezterm")

local is_win = wezterm.target_triple:find("windows") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local is_mac = wezterm.target_triple:find("apple") ~= nil
local os_name = is_win and "windows"
  or is_linux and "linux"
  or is_mac and "macos"
  or "unknown"

local M = {
  os = os_name,
  is_win = is_win,
  is_linux = is_linux,
  is_mac = is_mac,
}

-- Return true if the GUI is in dark mode, or if it cannot be determined.
function M.is_dark()
  if wezterm.gui then
    return wezterm.gui.get_appearance():find("Dark")
  end

  return true
end

function M.add_path(value, items)
  items = type(items) == "table" and items or { items }

  for i = #items, 1, -1 do
    if string.find(value, items[i], 1, true) == nil then
      value = items[i] .. ":" .. value
    end
  end

  return value
end

return M
