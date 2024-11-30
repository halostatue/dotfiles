local wezterm = require("wezterm")

local Persist = {}

local function isempty(tbl)
  return rawequal(next(tbl), nil)
end

local function load(dst, src)
  for k, v in pairs(src) do
    dst[k] = v
  end
end

function Persist:new(name)
  local filename = wezterm.config_dir .. "/" .. name .. ".json"

  local object = setmetatable({ filename = filename, data = {} }, self)
  self.__index = self
  self.__pairs = function(t)
    return pairs(t.data)
  end

  return object
end

function Persist:read(default)
  local file = io.open(self.filename, "r")

  if file then
    local json = file:read("a")
    file:close()
    self.data = wezterm.json_parse(json)
    -- self.data = wezterm.serde.json_decode(json)
  end

  if isempty(self.data) and default then
    self:load(default)
  end

  return self.data
end

function Persist:write()
  local json = wezterm.json_encode(self.data)
  -- local json = wezterm.serde.json_encode(self.data)
  local file = assert(io.open(self.filename, "w"))

  file:write(json)
  file:close()

  return self.data
end

function Persist:next()
  return next(self.data)
end

function Persist:get(key)
  return self.data[key]
end

function Persist:set(key, value)
  self.data[key] = value
end

function Persist:isempty()
  return isempty(self.data)
end

function Persist:load(data)
  data = type(data) == "function" and data() or data

  if data and not isempty(data) then
    load(self.data, data)
  end

  return self.data
end

return Persist
