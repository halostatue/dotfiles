return {
  { -- https://github.com/nvim-treesitter/nvim-treesitter
    'nvim-treesitter/nvim-treesitter',
    event = { 'VeryLazy' },
    build = ':TSUpdate',
    dependencies = {
      { -- https://github.com/andymass/vim-matchup
        'andymass/vim-matchup',
        event = { 'VeryLazy' },
        config = function()
          vim.g.matchup_matchparen_deferred = 1
          vim.g.matchup_matchparen_deferred_show_delay = 100
          vim.g.matchup_matchparen_hi_surround_always = 1
          vim.g.matchup_override_vimtex = 1
          vim.g.matchup_delim_start_plaintext = 0
          vim.g.matchup_transmute_enabled = 0
        end,
      },
      { -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
        'nvim-treesitter/nvim-treesitter-refactor',
      },
      { -- https://github.com/romgrk/nvim-treesitter-context
        'romgrk/nvim-treesitter-context',
        config = true,
      },
      { -- https://github.com/windwp/nvim-ts-autotag
        'windwp/nvim-ts-autotag',
      },
      { -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
      { -- https://github.com/IndianBoy42/tree-sitter-just
        'IndianBoy42/tree-sitter-just',
        config = {},
      },
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'css',
          'diff',
          'dockerfile',
          'eex',
          'elixir',
          'erlang',
          'fish',
          'git_rebase',
          'gitattributes',
          'gitcommit',
          'gitignore',
          'gleam',
          'go',
          'gomod',
          'gowork',
          'graphql',
          'hcl',
          'heex',
          'help',
          'html',
          'java',
          'javascript',
          'jq',
          'jsdoc',
          'json',
          'jsonc',
          'latex',
          'lua',
          'make',
          'markdown',
          'markdown_inline',
          'mermaid',
          'perl',
          'prisma',
          'python',
          'regex',
          'ruby',
          'rust',
          'scss',
          'sql',
          'surface',
          'svelte',
          'terraform',
          'toml',
          'typescript',
          'vim',
          'vue',
          'yaml',
        },
        -- Additional options:
        -- awk, c, c_sharp, cpp, d, dot, ebnf, elvish, fennel, hjson, http, json5, jsonnet, julia,
        -- kotlin, norg, ocaml, r, swift, zig
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        autotag = { enable = true },
        context = { enable = true },
        context_commentstring = { enable = true },
        matchup = { enable = true },
        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = true },
          smart_rename = { enable = true, keymaps = { smart_rename = 'grr' } },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = 'gnd',
              list_definitions = 'gnD',
              list_definitions_toc = 'gO',
              goto_next_usage = '<a-*>',
              goto_previous_usage = '<a-#>',
            },
          },
        },
      }

      -- vim.opt.foldmethod = 'expr'
      -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
  },
  { -- https://github.com/folke/twilight.nvim
    'folke/twilight.nvim',
    cmd = { 'Twilight', 'TwilightDisable', 'TwilightEnable' },
    config = true,
  },
}
