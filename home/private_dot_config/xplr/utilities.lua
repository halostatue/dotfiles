-------- Function equivalent to basename in POSIX systems
xplr.fn.custom.basename = function(path)
  return string.gsub(path, "(.*/)(.*)", "%2")
end

-------- Function equivalent to dirname in POSIX systems
xplr.fn.custom.dirname = function(path)
  if str:match(".-/.-") then
    local name = string.gsub(path, "(.*/)(.*)", "%1")
    return name
  else
    return ""
  end
end

-------- Shell escape. See https://github.com/ncopa/lua-shell
xplr.fn.custom.shell_escape = function(args)
  local ret = {}
  for _, a in pairs(args) do
    local s = tostring(a)
    if s:match("[^A-Za-z0-9_/:=-]") then
      s = "'" .. s:gsub("'", "'\\''") .. "'"
    end
    table.insert(ret, s)
  end
  return table.concat(ret, " ")
end

-------- Shell run. See https://github.com/ncopa/lua-shell
xplr.fn.custom.shell_run = function(args)
  local h = io.popen(xplr.fn.builtin.shell_escape(args))
  local outstr = h:read("*a")
  return h:close(), outstr
end

-------- Shell execute. See https://github.com/ncopa/lua-shell
xplr.fn.custom.shell_execute = function(args)
  return os.execute(xplr.fn.builtin.shell_escape(args))
end
