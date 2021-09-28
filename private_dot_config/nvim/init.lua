-- 2021 Version of my vim configuration, starting from scratch,
-- translated to lua for nvim

local g = vim.g
local nvim_command = vim.api.nvim_command

if not g.hz_nvim_config_version then
  g.hz_nvim_config_version = '2021.0'
  nvim_command [[lockvar g:hz_nvim_config_version]]
end

require('config.defaults')
require('config.plugins')
require('config.abbreviations')
require('config.commands')
require('config.keys')
require('config.plugins.config')

-- colorscheme duoduo

g.afterglow_blackout = 1
g.afterglow_italic_comments = 1
g.afterglow_inherit_background = 1

-- silent! colorscheme afterglow
-- silent! colorscheme alduin

-- silent! colorscheme anderson
-- silent! colorscheme angr

g.ayucolor = 'light'
g.ayucolor = 'mirage'
g.ayucolor = 'dark'

-- silent! colorscheme ayu

-- silent! colorscheme apprentice
-- silent! colorscheme deep-space
-- silent! colorscheme deus

vim.cmd [[colorscheme modus-vivendi]]

vim.opt.guifont = 'FiraCode-Retina:h10'

-- set secure
vim.opt.secure = true
