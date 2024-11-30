local wezterm = require("wezterm")
local Persist = require("utils.persist")

local function default_schema_data()
  local schemes = {}

  for name, _ in pairs(wezterm.get_builtin_color_schemes()) do
    schemes[name] = { star = false }
  end

  return schemes
end

local Schemes = {}

function Schemes:new()
  local object = setmetatable({ persist = Persist:new("schemes") }, self)
  self.__index = self
  self.__pairs = function(t)
    return pairs(t.persist)
  end

  object:load()

  return object
end

function Schemes:load()
  return self.persist:read(default_schema_data)
end

function Schemes:save()
  return self.persist:write()
end

function Schemes:next()
  return self.persist:next()
end

function Schemes:delete(key)
  self.persist:set(key, nil)
end

function Schemes:isstarred(key)
  local value = self.persist:get(key)

  return value and value.star
end

function Schemes:togglestarred(key)
  local value = self.persist:get(key)

  if value then
    value.star = ~value.star
    self.persist:set(key, value)
  end
end

function Schemes:star(key)
  local value = self.persist:get(key)

  if value then
    value.star = true
    self.persist:set(key, value)
  end
end

function Schemes:unstar(key)
  local value = self.persist:get(key)

  if value then
    value.star = false
    self.persist:set(key, value)
  end
end

function Schemes:isempty()
  return self.persist:isempty()
end

return Schemes
