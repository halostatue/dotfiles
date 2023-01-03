-- This is the 2023 verison of my neovim configuration, translating my current vim
-- configuration to lua.
--
if not vim.g.hz_nvim_config_version then
  vim.g.hz_nvim_config_version = '2023.0'
  vim.api.nvim_command([[lockvar g:hz_nvim_config_version]])
end

require('config.defaults')
require('config.lazy')
require('config.abbreviations')
require('config.commands')
require('config.keys')

-- colorscheme duoduo

vim.g.afterglow_blackout = 1
vim.g.afterglow_italic_comments = 1
vim.g.afterglow_inherit_background = 1

-- vim.cmd [[colorscheme afterglow]]
-- silent! colorscheme alduin

-- silent! colorscheme anderson
-- silent! colorscheme angr

vim.g.ayucolor = 'light'
vim.g.ayucolor = 'mirage'
vim.g.ayucolor = 'dark'

-- silent! colorscheme ayu

-- silent! colorscheme apprentice
-- silent! colorscheme deep-space
-- silent! colorscheme deus

-- vim.cmd [[colorscheme modus-vivendi]]
vim.cmd([[colorscheme tokyonight]])

-- set secure
vim.opt.secure = true
