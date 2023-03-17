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

if vim.g.vscode then
  -- This block is running in VS Code. To tell VS Code to reload this file,
  -- reload VS Code with Cmd-r.
  --
  -- For tips on how to use it effectively, see the excellent extension
  -- documentation:
  -- https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim
  --
  -- To see what to call a given keybinding (e.g. `editor.action.rename`),
  -- see this page:
  -- https://vscode-docs.readthedocs.io/en/stable/customization/keybindings/

  vim.keymap.set(
    'n',
    'gr',
    function() vim.fn.VSCodeNotify('editor.action.referenceSearch.trigger') end,
    { remap = false }
  )

  vim.keymap.set(
    'n',
    'gR',
    function() vim.fn.VSCodeNotify('editor.action.rename') end,
    { remap = false }
  )

  -- Search for word under cursor
  vim.keymap.set(
    'n',
    'K',
    function()
      vim.fn.VSCodeNotify(
        'workbench.action.findInFiles',
        { query = vim.fn.expand('<cword>') }
      )
    end,
    { remap = false }
  )

  vim.keymap.set('x', 'gc', '<Plug>VSCodeCommentary', { remap = false })
  vim.keymap.set('n', 'gc', '<Plug>VSCodeCommentary', { remap = false })
  vim.keymap.set('o', 'gc', '<Plug>VSCodeCommentary', { remap = false })
  vim.keymap.set('n', 'gcc', '<Plug>VSCodeCommentaryLine', { remap = false })

  vim.keymap.set(
    'n',
    'S',
    function() vim.fn.VSCodeNotify('search.action.focusNextSearchResult') end,
    { remap = false }
  )

  vim.keymap.set(
    'n',
    '%',
    function() vim.fn.VSCodeNotify('editor.action.jumpToBracket') end,
    { remap = false }
  )
end

-- set secure
vim.opt.secure = true
