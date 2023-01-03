-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = { { import = 'plugins' } },
  -- spec = {{"folke/LazyVim", dev = true}, {import = "lazyvim.plugins"}, {import = "plugins"}},
  defaults = { lazy = true, version = nil },
  dev = { patterns = jit.os:find('Windows') and {} or {} },
  install = { colorscheme = { 'tokyonight', 'habamax' } },
  checker = { enabled = true, frequency = 3600 * 24 * 5 },
  diff = { cmd = 'terminal_git' }, -- git, diffview.nvim
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        '2html',
        'gzip',
        'man',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'nvim-treesitter-textobjects',
        'shada_plugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'tutor_mode_plugin',
        'zipPlugin',
      },
    },
  },
  ui = {
    custom_keys = {
      -- ["<localleader>d"] = function(plugin) dd(plugin) end
    },
    border = {
      { '╭', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '╮', 'FloatBorder' },
      { '│', 'FloatBorder' },
      { '╯', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '╰', 'FloatBorder' },
      { '│', 'FloatBorder' },
    },
    -- icons = {
    --   loaded = '●',
    --   not_loaded = '○',
    --   cmd = '➡ ',
    --   config = '⚙',
    --   event = { '⌁' },
    --   ft = '📄 ',
    --   init = '⚙ ',
    --   keys = '⌨ ',
    --   plugin = '📦 ',
    --   runtime = '🔢 ',
    --   source = 'ℹ ',
    --   start = '▶️ ',
    --   task = '✓ ',
    --   lazy = '💤 ',
    --   list = { '●', '➜', '★', '‒' },
    -- },
  },
  -- debug = true
}

vim.keymap.set('n', '<leader>l', '<cmd>:Lazy<cr>')
