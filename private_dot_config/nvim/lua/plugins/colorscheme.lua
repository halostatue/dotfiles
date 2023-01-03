return {
  { -- https://github.com/KeitaNakamura/neodark.vim
    'KeitaNakamura/neodark.vim',
  },
  { -- https://github.com/catppuccin/nvim
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
  { -- https://github.com/tyrannicaltoucan/vim-deep-space
    'tyrannicaltoucan/vim-deep-space',
    init = function() vim.g.deepspace_italics = 1 end,
  },
  { -- https://github.com/sjl/badwolf
    'sjl/badwolf',
    init = function()
      -- vim.g.badwolf_darkgutter = 1
      -- vim.g.badwolf_css_props_highlight = 1
    end,
  },
  { -- https://github.com/cocopon/iceberg.vim
    'cocopon/iceberg.vim',
  },
  { -- https://github.com/savq/melange
    'savq/melange',
  },
  { -- https://github.com/novasenco/nokto
    'novasenco/nokto',
  },
  { -- https://github.com/fenetikm/falcon
    'fenetikm/falcon',
    init = function()
      vim.g.falcon_italic = 1
      vim.g.falcon_bold = 1
    end,
  },
  { -- https://github.com/yggdroot/duoduo
    'yggdroot/duoduo',
  },
  { -- https://github.com/preservim/vim-colors-pencil
    'preservim/vim-colors-pencil',
    init = function()
      vim.g.pencil_neutral_headings = 1
      vim.g.pencil_gutter_color = 1
      vim.g.pencil_terminal_italics = 1
      vim.g['pencil#conceallevel'] = 0
      vim.g['pencil#textwidth'] = 80
    end,
  },
  { -- https://github.com/hardselius/warlock
    'hardselius/warlock',
  },
  { -- https://github.com/ishan9299/modus-theme-vim
    'ishan9299/modus-theme-vim',
    lazy = false,
    priority = 1000,
  },
  { -- https://github.com/marko-cerovac/material.nvim
    'marko-cerovac/material.nvim',
  },
  { -- https://github.com/Yagua/nebulous.nvim
    'Yagua/nebulous.nvim',
  },
  { -- https://github.com/shaunsingh/oxocarbon.nvim
    'shaunsingh/oxocarbon.nvim',
  },
  { -- https://ellisonleao/gruvbox.nvim
    'ellisonleao/gruvbox.nvim',
  },
  { -- https://github.com/folke/tokyonight.nvim
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local tokyonight = require('tokyonight')
      tokyonight.setup {
        style = 'storm',
        sidebars = {
          'qf',
          'fern',
          'vista_kind',
          'terminal',
          'spectre_panel',
          'startuptime',
          'Outline',
        },
        on_highlights = function(hl, c)
          hl.CursorLineNr = { fg = c.orange, bold = true }
          local prompt = '#2d3149'
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = prompt }
          hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
          hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        end,
      }
      tokyonight.load()
    end,
  },
}
