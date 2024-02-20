local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
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
  spec = {
    -- -- add LazyVim and import its plugins
    -- { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
    -- { import = 'lazyvim.plugins.extras.ui.mini-animate' },
    -- import/override with your plugins
    { import = 'plugins' },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom
    -- plugins will load during startup. If you know what you're doing, you can
    -- set this to `true` to have all your custom plugins lazy-loaded by
    -- default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin
    -- that support versioning, have outdated releases, which may break your
    -- Neovim install.
    version = false, -- always use the latest git commit
    -- version = '*', -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { 'tokyonight', 'habamax', 'cattpucin' } },
  checker = { enabled = true }, -- automatically check for plugin updates
  dev = {
    patterns = jit.os:find('Windows') and {} or {},
  },
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
