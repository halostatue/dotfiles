local wezterm = require("wezterm")

local Cells = {}

function Cells:new()
  local object = setmetatable({}, self)
  self.__index = self
  object._entries = {}

  return object
end

function Cells:clear()
  self._entries = {}
end

function Cells:entries()
  return self._entries
end

function Cells:push(values)
  for _, v in ipairs(values) do
    table.insert(self._entries, { Foreground = { Color = v.fg } })
    table.insert(self._entries, { Background = { Color = v.bg } })

    if v.bold ~= false then
      table.insert(self._entries, { Attribute = { Intensity = "Bold" } })
    end

    local text = v.icon and v.icon .. " " .. v[1] .. " " or v[1]

    table.insert(self._entries, { Text = text })

    if v.separator then
      table.insert(self._entries, { Foreground = { Color = v.separator.fg } })
      table.insert(self._entries, { Background = { Color = v.separator.bg } })
      table.insert(self._entries, { Text = v.separator.char })
    end
  end

  return self
end

return Cells
