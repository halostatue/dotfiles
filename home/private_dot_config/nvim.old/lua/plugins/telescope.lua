local defkey = function(lhs, rhs) return { lhs, rhs, remap = false, silent = true } end

return {
  { -- https://github.com/nvim-telescope/telescope.nvim
    'nvim-telescope/telescope.nvim',
    event = { 'VeryLazy' },
    -- replaces https://github.com/srstevenson/vim-picker
    keys = {
      defkey('<leader>pe', '<cmd>Telescope find_files<cr>'),
      defkey('<leader>pb', '<cmd>Telescope buffers<cr>'),
      defkey('<leader>pf', '<cmd>Telescope frecency<cr>'),
      defkey('<leader>pg', '<cmd>Telescope live_grep<cr>'),
      defkey('<leader>pG', '<cmd>Telescope grep_string<cr>'),
      defkey('<leader>ph', '<cmd>Telescope help_tags<cr>'),
      defkey('<leader>p.', '<cmd>Telescope file_browser<cr>'),
      defkey('<leader>pt', '<cmd>Telescope treesitter<cr>'),
      defkey('<leader>gf', '<cmd>Telescope git_files<cr>'),
      defkey('<leader>gc', '<cmd>Telescope git_commits<cr>'),
      defkey('<leader>bg', '<cmd>Telescope git_bcommits<cr>'),
      defkey('<leader>gb', '<cmd>Telescope git_branches<cr>'),
      defkey('<leader>gs', '<cmd>Telescope git_status<cr>'),
      defkey('<leader>gS', '<cmd>Telescope git_stash<cr>'),
      defkey('<leader>tt', '<cmd>Telescope builtin<cr>'),
      defkey('<leader>ta', '<cmd>Telescope aerial<cr>'),
    },
    dependencies = {
      { -- https://github.com/stevearc/aerial.nvim
        'stevearc/aerial.nvim',
        { -- https://github.com/nvim-telescope/telescope-frecency.nvim
          'nvim-telescope/telescope-frecency.nvim',
          dependencies = {
            { 'tami5/sqlite.lua' }, -- https://github.com/tami5/sqlite.lua
          },
        },
        { -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make',
        },
      },
    },
    config = function()
      require('aerial').setup()

      local telescope = require('telescope')
      local trouble = require('trouble.providers.telescope')

      -- Extensions
      telescope.load_extension('aerial')
      telescope.load_extension('frecency')
      telescope.load_extension('fzf')
      telescope.load_extension('notify')

      telescope.setup {
        defaults = {
          layout_strategy = 'flex',
          scroll_strategy = 'cycle',
          path_dispaly = { 'smart', truncate = 3 },
          dynamic_preview_title = true,
          mappings = {
            i = { ['<c-t>'] = trouble.open_with_trouble },
            n = { ['<c-t>'] = trouble.open_with_trouble },
          },
        },
        pickers = {
          buffers = {
            show_all_buffers = true,
            previewer = false,
            sort_lastused = true,
            theme = 'ivy',
          },
          find_files = { theme = 'ivy' },
          file_browser = { theme = 'ivy' },
          grep_string = { theme = 'ivy' },
          live_grep = { theme = 'dropdown' },
          lsp_code_actions = { theme = 'dropdown' },
          lsp_definitions = { theme = 'dropdown' },
          lsp_implementations = { theme = 'dropdown' },
          lsp_references = { theme = 'dropdown' },
        },
        extensions = {
          frecency = { workspaces = {} },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }
    end,
  },
}
