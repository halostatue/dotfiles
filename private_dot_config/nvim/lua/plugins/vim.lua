return {
  { -- https://github.com/nvim-lua/plenary.nvim
    'nvim-lua/plenary.nvim',
    lazy = false,
  },
  { -- https://github.com/junegunn/vader.vim
    'junegunn/vader.vim',
    cmd = { 'Vader' },
  },
  { -- https://github.com/tweekmonster/exception.vim
    'tweekmonster/exception.vim',
    cmd = { 'WTF' },
    config = function() vim.api.create_user_command('WTF', 'call exception#trace()') end,
  },
  { -- https://github.com/tweekmonster/helpful.vim
    'tweekmonster/helpful.vim',
    cmd = { 'HelpfulVersion' },
  },
  { -- https://github.com/skanehira/denops-docker.vim
    'skanehira/denops-docker.vim',
    cmd = {
      'Docker',
      'DockerImages',
      'DockerContainers',
      'DockerSearchImage',
      'DockerAttachContainer',
      'DockerExecContainer',
      'DockerShowContainerLog',
      'DockerEditFile',
    },
    dependencies = {
      { -- https://github.com/vim-denops/denops.vim
        'vim-denops/denops.vim',
        event = { 'VeryLazy' },
      },
    },
  },
  { -- https://github.com/dstein64/vim-startuptime
    'dstein64/vim-startuptime',
    cmd = { 'StartupTime' },
    config = function() vim.g.startuptime_tries = 10 end,
  },
  { -- https://github.com/folke/which-key.nvim
    'folke/which-key.nvim',
  },
  -- { -- https://github.com/AckslD/nvim-whichkey-setup.lua
  --   'AckslD/nvim-whichkey-setup.lua',
  --   dependencies = {
  --     {
  --       'liuchengxu/vim-which-key', -- https://github.com/liuchengxu/vim-which-key
  --       cmd = { 'WhichKey' },
  --       vim.api.nvim_create_autocmd('User', {
  --         group = vim.api.nvim_create_augroup('vim-which-key', {}),
  --         pattern = { ' vim-which-key' },
  --         callback = function()
  --           vim.call('which_key#register', '<Space>', 'g:which_key_map')
  --         end,
  --       }),
  --     },
  --   },
  --   config = true,
  -- },
  { -- https://github.com/dhruvasagar/vim-zoom
    'dhruvasagar/vim-zoom',
    keys = {
      { '<C-w>m', '<Plug>(zoom-toggle)', desc = 'Zoom / Unzoom windows' },
    },
  },
  { -- https://github.com/stevearc/dressing.nvim
    'stevearc/dressing.nvim',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/folke/noice.nvim
    'folke/noice.nvim',
    lazy = false,
    dependencies = {
      { -- https://github.com/MunifTanjim/nui.nvim
        'MunifTanjim/nui.nvim',
      },
      { -- https://github.com/rcarriga/nvim-notify
        'rcarriga/nvim-notify',
        config = function()
          require('notify').setup {
            background_colour = 'Normal',
            fps = 30,
            icons = {
              DEBUG = '🪳',
              ERROR = '⛔️',
              INFO = 'ℹ',
              TRACE = '📍',
              WARN = '⚠️ ',
            },
            level = 2,
            minimum_width = 50,
            render = 'default',
            stages = 'static',
            timeout = 5000,
            top_down = true,
          }
        end,
      },
    },
    config = function()
      require('noice').setup {
        cmdline = {
          view = 'cmdline_popup', -- `cmdline`
          format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = { pattern = '^:', icon = '＞', lang = 'vim' },
            search_down = {
              kind = 'search',
              pattern = '^/',
              icon = '🔎⬇️',
              lang = 'regex',
            },
            search_up = {
              kind = 'search',
              pattern = '^%?',
              icon = '🔎⬆️',
              lang = 'regex',
            },
            filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
            lua = { pattern = '^:%s*lua%s+', icon = '☾', lang = 'lua' },
            help = { pattern = '^:%s*he?l?p?%s+', icon = '⁇' },
            input = {}, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        popupmenu = {
          kind_icons = false,
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  { -- https://github.com/wsdjeg/vim-fetch
    'wsdjeg/vim-fetch',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/duggiefresh/vim-easydir
    'duggiefresh/vim-easydir',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/tpope/vim-haystack
    'tpope/vim-haystack',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/tpope/vim-repeat
    'tpope/vim-repeat',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/tpope/vim-rsi
    'tpope/vim-rsi',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/tpope/vim-speeddating
    'tpope/vim-speeddating',
    event = { 'VeryLazy' },
  },
  -- { -- https://github.com/monaqa/dial.nvim
  --   'monaqa/dial.nvim',
  --   keys = { '<C-a>', { '<C-x>', mode = 'n' } },
  -- },
  { -- https://github.com/tpope/vim-surround
    'tpope/vim-surround',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/tpope/vim-unimpaired
    'tpope/vim-unimpaired',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/alexghergh/securemodelines
    'alexghergh/securemodelines',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/tversteeg/registers.nvim
    'tversteeg/registers.nvim',
    -- replaces https://github.com/junegunn/vim-peekaboo
    event = { 'VeryLazy' },
    config = true,
  },
  { -- https://github.com/skywind3000/vim-quickui
    'skywind3000/vim-quickui',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/DanilaMihailov/beacon.nvim
    'DanilaMihailov/beacon.nvim',
    event = { 'VeryLazy' },
    config = function()
      vim.g.beacon_size = 15
      vim.g.beacon_ignore_filetypes = { 'fzf', 'fern' }
    end,
  },
}
