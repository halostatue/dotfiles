require('config.plugins.bootstrap')

vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

return require('packer').startup({function()
  use 'wbthomason/packer.nvim' -- https://github.com/wbthomason/packer.nvim

  -- Search
  -- use 'haya14busa/vim-asterisk' -- https://github.com/haya14busa/vim-asterisk
  -- use 'osyo-manga/vim-anzu' -- https://github.com/osyo-manga/vim-anzu
  use { 'haya14busa/is.vim',
    event = 'VimEnter', setup = [[require('config.plugins.setup.is')]],
    requires = {
      'haya14busa/vim-asterisk', -- https://github.com/haya14busa/vim-asterisk
      'osyo-manga/vim-anzu', -- https://github.com/osyo-manga/vim-anzu
    },
    after = { 'vim-asterisk', 'vim-anzu', 'astronauta.nvim' },
    config = [[require('config.plugins.is')]],
  } -- https://github.com/haya14busa/is.vim
  use 'RRethy/vim-illuminate' -- https://github.com/RRethy/vim-illuminate
  use { 'dyng/ctrlsf.vim',
    config = [[require('config.plugins.ctrlsf')]],
    after = 'astronauta.nvim',
  } -- https://github.com/dyng/ctrlsf.vim
  use { 'mhinz/vim-grepper',
    config = [[require('config.plugins.grepper')]],
    after = 'astronauta.nvim',
  } -- https://github.com/mhinz/vim-grepper
  use 'romainl/vim-cool' -- https://github.com/romainl/vim-cool

  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      -- 'telescope-frecency.nvim',
      -- 'telescope-fzf-native.nvim',
    },
    after = {
      'popup.nvim',
      'plenary.nvim',
      -- 'telescope-frecency.nvim',
      -- 'telescope-fzf-native.nvim',
    },
    setup = [[require('config.plugins.setup.telescope')]],
    config = [[require('config.plugins.telescope')]],
    cmd = 'Telescope',
    module = 'telescope',
  }
  -- use {
  --   ,
  --   { 'nvim-telescope/telescope-frecency.nvim',
  --     after = 'telescope.nvim',
  --     requires = 'tami5/sql.nvim',
  --   },
  --   { 'nvim-telescope/telescope-fzf-native.nvim',
  --     run = 'make',
  --   },
  -- }

  -- Utils
  use { 'chrisbra/unicode.vim',
    config = [[require('config.plugins.unicode')]],
    after = 'astronauta.nvim',
  } -- https://github.com/chrisbra/unicode.vim
  use 'wsdjeg/vim-fetch' -- https://github.com/wsdjeg/vim-fetch
  use 'duggiefresh/vim-easydir' -- https://github.com/duggiefresh/vim-easydir
  use 'prabirshrestha/async.vim' -- https://github.com/prabirshrestha/async.vim
  use { 'andymass/vim-matchup',
    event = 'User ActuallyEditing', setup = [[require('config.plugins.setup.matchup')]]
  } -- https://github.com/andymass/vim-matchup
  use 'direnv/direnv.vim' -- https://github.com/direnv/direnv.vim
  use 'hauleth/vim-backscratch' -- https://github.com/hauleth/vim-backscratch
  use 'https://gitlab.com/hauleth/qfx.vim.git' -- https://gitlab.com/hauleth/qfx.vim.git
  use 'editorconfig/editorconfig-vim' -- https://github.com/editorconfig/vim-editorconfig
  use { 'simnalamburt/vim-mundo',
    config = [[require('config.plugins.mundo')]],
    after = 'astronauta.nvim',
  } -- https://github.com/simnalamburt/vim-mundo
  use 'tpope/vim-dadbod' -- https://github.com/tpope/vim-dadbod
  use 'kristijanhusak/vim-dadbod-completion' -- https://github.com/kristijanhusak/vim-dadbod-completion
  use 'kristijanhusak/vim-dadbod-ui' -- https://github.com/kristijanhusak/vim-dadbod-ui
  use 'tpope/vim-repeat' -- https://github.com/tpope/vim-repeat
  use 'tpope/vim-rsi' -- https://github.com/tpope/vim-rsi
  use 'tpope/vim-surround' -- https://github.com/tpope/vim-surround
  use 'tpope/vim-unimpaired' -- https://github.com/tpope/vim-unimpaired
  use 'tpope/vim-haystack' -- https://github.com/tpope/vim-haystack
  use 'tpope/vim-abolish' -- https://github.com/tpope/vim-abolish
  use 'tpope/vim-capslock' -- https://github.com/tpope/vim-capslock
  use 'tpope/vim-speeddating' -- https://github.com/tpope/vim-speeddating
  use { 'junegunn/vim-peekaboo', disable = true } -- https://github.com/junegunn/vim-peekaboo
  use 'tversteeg/registers.nvim' -- https://github.com/tversteeg/registers.nvim
  use 'alexghergh/securemodelines' -- https://github.com/alexghergh/securemodelines
  use { 'tyru/open-browser.vim',
    config = [[require('config.plugins.openbrowser')]],
    after = 'astronauta.nvim',
  } -- https://github.com/tyru/open-browser.vim
  use 'christoomey/vim-sort-motion' -- https://github.com/christoomey/vim-sort-motion
  use 'airblade/vim-rooter' -- https://github.com/airblade/vim-rooter
  use 'AndrewRadev/bufferize.vim' -- https://github.com/AndrewRadev/bufferize.vim
  use 'AndrewRadev/quickpeek.vim' -- https://github.com/AndrewRadev/quickpeek.vim
  use 'chrisbra/Recover.vim' -- https://github.com/chrisbra/Recover.vim
  use 'junegunn/vim-emoji' -- https://github.com/junegunn/vim-emoji
  use { 'vim-jp/vital.vim', cmd = { 'Vitalize' } } -- https://github.com/vim-jp/vital.vim

  -- Project navigation / session
  use 'tpope/vim-projectionist' -- https://github.com/tpope/vim-projectionist
  use 'tpope/vim-eunuch' -- https://github.com/tpope/vim-eunuch
  -- use { 'dhruvasagar/vim-prosession',
  --   after = 'vim-obsession',
  --   requires = { { 'tpope/vim-obsession', cmd = 'Prosession' } },
  --   config = [[require('config.plugins.prosession')]],
  -- }

  -- Fern: NERDtree Replacement
  use 'lambdalisue/fern.vim' -- https://github.com/lambdalisue/fern.vim
  use 'antoinemadec/FixCursorHold.nvim' -- https://github.com/antoinemadec/FixCursorHold.nvim

  -- use { 'lambdalisue/fern-renderer-nerdfont.vim',
  --   requires = { 'lambdalisue/nerdfont.vim', 'lambdalisue/glyph-palette.vim' }
  -- } -- https://github.com/lambdalisue/fern-renderer-nerdfont.vim

  use 'hrsh7th/fern-mapping-collapse-or-leave.vim' -- https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim
  use 'lambdalisue/fern-git-status.vim' -- https://github.com/lambdalisue/fern-git-status.vim
  use 'lambdalisue/fern-hijack.vim' -- https://github.com/lambdalisue/fern-hijack.vim
  use 'lambdalisue/fern-bookmark.vim' -- https://github.com/lambdalisue/fern-bookmark.vim
  use 'lambdalisue/fern-mapping-git.vim' -- https://github.com/lambdalisue/fern-mapping-git.vim
  use 'lambdalisue/fern-mapping-mark-children.vim' -- https://github.com/lambdalisue/fern-mapping-mark-children.vim
  use 'lambdalisue/fern-mapping-project-top.vim' -- https://github.com/lambdalisue/fern-mapping-project-top.vim
  use 'lambdalisue/fern-mapping-quickfix.vim' -- https://github.com/lambdalisue/fern-mapping-quickfix.vim
  use 'yuki-yano/fern-preview.vim' -- https://github.com/yuki-yano/fern-preview.vim

  -- File Picker: CtrlP, CommandT, what?
  use { 'srstevenson/vim-picker',
    config = [[require('config.plugins.vimpicker')]],
    after = 'astronauta.nvim',
  } -- https://github.com/srstevenson/vim-picker

  -- Git
  use { 'tpope/vim-fugitive',
    cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}
  } -- https://github.com/tpope/vim-fugitive
  use 'tpope/vim-rhubarb' -- https://github.com/tpope/vim-rhubarb
  use 'sodapopcan/vim-twiggy' -- https://github.com/sodapopcan/vim-twiggy
  use 'int3/vim-extradite' -- https://github.com/int3/vim-extradite
  use 'tommcdo/vim-fugitive-blame-ext' -- https://github.com/tommcdo/vim-fugitive-blame-ext
  use 'kristijanhusak/vim-create-pr' -- https://github.com/kristijanhusak/vim-create-pr
  use 'junegunn/gv.vim' -- https://github.com/junegunn/gv.vim
  use 'mhinz/vim-signify' -- https://github.com/mhinz/vim-signify
  use 'rhysd/git-messenger.vim' -- https://github.com/rhysd/git-messenger.vim
  use 'jreybert/vimagit' -- https://github.com/jreybert/vimagit
  use { 'TimUntersberger/neogit',
    cmd = 'Neogit',
    config = [[require('config.plugins.neogit')]],
    requires = { 'nvim-lua/plenary.nvim' },
    after = { 'plenary.nvim' }
  } -- https://github.com/TimUntersberger/neogit

  -- Launch screen
  use { 'mhinz/vim-startify',
    config = [[require('config.plugins.setup.startify')]],
  } -- https://github.com/mhinz/vim-startify

  -- Languages
  -- Polyglot provides syntax and indentation for the following syntaxes I
  -- care about: ansible, applescript, C/C++, Crystal, CSV, Cucumber/Gherkin,
  -- Dart, D, Dockerfile / Docker-Compose, Elixir, Elm, Erlang, Fish, Git,
  -- Gleam, GraphQL, HTML, JavaScript, jq, JSON, Julia, Kotlin, Lua, Markdown,
  -- Nim, Objective-C, Perl, PLpgSQL, PlantUML, Pony, Python, Raku, RAML,
  -- Reason, Ruby, Rust, SCSS, Shell, Svelte, SVG, Swift, Terraform, TOML,
  -- Vue, XML, and Zig.
  --
  -- It may be recommended to add the following languages as needed for
  -- additional features:
  use { 'sheerun/vim-polyglot',
    event = 'VimEnter', setup = [[require('config.plugins.setup.polyglot')]],
  } -- https://github.com/sheerun/vim-polyglot
  use 'amadeus/vim-mjml' -- https://github.com/amadeus/vim-mjml
  use 'dmix/elvish.vim' -- https://github.com/dmix/elvish.vim
  use { 'fatih/vim-go',
    ft = 'go', run = ':GoInstallBinaries',
  } -- https://github.com/fatih/vim-go

  use { 'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate'
  } -- https://github.com/nvim-treesitter/nvim-treesitter
  -- use 'mfussenegger/nvim-lint' -- https://github.com/mfussenegger/nvim-lint

  use 'gko/vim-coloresque' -- https://github.com/gko/vim-coloresque

  -- Language Utilities
  use { 'sbdchd/neoformat',
    config = [[require('config.plugins.neoformat')]]
  } -- https://github.com/sbdchd/neoformat
  -- use 'mhartington/formatter.nvim' -- https://github.com/mhartington/formatter.nvim
  use 'tpope/vim-apathy' -- https://github.com/tpope/vim-apathy
  use { 'tpope/vim-rails', cmd = { 'Rails' } } -- https://github.com/tpope/vim-rails
  use { 'tpope/vim-rake', cmd = { 'Rake' } } -- https://github.com/tpope/vim-rake
  use { 'tpope/vim-bundler', cmd = { 'Bundle' } } -- https://github.com/tpope/vim-bundler
  use 'lambdalisue/vim-backslash' -- https://github.com/lambdalisue/vim-backslash
  use 'eliba2/vim-node-inspect' -- https://github.com/eliba2/vim-node-inspect'

  -- Colorscheme
  use 'franbach/miramare' -- https://github.com/franbach/miramare
  use 'KeitaNakamura/neodark.vim' -- https://github.com/KeitaNakamura/neodark.vim
  use 'tyrannicaltoucan/vim-deep-space' -- https://github.com/tyrannicaltoucan/vim-deep-space
  use 'tyrannicaltoucan/vim-quantum' -- https://github.com/tyrannicaltoucan/vim-quantum
  use 'sjl/badwolf' -- https://github.com/sjl/badwolf
  use 'morhetz/gruvbox' -- https://github.com/morhetz/gruvbox
  use 'nlknguyen/papercolor-theme' -- https://github.com/nlknguyen/papercolor-theme
  use 'cocopon/iceberg.vim' -- https://github.com/cocopon/iceberg.vim
  use 'natanscalvence/Gitdark' -- https://github.com/natanscalvence/Gitdark
  use 'softmotions/vim-dark-frost-theme' -- https://github.com/softmotions/vim-dark-frost-theme
  use 'savq/melange' -- https://github.com/savq/melange
  use 'senran101604/neotrix.vim' -- https://github.com/senran101604/neotrix.vim
  use 'habamax/vim-alchemist' -- https://github.com/habamax/vim-alchemist
  use 'ajh17/spacegray.vim' -- https://github.com/ajh17/spacegray.vim
  use 'hiroakis/cyberspace.vim' -- https://github.com/hiroakis/cyberspace.vim
  use 'marcelbeumer/spacedust.vim' -- https://github.com/marcelbeumer/spacedust.vim
  use 'gavinok/spaceway.vim' -- https://github.com/gavinok/spaceway.vim
  use 'novasenco/nokto' -- https://github.com/novasenco/nokto
  use 'fenetikm/falcon' -- https://github.com/fenetikm/falcon
  use 'yuttie/hydrangea-vim' -- https://github.com/yuttie/hydrangea-vim
  use 'yggdroot/duoduo' -- https://github.com/yggdroot/duoduo
  use 'reedes/vim-colors-pencil' -- https://github.com/reedes/vim-colors-pencil
  use 'hardselius/warlock' -- https://github.com/hardselius/warlock
  use 'arzg/vim-substrata' -- https://github.com/arzg/vim-substrata
  use 'sainnhe/gruvbox-material' -- https://github.com/sainnhe/gruvbox-material
  use { 'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup() end,
  } -- https://github.com/norcalli/nvim-colorizer.lua

  -- Completion Support
  use 'Shougo/echodoc.vim' -- https://github.com/Shougo/echodoc.vim

  -- use 'onsails/lspkind-nvim' -- https://github.com/onsails/lspkind-nvim
  -- use 'neovim/nvim-lspconfig' -- https://github.com/neovim/nvim-lspconfig
  -- use 'folke/trouble.nvim' -- https://github.com/folke/trouble.nvim
  -- use 'ray-x/lsp_signature.nvim' -- https://github.com/ray-x/lsp_signature.nvim
  -- use 'kosayoda/nvim-lightbulb' -- https://github.com/kosayoda/nvim-lightbulb

  -- use 'neovim/nvim-lspconfig' -- https://github.com/neovim/nvim-lspconfig
  -- use 'prabirshrestha/vim-lsp' -- https://github.com/prabirshrestha/vim-lsp
  -- use 'mattn/vim-lsp-settings' -- https://github.com/mattn/vim-lsp-settings
  -- use 'prabirshrestha/asyncomplete.vim' -- https://github.com/prabirshrestha/asyncomplete.vim
  -- use 'prabirshrestha/asyncomplete-lsp.vim' -- https://github.com/prabirshrestha/asyncomplete-lsp.vim

  -- use 'neovim/nvim-lspconfig' -- https://github.com/neovim/nvim-lspconfig
  -- use 'prabirshrestha/vim-lsp' -- https://github.com/prabirshrestha/vim-lsp
  -- use 'mattn/vim-lsp-settings' -- https://github.com/mattn/vim-lsp-settings
  -- use 'prabirshrestha/asyncomplete.vim' -- https://github.com/prabirshrestha/asyncomplete.vim
  -- use 'prabirshrestha/asyncomplete-lsp.vim' -- https://github.com/prabirshrestha/asyncomplete-lsp.vim

  use { 'haorenW1025/completion-nvim',
    opt = true,
    requires = {
      { 'hrsh7th/vim-vsnip', opt = true }, -- https://github.com/hrsh7th/vim-vsnip
      { 'hrsh7th/vim-vsnip-integ', opt = true } -- https://github.com/hrsh7th/vim-vsnip-integ
    }
  } -- https://github.com/haorenW1025/completion-nvim
  -- use { 'hrsh7th/nvim-cmp',
  --    requires = { 'L3MON4D3/LuaSnip',
  -- --     { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  -- --     'hrsh7th/cmp-nvim-lsp',
  -- --     { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
  -- --     { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
  -- --     { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
  --    },
  --    config = [[require('config.plugins.cmp')]],
  --    event = 'InsertEnter *',
  --  }

  use 'mattn/vim-lexiv' -- https://github.com/mattn/vim-lexiv

  -- Code manipulation
  use 'preservim/tagbar' -- https://github.com/preservim/tagbar
  use 'tommcdo/vim-exchange' -- https://github.com/tommcdo/vim-exchange
  use 'tpope/vim-commentary' -- https://github.com/tpope/vim-commentary
  use 'tpope/vim-endwise' -- https://github.com/tpope/vim-endwise
  use 'tpope/vim-ragtag' -- https://github.com/tpope/vim-ragtag
  use 'alvan/vim-closetag' -- https://github.com/alvan/vim-closetag
  use 'AndrewRadev/tagalong.vim' -- https://github.com/AndrewRadev/tagalong.vim
  use { 'ludovicchabant/vim-gutentags',
    event = 'VimEnter', setup = [[require('config.plugins.setup.gutentags')]],
  } -- https://github.com/ludovicchabant/vim-gutentags
  use 'pechorin/any-jump.vim' -- https://github.com/pechorin/any-jump.vim
  use 'AndrewRadev/inline_edit.vim' -- https://github.com/AndrewRadev/inline_edit.vim
  use 'AndrewRadev/multichange.vim' -- https://github.com/AndrewRadev/multichange.vim

  -- Text Editing
  use 'reedes/vim-pencil' -- https://github.com/reedes/vim-pencil
  use { 'junegunn/goyo.vim',
    opt = true, cmd = [[Goyo]], config = [[require('config.plugins.goyo')]],
    requires = { { 'junegunn/limelight.vim', opt = true } },
    after = 'limelight.vim'
  } -- https://github.com/junegunn/goyo.vim
  use { 'vimwiki/vimwiki', opt = true } -- https://github.com/vimwiki/vimwiki
  use 'reedes/vim-lexical' -- https://github.com/reedes/vim-lexical
  use { 'kristijanhusak/orgmode.nvim', opt = true } -- https://github.com/kristijanhusak/orgmode.nvim
  use { 'akinsho/org-bullets.nvim', opt = true } -- https://github.com/akinsho/org-bullets.nvim

  -- Movements
  use 'chaoren/vim-wordmotion' -- https://github.com/chaoren/vim-wordmotion
  use { 'wellle/targets.vim', opt = true } -- https://github.com/wellle/targets.vim
  use 'rhysd/clever-f.vim' -- https://github.com/rhysd/clever-f.vim
  use 'edkolev/erlang-motions.vim' -- https://github.com/edkolev/erlang-motions.vim
  use { 'mg979/vim-visual-multi', opt = true } -- https://github.com/mg979/vim-visual-multi
  use 'christoomey/vim-conflicted' -- https://github.com/christoomey/vim-conflicted
  use 'rhysd/conflict-marker.vim' -- https://github.com/rhysd/conflict-marker.vim

  -- Task running & quickfix
  use { 'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
    requires = {
      -- This is only required until vim-dispatch v 1.3 or later. See https://github.com/tpope/vim-dadbod/pull/64
      { 'radenling/vim-dispatch-neovim' } -- https://github.com/radenling/vim-dispatch-neovim
    }
  } -- https://github.com/tpope/vim-dispatch
  use 'hauleth/asyncdo.vim' -- https://github.com/hauleth/asyncdo.vim
  use 'romainl/vim-qf' -- https://github.com/romainl/vim-qf
  use 'romainl/vim-qlist' -- https://github.com/romainl/vim-qlist
  use 'Olical/vim-enmasse' -- https://github.com/Olical/vim-enmasse
  use 'igemnace/vim-makery' -- https://github.com/igemnace/vim-makery
  use 'kevinhwang91/nvim-bqf' -- https://github.com/kevinhwang91/nvim-bqf
  -- use 'AndrewRadev/qftools.vim' -- https://github.com/AndrewRadev/qftools.vim
  -- use 'AndrewRadev/linediff.vim' -- https://github.com/AndrewRadev/linediff.vim

  -- Splits management
  use 't9md/vim-choosewin' -- https://github.com/t9md/vim-choosewin
  use 'dhruvasagar/vim-zoom' -- https://github.com/dhruvasagar/vim-zoom

  -- Optional debug / test stuff
  use { 'Vimjas/vint', opt = true } -- https://github.com/Vimjas/vint
  use { 'puremourning/vimspector',
    disable = true, setup = [[vim.g.vimspector_enable_mappings = 'HUMAN']],
  } -- https://github.com/puremourning/vimspector
  use 'vim-test/vim-test' -- https://github.com/vim-test/vim-test
  use { 'junegunn/vader.vim', opt = true } -- https://github.com/junegunn/vader.vim
  use { 'tpope/vim-scriptease', opt = true } -- https://github.com/tpope/vim-scriptease
  use { 'tweekmonster/exception.vim', opt = true } -- https://github.com/tweekmonster/exception.vim
  use { 'tweekmonster/helpful.vim', opt = true } -- https://github.com/tweekmonster/helpful.vim
  use { 'mhinz/vim-lookup', opt = true } -- https://github.com/mhinz/vim-lookup
  use { 'thinca/vim-themis', opt = true } -- https://github.com/thinca/vim-themis
  -- use { 'mfussenegger/nvim-dap',
  --   setup = [[require('config.plugins.setup.dap')]],
  --   config = [[require('config.plugins.dap')]],
  --   requires = 'jbyuki/one-small-step-for-vimkind',
  --   wants = 'one-small-step-for-vimkind',
  --   module = 'dap',
  -- }
  -- use { 'rcarriga/nvim-dap-ui',
  --   requires = 'nvim-dap',
  --   after = 'nvim-dap',
  --   config = function()require('dapui').setup()end,
  -- }

  use { 'mattn/gist-vim', opt = true } -- https://github.com/mattn/gist-vim
  use { 'mbbill/undotree',
    cmd = 'UndotreeToggle',
    config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
  } -- https://github.com/mbbill/undotree

  -- Loaded only for specific filetypes on demand. Requires autocommands below.
  use { 'kristijanhusak/vim-js-file-import',
    ft = 'javascript',
    run = 'npm install'
  } -- https://github.com/kristijanhusak/vim-js-file-import

  use 'voldikss/vim-floaterm' -- https://github.com/voldikss/vim-floaterm
  use 'skywind3000/vim-quickui' -- https://github.com/skywind3000/vim-quickui

  -- neovim Helpers
  use 'tjdevries/astronauta.nvim' -- https://github.com/tjdevries/astronauta.nvim

  -- Considerations:
  -- use '9mm/vim-closer' -- https://github.com/9mm/vim-closer
  -- use_rocks 'penlight'
  -- use_rocks {'lua-resty-http', 'lpeg'}
  -- use { 'iamcco/markdown-preview.nvim',
  --   run = 'cd app && yarn install', cmd = 'MarkdownPreview'
  -- } -- https://github.com/iamcco/markdown-preview.nvim
  -- use { 'glacambre/firenvim',
  --   run = function() vim.fn['firenvim#install'](0) end
  -- } -- https://github.com/glacambre/firenvim
  -- use { 'glepnir/galaxyline.nvim',
  --   branch = 'main', config = function() require'statusline' end,
  --   requires = {'kyazdani42/nvim-web-devicons'}
  -- } -- https://github.com/glepnir/galaxyline.nvim
  -- use { 'lewis6991/gitsigns.nvim',
  --   requires = { 'nvim-lua/plenary.nvim' }, -- https://github.com/nvim-lua/plenary.nvim
  --   config = function() require('gitsigns').setup() end
  -- } -- https://github.com/lewis6991/gitsigns.nvim
  -- use { 'tjdevries/colorbuddy.vim' } -- https://github.com/tjdevries/colorbuddy.vim
  -- use { 'dracula/vim', as = 'dracula' } -- https://github.com/dracula/vim
  -- use { 'hkupty/iron.nvim',
  --   setup = [[vim.g.iron_map_defaults = 0]],
  --   config = [[require('config.plugins.iron')]],
  --   cmd = { 'IronRepl', 'IronSend', 'IronReplHere' },
  -- }
  -- use { 'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]] }
  -- use { 'ThePrimeagen/refactoring.nvim', opt = true }
  -- use { 'akinsho/nvim-bufferline.lua',
  --   requires = 'kyazdani42/nvim-web-devicons',
  --   config = [[require('config.plugins.bufferline')]],
  --   event = 'User ActuallyEditing',
  -- }
end,
config = {
  -- log = { level = 'trace' }
  -- display = {
  --   open_fn = function () return require('packer.util').float({ border = 'single' }) end,
  -- }
}})
