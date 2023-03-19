local undo_plugin = function(plugin)
  if plugin == 'mundo' then
    return { -- https://github.com/simnalamburt/vim-mundo
      'simnalamburt/vim-mundo',
      cmd = {
        'GundoHide',
        'GundoRenderGraph',
        'GundoShow',
        'GundoToggle',
        'MundoHide',
        'MundoShow',
        'MundoToggle',
      },
      keys = {
        { '<F5>', '<cmd>MundoToggle<CR>', desc = 'Toggle Undo Tree' },
      },
    }
  elseif plugin == 'undotree' then
    return { -- https://github.com/mbbill/undotree
      'mbbill/undotree',
      cmd = { 'UndotreeFocus', 'UndotreeHide', 'UndotreeShow', 'UndotreeToggle' },
      keys = {
        { '<F5>', '<cmd>UndotreeToggle<CR>', desc = 'Toggle Undo Tree' },
      },
      setup = function() vim.g.undotree_SetFocusWhenToggle = 1 end,
    }
  end
end

return {
  { -- https://github.com/chrisbra/unicode.vim
    'chrisbra/unicode.vim',
    cmd = {
      'Digraphs',
      'UnicodeSearch',
      'UnicodeName',
      'UnicodeTable',
      'DownloadUnicode',
      'UnicodeCache',
    },
    keys = {
      { 'ga', '<Plug>(UnicodeGA)', desc = 'Identity Unicode character name' },
      { '<C-x><C-g>', '<Plug>(DigraphComplete)', mode = 'i', desc = 'Complete Digraph' },
      { '<C-x><C-z>', '<Plug>(UnicodeComplete)', mode = 'i', desc = 'Complete Unicode' },
      {
        '<C-x><C-b>',
        '<Plug>(HTMLEntityComplete)',
        mode = 'i',
        desc = 'Complete HTML Entity',
      },
      { '<C-g><C-f>', '<Plug>(UnicodeFuzzy)', mode = 'i', desc = 'Fuzzy unicode search' },
      {
        '<leader>un',
        '<Plug>(UnicodeSwapCompleteName)',
        mode = 'n',
        desc = 'Swap complete name',
      },
    },
  },
  { -- https://github.com/direnv/direnv.vim
    'direnv/direnv.vim',
    event = { 'VeryLazy' },
    config = function() vim.g.direnv_silent_load = 1 end,
  },
  { -- https://github.com/editorconfig/editorconfig-vim
    'editorconfig/editorconfig-vim',
    event = { 'VeryLazy' },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('EditorConfig', {}),
        pattern = 'gitcommit',
        callback = function() vim.b.EditorConfig_disable = true end,
      })

      vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'fern://.*' }
    end,
  },
  undo_plugin('mundo'),
  { -- https://github.com/tyru/open-browser.vim
    'tyru/open-browser.vim',
    keys = {
      { 'gx', '<Plug>(openbrowser-smart-search)', mode = 'n', remap = true },
      { 'gx', '<Plug>(openbrowser-smart-search)', mode = 'v', remap = true },
    },
    config = function()
      vim.g.openbrowser_default_search = 'duckduckgo'
      vim.g.openbrowser_no_default_menus = true
      vim.g.openbrowser_message_verbosity = 1
    end,
  },
  { -- https://github.com/airblade/vim-rooter
    'airblade/vim-rooter',
    event = { 'VeryLazy' },
    config = function()
      vim.g.rooter_patterns = {
        '.git',
        '_darcs',
        '.hg',
        '.bzr',
        '.svn',
        'Makefile',
        'package.json',
        '!../Cargo.toml',
        '!../../Cargo.toml',
        'Cargo.toml',
        'init.lua',
        'init.vim',
        'vimrc',
      }

      vim.g.rooter_cd_cmd = 'lcd'
      vim.g.rooter_silent_chdir = true
    end,
  },
  { -- https://github.com/AndrewRadev/bufferize.vim
    'AndrewRadev/bufferize.vim',
    cmd = { 'Bufferize', 'BufferizeSystem', 'BufferizeTimer' },
  },
  { -- https://github.com/prabirshrestha/async.vim
    'prabirshrestha/async.vim',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/hauleth/vim-backscratch
    'hauleth/vim-backscratch',
    cmd = { 'Scratch', 'Scratchify' },
  },
  { -- https://github.com/kristijanhusak/vim-dadbod-ui
    'kristijanhusak/vim-dadbod-ui',
    cmd = { 'DBUI' },
    dependencies = {
      { -- https://github.com/tpope/vim-dadbod
        'tpope/vim-dadbod',
        cmd = { 'DB' },
      },
    },
  },
  { -- https://github.com/tpope/vim-abolish
    'tpope/vim-abolish',
    cmd = { 'Abolish', 'S', 'Subvert' },
    keys = { { 'cr', '<Plug>(abolish-coeerce-word)', desc = 'Coerce word shape' } },
  },
  { -- https://github.com/christoomey/vim-sort-motion
    'christoomey/vim-sort-motion',
    keys = {
      { 'gs', '<Plug>SortMotion' },
      { 'gs', '<Plug>SortMotionVisual', mode = 'x' },
      { 'gss', '<Plug>SortLines' },
    },
  },
  { -- https://github.com/mattn/gist-vim
    'mattn/gist-vim',
    cmd = { 'Gist' },
  },
  { -- https://github.com/hkupty/iron.nvim
    'hkupty/iron.nvim',
    version = '*',
    cmd = { 'IronRepl', 'IronSend', 'IronReplHere' },
    init = function() vim.g.iron_map_defaults = false end,
    config = function()
      local iron = require('iron')

      iron.core.add_repl_definitions {
        cpp = { cling = { command = { 'cling', '-std=c++17' } } },
        lua = { croissant = { command = { 'croissant' } } },
        fennel = { fennel = { command = { 'fennel' } } },
      }

      iron.core.set_config {
        preferred = {
          python = 'ptipython',
          haskell = 'intero',
          lisp = 'sbcl',
          ocaml = 'utop',
          scheme = 'csi',
          lua = 'croissant',
          -- ruby    = 'irb',
          -- elixir  = 'iex',
        },
      }
    end,
  },
  { -- https://github.com/voldikss/vim-floaterm
    'voldikss/vim-floaterm',
    cmd = {
      'FloatermNew',
      'FloatermUpdate',
      'FloatermShow',
      'FloatermHide',
      'FloatermKill',
      'FloatermToggle',
      'FloatermSend',
      'FloatermPrev',
      'FloatermNext',
      'FloatermFirst',
      'FloatermLast',
    },
    config = function()
      vim.g.floaterm_shell = 'fish'
      vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
    end,
  },
}

-- https://github.com/echasnovski/mini.nvim
-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/pechorin/u-keymapper.vim
-- https://github.com/shortcuts/neovim-plugin-boilerplate
-- https://github.com/Nexmean/caskey.nvim
-- https://github.com/shortcuts/no-neck-pain.nvim
