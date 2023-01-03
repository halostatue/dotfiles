local map_key = vim.api.nvim_set_keymap

local function termcode(code)
  return vim.api.nvim_replace_termcodes(code, true, true, true)
end

local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = { modes } end
  for _, mode in ipairs(modes) do
    map_key(mode, lhs, rhs, opts)
  end
end

local function dup_table(source)
  local dup = {}

  for k, v in pairs(source) do
    if type(v) == 'table' then
      dup[k] = dup_table(source[k])
    else
      dup[k] = v
    end
  end

  return dup
end

local function merge_table(t1, t2)
  t3 = dup_table(t1)

  for k, v in pairs(t2) do
    if type(v) == 'table' then
      t3[k] = merge_table(t3[k], t2[k])
    else
      t3[k] = v
    end
  end

  return t3
end

return { map = map, termcode = termcode, merge_table = merge_table }
