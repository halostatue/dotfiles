require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    custom_captures = {
      -- ['foo.bar'] = 'Identifier,' // @foo.bar capture group is Identifier
    },
    additional_vim_regex_highlighting = false, -- maybe? will slow things down
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   }
  -- },
  -- indent = { enable = true }
  autotag = { enable = true },
  matchup = { enable = true },
  context_commentstring = { enable = true },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'grr'
      }
    },
    navigation = {
      enable = true
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
}

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

require('treesitter-context').setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  throttle = true, -- Throttles plugin updates (may improve performance)
}

require('twilight').setup {
  -- dimming = {
  --   alpha = 0.25, -- amount of dimming
  --   -- we try to get the foreground from the highlight groups or fallback color
  --   color = { "Normal", "#ffffff" },
  --   inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  -- },
  -- context = 10, -- amount of lines we will try to show around the current line
  -- treesitter = true, -- use treesitter when available for the filetype
  -- -- treesitter is used to automatically expand the visible text,
  -- -- but you can further control the types of nodes that should always be fully expanded
  -- expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
  --   "function",
  --   "method",
  --   "table",
  --   "if_statement",
  -- },
  -- exclude = {}, -- exclude these filetypes
}


-- Uncomment only if issue shows up
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     {
--         underline = true,
--         virtual_text = {
--             spacing = 5,
--             severity_limit = 'Warning',
--         },
--         update_in_insert = true,
--     }
-- )
