return {
  { -- https://github.com/williamboman/mason.nvim
    'williamboman/mason.nvim',
    event = { 'VeryLazy' },
    dependencies = {
      { -- https://github.com/williamboman/mason-lspconfig.nvim
        'williamboman/mason-lspconfig.nvim',
        event = { 'VeryLazy' },
      },
      { -- https://github.com/neovim/nvim-lspconfig
        'neovim/nvim-lspconfig',
        event = { 'VeryLazy' },
      },
    },
    config = function()
      require('mason').setup {
        -- prepend (default, Mason's bin location is put first in PATH)
        -- append (Mason's bin location is put at the end of PATH)
        -- skip (doesn't modify PATH)
        -- PATH = 'prepend',

        log_level = vim.log.levels.INFO, -- vim.log.levels.DEBUG

        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        -- false: Servers are not automatically installed.
        -- true: All servers set up via lspconfig are automatically installed.
        -- { exclude: string[] }: true, excluding listed servers
        automatic_installation = false,
      }

      -- Uncomment only if issue shows up
      -- vim.lsp.handlers['textDocument/publishDiagnostics'] =
      --   vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      --     underline = true,
      --     virtual_text = {
      --       spacing = 5,
      --       severity_limit = 'Warning',
      --     },
      --     update_in_insert = true,
      --   })
    end,
  },
  { -- https://github.com/RubixDev/mason-update-all
    'RubixDev/mason-update-all',
    cmd = { 'MasonUpdateAll' },
  },
  { -- https://github.com/jose-elias-alvarez/null-ls.nvim
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'VeryLazy' },
    dependencies = {
      { -- https://github.com/jay-babu/mason-null-ls.nvim
        'jay-babu/mason-null-ls.nvim',
        event = { 'VeryLazy' },
      },
    },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup {
        root_dir = function(fname) return vim.fn.FindRootDirectory() end,
        -- debug = true,
        sources = {
          -- null_ls.builtins.code_actions.eslint,
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.code_actions.gitrebase,
          null_ls.builtins.code_actions.proselint,
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.alex,
          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.codespell,
          null_ls.builtins.diagnostics.credo,
          -- null_ls.builtins.diagnostics.cspell,
          null_ls.builtins.diagnostics.editorconfig_checker.with {
            command = 'editorconfig-checker',
          },
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.fish,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.hadolint,
          -- null_ls.builtins.diagnostics.luacheck,
          null_ls.builtins.diagnostics.markdownlint,
          -- null_ls.builtins.diagnostics.markdownlint_cli2,
          null_ls.builtins.diagnostics.proselint,
          -- null_ls.builtins.diagnostics.revive,
          -- null_ls.builtins.diagnostics.rubocop,
          -- null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.diagnostics.selene,
          null_ls.builtins.diagnostics.semgrep,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.sqlfluff.with {
            extra_args = { '--dialect', 'postgres' },
          },
          -- null_ls.builtins.diagnostics.standardjs,
          null_ls.builtins.diagnostics.standardrb,
          null_ls.builtins.diagnostics.staticcheck,
          -- null_ls.builtins.diagnostics.swiftlint,
          null_ls.builtins.diagnostics.textlint,
          -- null_ls.builtins.diagnostics.tsc,
          x,
          null_ls.builtins.diagnostics.vint,
          null_ls.builtins.diagnostics.vulture,
          -- null_ls.builtins.diagnostics.write_good,
          -- null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.erlfmt,
          null_ls.builtins.formatting.fish_indent,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.goimports_reviser,
          null_ls.builtins.formatting.just,
          null_ls.builtins.formatting.mix,
          null_ls.builtins.formatting.pg_format,
          -- null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.prettier_standard,
          null_ls.builtins.formatting.prismaFmt,
          -- null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.ruff,
          -- null_ls.builtins.formatting.rufo,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.shellharden,
          null_ls.builtins.formatting.shfmt,
          -- null_ls.builtins.formatting.standardjs,
          null_ls.builtins.formatting.standardrb,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.surface,
          null_ls.builtins.formatting.taplo,
          -- null_ls.builtins.formatting.terrafmt,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.formatting.zigfmt,
        },
      }

      require('mason-null-ls').setup {
        ensure_installed = {},
        automatic_installation = true, -- true / false / { exclude = {} }
        automatic_setup = false, -- true / false / { types = { SOURCE = { TYPES }}}
        -- 	Ex: { types = { eslint_d = {'formatting'} } }
      }
    end,
  },
  { -- https://github.com/folke/lsp-colors.nvim
    'folke/lsp-colors.nvim',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/kosayoda/nvim-lightbulb
    'kosayoda/nvim-lightbulb',
    event = { 'VeryLazy' },
    config = { autocmd = { enabled = true } },
  },
  { -- https://github.com/stevearc/stickybuf.nvim
    'stevearc/stickybuf.nvim',
    event = { 'VeryLazy' },
    config = true,
  },
  { -- https://github.com/folke/trouble.nvim
    'folke/trouble.nvim',
    event = { 'VeryLazy' },
    config = function()
      require('trouble').setup {
        icons = false,
        fold_open = '▼',
        fold_closed = '▶',
        indent_lines = false,
        signs = { error = 'error', warning = 'warn', hint = 'hint', information = 'info' },
        use_lsp_diagnostic_signs = false,
      }

      vim.keymap.set(
        'n',
        '<leader>xx',
        '<cmd>Trouble<cr>',
        { silent = true, remap = false }
      )
      vim.keymap.set(
        'n',
        '<leader>xw',
        '<cmd>Trouble lsp_workspace_diagnostics<cr>',
        { silent = true, remap = false }
      )
      vim.keymap.set(
        'n',
        '<leader>xd',
        '<cmd>Trouble lsp_document_diagnostics<cr>',
        { silent = true, remap = false }
      )
      vim.keymap.set(
        'n',
        '<leader>xl',
        '<cmd>Trouble loclist<cr>',
        { silent = true, remap = false }
      )
      vim.keymap.set(
        'n',
        '<leader>xq',
        '<cmd>Trouble quickfix<cr>',
        { silent = true, remap = false }
      )
      vim.keymap.set(
        'n',
        'gR',
        '<cmd>Trouble lsp_references<cr>',
        { silent = true, remap = false }
      )
    end,
  },
  { -- https://github.com/nvim-lua/lsp-status.nvim
    'nvim-lua/lsp-status.nvim',
    event = { 'VeryLazy' },
  },
}
