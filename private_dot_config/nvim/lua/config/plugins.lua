require('config.plugins.bootstrap')

vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

return require('packer').startup({function()
  -- https://github.com/wbthomason/packer.nvim
  use 'wbthomason/packer.nvim'

  -- neovim Helpers
  -- https://github.com/tjdevries/astronauta.nvim
  -- https://github.com/nvim-lua/popup.nvim
  -- https://github.com/nvim-lua/plenary.nvim
  use {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'tjdevries/astronauta.nvim',
  }

  -- Search
  --
  -- https://github.com/haya14busa/is.vim
  -- https://github.com/haya14busa/vim-asterisk
  -- https://github.com/osyo-manga/vim-anzu
  use { 'haya14busa/is.vim',
    event = 'VimEnter', setup = [[require('config.plugins.setup.is')]],
    requires = { 'haya14busa/vim-asterisk', 'osyo-manga/vim-anzu' },
    config = [[require('config.plugins.is')]],
  }

  -- https://github.com/RRethy/vim-illuminate
  use 'RRethy/vim-illuminate'

  -- https://github.com/dyng/ctrlsf.vim
  use { 'dyng/ctrlsf.vim', config = [[require('config.plugins.ctrlsf')]] }

  -- https://github.com/mhinz/vim-grepper
  use { 'mhinz/vim-grepper', config = [[require('config.plugins.grepper')]] }

  -- https://github.com/romainl/vim-cool
  use 'romainl/vim-cool'

  -- Utils
  -- https://github.com/chrisbra/unicode.vim
  use { 'chrisbra/unicode.vim', config = [[require('config.plugins.unicode')]] }

  use 'wsdjeg/vim-fetch' -- https://github.com/wsdjeg/vim-fetch
  use 'duggiefresh/vim-easydir' -- https://github.com/duggiefresh/vim-easydir
  use 'prabirshrestha/async.vim' -- https://github.com/prabirshrestha/async.vim

  -- https://github.com/andymass/vim-matchup
  use { 'andymass/vim-matchup',
    -- event = 'User ActuallyEditing',
    event = 'VimEnter',
    setup = [[require('config.plugins.setup.matchup')]]
  }

  -- https://github.com/direnv/direnv.vim
  use { 'direnv/direnv.vim',
    config = function() vim.g.direnv_silent_load = 1 end,
  }

  use 'hauleth/vim-backscratch' -- https://github.com/hauleth/vim-backscratch
  use 'https://gitlab.com/hauleth/qfx.vim.git' -- https://gitlab.com/hauleth/qfx.vim.git

  -- https://github.com/editorconfig/editorconfig-vim
  use { 'editorconfig/editorconfig-vim', config = [[require('config.plugins.editorconfig')]] }

  -- https://github.com/simnalamburt/vim-mundo
  use { 'simnalamburt/vim-mundo', config = [[require('config.plugins.mundo')]] }

  -- https://github.com/tpope/vim-dadbod
  -- https://github.com/kristijanhusak/vim-dadbod-completion
  -- https://github.com/kristijanhusak/vim-dadbod-ui
  use {
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-completion',
    'kristijanhusak/vim-dadbod-ui',
  }

  -- https://github.com/tpope/vim-abolish
  -- https://github.com/tpope/vim-capslock
  -- https://github.com/tpope/vim-haystack
  -- https://github.com/tpope/vim-repeat
  -- https://github.com/tpope/vim-rsi
  -- https://github.com/tpope/vim-speeddating
  -- https://github.com/tpope/vim-surround
  -- https://github.com/tpope/vim-unimpaired
  use {
    'tpope/vim-abolish',
    'tpope/vim-capslock',
    'tpope/vim-haystack',
    'tpope/vim-repeat',
    'tpope/vim-rsi',
    'tpope/vim-speeddating',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
  }

  use 'tversteeg/registers.nvim' -- https://github.com/tversteeg/registers.nvim
  -- replaces https://github.com/junegunn/vim-peekaboo

  use 'alexghergh/securemodelines' -- https://github.com/alexghergh/securemodelines

  -- https://github.com/tyru/open-browser.vim
  use { 'tyru/open-browser.vim', config = [[require('config.plugins.openbrowser')]] }

  use 'christoomey/vim-sort-motion' -- https://github.com/christoomey/vim-sort-motion

  -- https://github.com/airblade/vim-rooter
  use { 'airblade/vim-rooter', config = [[require('config.plugins.rooter')]] }

  use 'AndrewRadev/bufferize.vim' -- https://github.com/AndrewRadev/bufferize.vim
  use 'AndrewRadev/quickpeek.vim' -- https://github.com/AndrewRadev/quickpeek.vim
  use 'chrisbra/Recover.vim' -- https://github.com/chrisbra/Recover.vim
  use 'junegunn/vim-emoji' -- https://github.com/junegunn/vim-emoji

  -- Project navigation / session
  -- https://github.com/tpope/vim-projectionist
  use { 'tpope/vim-projectionist', config = [[require('config.plugins.projectionist')]] }
  use 'tpope/vim-eunuch' -- https://github.com/tpope/vim-eunuch

  -- https://github.com/dhruvasagar/vim-prosession
  -- https://github.com/tpope/vim-obsession
  use { 'dhruvasagar/vim-prosession',
    after = 'vim-obsession',
    requires = { { 'tpope/vim-obsession', cmd = 'Prosession' } },
    config = [[require('config.plugins.prosession')]],
  }

  -- Fern: NERDtree Replacement
  -- https://github.com/lambdalisue/fern.vim
  -- https://github.com/antoinemadec/FixCursorHold.nvim
  -- https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim
  -- https://github.com/lambdalisue/fern-bookmark.vim
  -- https://github.com/lambdalisue/fern-git-status.vim
  -- https://github.com/lambdalisue/fern-hijack.vim
  -- https://github.com/lambdalisue/fern-mapping-git.vim
  -- https://github.com/lambdalisue/fern-mapping-mark-children.vim
  -- https://github.com/lambdalisue/fern-mapping-project-top.vim
  -- https://github.com/lambdalisue/fern-mapping-quickfix.vim
  -- https://github.com/yuki-yano/fern-preview.vim
  use {
    'lambdalisue/fern.vim',
    'antoinemadec/FixCursorHold.nvim',
    'hrsh7th/fern-mapping-collapse-or-leave.vim',
    'lambdalisue/fern-bookmark.vim',
    'lambdalisue/fern-git-status.vim',
    'lambdalisue/fern-hijack.vim',
    'lambdalisue/fern-mapping-git.vim',
    'lambdalisue/fern-mapping-mark-children.vim',
    'lambdalisue/fern-mapping-project-top.vim',
    'lambdalisue/fern-mapping-quickfix.vim',
    'yuki-yano/fern-preview.vim',
  }

  -- File Picker: CtrlP, CommandT, what?
  -- https://github.com/nvim-telescope/telescope.nvim
  -- replaces https://github.com/srstevenson/vim-picker
  use { 'nvim-telescope/telescope.nvim',
    setup = [[require('config.plugins.setup.telescope')]],
    config = [[require('config.plugins.telescope')]],
    cmd = 'Telescope',
    module = 'telescope',
  }

  use { 'nvim-telescope/telescope-frecency.nvim', requires = { 'tami5/sqlite.lua' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Git
  -- https://github.com/tpope/vim-fugitive
  use { 'tpope/vim-fugitive', cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'} }
  use 'tpope/vim-rhubarb' -- https://github.com/tpope/vim-rhubarb
  use 'junegunn/gv.vim' -- https://github.com/junegunn/gv.vim
  use 'mhinz/vim-signify' -- https://github.com/mhinz/vim-signify
  use 'rhysd/git-messenger.vim' -- https://github.com/rhysd/git-messenger.vim
  use 'jreybert/vimagit' -- https://github.com/jreybert/vimagit
  -- https://github.com/TimUntersberger/neogit
  use { 'TimUntersberger/neogit',
    cmd = 'Neogit', config = [[require('config.plugins.neogit')]],
  }

  -- Launch screen
  -- https://github.com/mhinz/vim-startify
  use { 'mhinz/vim-startify',
    config = [[require('config.plugins.setup.startify')]],
  }

  -- Languages
  --
  -- Polyglot provides syntax and indentation for the following syntaxes I
  -- care about: ansible, applescript, C/C++, Crystal, CSV, Cucumber/Gherkin,
  -- Dart, D, Dockerfile / Docker-Compose, Elixir, Elm, Erlang, Fish, Git,
  -- Gleam, GraphQL, HTML, JavaScript, jq, JSON, Julia, Kotlin, Lua, Markdown,
  -- Nim, Objective-C, Perl, PLpgSQL, PlantUML, Pony, Python, Raku, RAML,
  -- Reason, Ruby, Rust, SCSS, Shell, Svelte, SVG, Swift, Terraform, TOML,
  -- Vue, XML, and Zig.
  --
  -- https://github.com/sheerun/vim-polyglot
  use { 'sheerun/vim-polyglot',
    event = 'VimEnter', setup = [[require('config.plugins.setup.polyglot')]],
  }

  -- The following languages are either not supported by polyglot or are
  -- missing key components because of the packaging polyglot performs.
  --
  -- https://github.com/amadeus/vim-mjml
  -- https://github.com/dmix/elvish.vim
  -- https://github.com/fatih/vim-go
  -- https://github.com/luizribeiro/vim-cooklang
  -- https://github.com/browserslist/vim-browserslist
  -- https://github.com/janet-lang/janet.vim
  -- https://github.com/clavery/vim-dwre
  use {
    'amadeus/vim-mjml',
    'dmix/elvish.vim',
    { 'fatih/vim-go', ft = 'go', run = ':GoInstallBinaries' },
    'luizribeiro/vim-cooklang',
    'browserslist/vim-browserslist',
    'janet-lang/janet.vim',
    'clavery/vim-dwre',
  }

  -- Treesitter and adjacent libraries
  --
  -- https://github.com/nvim-treesitter/nvim-treesitter
  -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
  -- -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- https://github.com/romgrk/nvim-treesitter-context
  -- https://github.com/folke/twilight.nvim
  -- https://github.com/windwp/nvim-ts-autotag
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  -- https://github.com/SmiteshP/nvim-gps
  -- https://github.com/IndianBoy42/tree-sitter-just
  use {
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-refactor',
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
    'romgrk/nvim-treesitter-context',
    'folke/twilight.nvim',
    'windwp/nvim-ts-autotag',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'SmiteshP/nvim-gps',
    'IndianBoy42/tree-sitter-just',
  }

  -- TODO
  -- use 'mfussenegger/nvim-lint' -- https://github.com/mfussenegger/nvim-lint

  -- https://github.com/norcalli/nvim-colorizer.lua
  -- replaces https://github.com/gko/vim-coloresque
  use { 'norcalli/nvim-colorizer.lua', config = [[require('colorizer').setup()]] }

  -- Language Utilities
  -- https://github.com/sbdchd/neoformat
  use { 'sbdchd/neoformat', config = [[require('config.plugins.neoformat')]] }
  -- use 'mhartington/formatter.nvim' -- https://github.com/mhartington/formatter.nvim
  use 'tpope/vim-apathy' -- https://github.com/tpope/vim-apathy
  use 'lambdalisue/vim-backslash' -- https://github.com/lambdalisue/vim-backslash

  -- Colorscheme
  use 'KeitaNakamura/neodark.vim' -- https://github.com/KeitaNakamura/neodark.vim
  use 'tyrannicaltoucan/vim-deep-space' -- https://github.com/tyrannicaltoucan/vim-deep-space
  use 'sjl/badwolf' -- https://github.com/sjl/badwolf
  use 'morhetz/gruvbox' -- https://github.com/morhetz/gruvbox
  use 'cocopon/iceberg.vim' -- https://github.com/cocopon/iceberg.vim
  use 'savq/melange' -- https://github.com/savq/melange
  use 'novasenco/nokto' -- https://github.com/novasenco/nokto
  use 'fenetikm/falcon' -- https://github.com/fenetikm/falcon
  use 'yggdroot/duoduo' -- https://github.com/yggdroot/duoduo
  use 'preservim/vim-colors-pencil' -- https://github.com/preservim/vim-colors-pencil
  use 'hardselius/warlock' -- https://github.com/hardselius/warlock
  use 'ishan9299/modus-theme-vim' -- https://github.com/ishan9299/modus-theme-vim
  use 'marko-cerovac/material.nvim' -- https://github.com/marko-cerovac/material.nvim
  use 'Yagua/nebulous.nvim' -- https://github.com/Yagua/nebulous.nvim

  -- Completion Support
  use 'Shougo/echodoc.vim' -- https://github.com/Shougo/echodoc.vim

  -- LSP
  use 'neovim/nvim-lspconfig' -- https://github.com/neovim/nvim-lspconfig
  use {
    -- https://github.com/nvim-lua/lsp-status.nvim
    { 'nvim-lua/lsp-status.nvim' },
    -- https://github.com/williamboman/nvim-lsp-installer
    { 'williamboman/nvim-lsp-installer', config = [[require('config.plugins.lspinstall')]] },
    -- https://github.com/simrat39/rust-tools.nvim
    { 'simrat39/rust-tools.nvim',
      opt = true, ft = 'rust', config = [[require('rust-tools').setup{}]],
    },
    -- https://github.com/folke/lsp-colors.nvim
    { 'folke/lsp-colors.nvim' },
    -- https://github.com/ray-x/lsp_signature.nvim
    { 'ray-x/lsp_signature.nvim',
      config = function()
        require('lsp_signature').setup {
          bind = true,
          handler_opts = { border = 'single' }
        }
      end
    },
    -- https://github.com/kosayoda/nvim-lightbulb
    { 'kosayoda/nvim-lightbulb',
      config = function()
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      end
    },
    -- https://github.com/stevearc/aerial.nvim
    { 'stevearc/aerial.nvim' },
    -- https://github.com/stevearc/stickybuf.nvim
    { 'stevearc/stickybuf.nvim', config = [[require('stickybuf').setup()]] }
  }

  -- https://github.com/folke/trouble.nvim
  use { 'folke/trouble.nvim', config = [[require('config.plugins.trouble')]] }

  -- use 'prabirshrestha/asyncomplete-lsp.vim' -- https://github.com/prabirshrestha/asyncomplete-lsp.vim
  -- use 'prabirshrestha/asyncomplete.vim' -- https://github.com/prabirshrestha/asyncomplete.vim

  -- https://github.com/nvim-lua/completion-nvim
  -- https://github.com/hrsh7th/vim-vsnip
  -- https://github.com/hrsh7th/vim-vsnip-integ
  use { 'nvim-lua/completion-nvim',
    requires = {
      'steelsojka/completion-buffers',
      'nvim-treesitter/completion-treesitter',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'rafamadriz/friendly-snippets',
    }
  }

  -- use { 'hrsh7th/nvim-cmp',
  --    requires = { 'L3MON4D3/LuaSnip',
  -- --     { 'hrsh7th/cmp-buffer' },
  -- --     'hrsh7th/cmp-nvim-lsp',
  -- --     { 'hrsh7th/cmp-path' },
  -- --     { 'hrsh7th/cmp-nvim-lua' },
  -- --     { 'saadparwaiz1/cmp_luasnip' },
  --    },
  --    config = [[require('config.plugins.cmp')]],
  --    event = 'InsertEnter *',
  --  }

  use 'mattn/vim-lexiv' -- https://github.com/mattn/vim-lexiv

  -- Code manipulation
  use 'preservim/tagbar' -- https://github.com/preservim/tagbar
  -- https://github.com/ludovicchabant/vim-gutentags
  use { 'ludovicchabant/vim-gutentags',
    event = 'VimEnter', setup = [[require('config.plugins.setup.gutentags')]],
  }

  use 'tommcdo/vim-exchange' -- https://github.com/tommcdo/vim-exchange
  use 'tpope/vim-commentary' -- https://github.com/tpope/vim-commentary

  -- https://github.com/tpope/vim-endwise
  use { 'tpope/vim-endwise', config = function() vim.g.endwise_abbreviations = 1 end }

  use 'tpope/vim-ragtag' -- https://github.com/tpope/vim-ragtag
  use 'alvan/vim-closetag' -- https://github.com/alvan/vim-closetag
  -- use 'AndrewRadev/tagalong.vim' -- https://github.com/AndrewRadev/tagalong.vim

  use 'pechorin/any-jump.vim' -- https://github.com/pechorin/any-jump.vim

  -- https://github.com/AndrewRadev/multichange.vim
  use { 'AndrewRadev/multichange.vim',
    config = function()
      vim.g.multichange_mapping = 'sm'
      vim.g.multichange_motion_mapping = 'm'
    end,
  }

  -- https://github.com/machakann/vim-swap
  use { 'machakann/vim-swap',
    event = 'VimEnter', setup = function() vim.g.swap_no_default_key_mappings = 1 end,
    config = [[require('config.plugins.vimswap')]]
  }

  -- Text Editing
  -- https://github.com/folke/zen-mode.nvim
  use { 'folke/zen-mode.nvim',
    opt = true, cmd = [[ZenMode]], config = [[require('config.plugins.zenmode')]],
  }

  -- https://github.com/mzlogin/vim-markdown-toc
  use {
    'mzlogin/vim-markdown-toc'
  }

  -- https://github.com/junegunn/goyo.vim
  use { 'junegunn/goyo.vim',
    opt = true, cmd = [[Goyo]], config = [[require('config.plugins.goyo')]],
    requires = { { 'junegunn/limelight.vim', opt = true } },
  }

  -- TODO: CONTINUE
  -- Movements
  use 'chaoren/vim-wordmotion' -- https://github.com/chaoren/vim-wordmotion
  use { 'wellle/targets.vim', opt = true } -- https://github.com/wellle/targets.vim
  use 'rhysd/clever-f.vim' -- https://github.com/rhysd/clever-f.vim

  -- Task running & quickfix
  -- https://github.com/tpope/vim-dispatch
  use { 'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
    requires = {
      -- This is only required until vim-dispatch v 1.3 or later. See https://github.com/tpope/vim-dadbod/pull/64
      -- https://github.com/radenling/vim-dispatch-neovim
      'radenling/vim-dispatch-neovim'
    }
  }

  use 'hauleth/asyncdo.vim' -- https://github.com/hauleth/asyncdo.vim
  use 'romainl/vim-qf' -- https://github.com/romainl/vim-qf
  use 'romainl/vim-qlist' -- https://github.com/romainl/vim-qlist
  use 'Olical/vim-enmasse' -- https://github.com/Olical/vim-enmasse
  use 'igemnace/vim-makery' -- https://github.com/igemnace/vim-makery
  use 'kevinhwang91/nvim-bqf' -- https://github.com/kevinhwang91/nvim-bqf

  -- Splits management
  use 'dhruvasagar/vim-zoom' -- https://github.com/dhruvasagar/vim-zoom

  -- Optional debug / test stuff
  -- -- https://github.com/puremourning/vimspector
  -- -- Note: not fully compatibel with neovim
  -- use { 'puremourning/vimspector',
  --   setup = function() vim.g.vimspector_enable_mappings = 'HUMAN' end,
  --   event = 'VimEnter',
  -- }

  -- use { 'mfussenegger/nvim-dap',
  --   setup = [[require('config.plugins.setup.dap')]],
  --   config = [[require('config.plugins.dap')]],
  --   requires = 'jbyuki/one-small-step-for-vimkind',
  --   wants = 'one-small-step-for-vimkind',
  --   module = 'dap',
  -- }
  -- use { 'rcarriga/nvim-dap-ui',
  --   requires = 'nvim-dap',
  --   config = function()require('dapui').setup()end,
  -- }
  -- use { 'theHamsta/nvim-dap-virtual-text' }

  use 'vim-test/vim-test' -- https://github.com/vim-test/vim-test
  use { 'junegunn/vader.vim', cmd = { 'Vaer' } } -- https://github.com/junegunn/vader.vim
  use { 'vim-jp/vital.vim', cmd = { 'Vitalize' } } -- https://github.com/vim-jp/vital.vim

  -- https://github.com/tpope/vim-scriptease
  use { 'tpope/vim-scriptease',
    cmd = {
      'Breakdd', 'Breakdel', 'Disarm', 'K', 'Messages', 'PP', 'PPmsg', 'Runtime', 'Scriptnames', 'Time', 'Vedit',
      'Verbose', 'Vsplit', 'Vtabedit'
    }
  }

  -- https://github.com/tweekmonster/exception.vim
  use { 'tweekmonster/exception.vim',
    config = function()
      vim.cmd [[command! WTF call exception#trace()]]
    end
  }

  use { 'tweekmonster/helpful.vim', cmd = { 'HelpfulVersion' } } -- https://github.com/tweekmonster/helpful.vim

  use { 'mattn/gist-vim', cmd = { 'Gist' } } -- https://github.com/mattn/gist-vim

  -- https://github.com/mbbill/undotree
  use { 'mbbill/undotree',
    cmd = { 'UndotreeToggle' }, config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
  }

  -- Loaded only for specific filetypes on demand. Requires autocommands below.
  -- https://github.com/kristijanhusak/vim-js-file-import
  use { 'kristijanhusak/vim-js-file-import',
    ft = 'javascript', run = 'npm install'
  }

  -- https://github.com/hkupty/iron.nvim
  use { 'hkupty/iron.nvim',
    setup = [[vim.g.iron_map_defaults = 0]],
    config = [[require('config.plugins.iron')]],
    cmd = { 'IronRepl', 'IronSend', 'IronReplHere' },
  }

  -- https://github.com/voldikss/vim-floaterm
  use { 'voldikss/vim-floaterm',
    cmd = { 'FloatermNew' }
  }

  use 'skywind3000/vim-quickui' -- https://github.com/skywind3000/vim-quickui

  -- https://github.com/vim-denops/denops.vim
  -- https://github.com/skanehira/denops-docker.vim
  use { 'vim-denops/denops.vim', 'skanehira/denops-docker.vim' }

  -- Considerations:
  -- use_rocks 'penlight'
  -- use_rocks {'lua-resty-http', 'lpeg'}
  --
  -- use { 'glepnir/galaxyline.nvim',
  --   branch = 'main', config = function() require'statusline' end,
  --   requires = {'kyazdani42/nvim-web-devicons'}
  -- } -- https://github.com/glepnir/galaxyline.nvim
  -- use { 'lewis6991/gitsigns.nvim',
  --   config = function() require('gitsigns').setup() end
  -- } -- https://github.com/lewis6991/gitsigns.nvim
  -- use { 'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]] }
  -- https://github.com/ThePrimeagen/refactoring.nvim
  -- use { 'ThePrimeagen/refactoring.nvim', opt = true }
  -- use { 'akinsho/nvim-bufferline.lua',
  --   requires = 'kyazdani42/nvim-web-devicons',
  --   config = [[require('config.plugins.bufferline')]],
  --   event = 'User ActuallyEditing',
  -- }
end,
config = {
  -- log = { level = 'trace' }
  display = {
    open_fn = function () return require('packer.util').float({ border = 'single' }) end,
  }
}})
