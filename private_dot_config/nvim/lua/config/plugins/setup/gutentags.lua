local g = vim.g
local xdg_base = vim.fn['hz#xdg_base']

-- Share tags cache between vim and gvim
g.gutentags_cache_dir = xdg_base('cache', 'tags')
