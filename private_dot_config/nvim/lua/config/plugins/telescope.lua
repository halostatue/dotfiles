local telescope = require('telescope')
local trouble = require('trouble.providers.telescope')

-- Extensions
telescope.load_extension('frecency')
telescope.load_extension('fzf')

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    path_dispaly = {'smart', truncate = 3 },
    dynamic_preview_title = true,
    mappings = {
      i = { ['<c-t>'] = trouble.open_with_trouble },
      n = { ['<c-t>'] = trouble.open_with_trouble },
    }
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

