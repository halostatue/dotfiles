local merge_table = require('config.utils').merge_table
local defkey = function(lhs, rhs, opts)
  return merge_table({ lhs, rhs }, opts or { remap = false, silent = true })
end

return {
  { -- https://github.com/tpope/vim-projectionist
    'tpope/vim-projectionist',
    config = function()
      -- This space left intentionally blank, for now.
    end,
  },
  { -- https://github.com/tpope/vim-eunuch
    'tpope/vim-eunuch',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/dhruvasagar/vim-prosession
    'dhruvasagar/vim-prosession',
    cmd = { 'Prosession', 'ProsessionDelete', 'ProsessionClean' },
    dependencies = {
      { -- https://github.com/tpope/vim-obsession
        'tpope/vim-obsession',
        cmd = { 'Obsession' },
      },
    },
    init = function()
      vim.g.prosession_tmux_title = 1
      vim.g.prosession_on_startup = 0
      vim.g.prosession_dir = vim.fn['hz#xdg_path']('cache', 'sessions')
    end,
  },
  { -- https://github.com/lambdalisue/fern.vim Fern: NERDtree Replacement
    'lambdalisue/fern.vim',
    cmd = { 'Fern' },
    keys = {
      defkey('<C-F>.', '<cmd>Fern . -drawer -reveal=%<CR>'),
      defkey('<C-F>,', '<cmd>Fern . -drawer -stay -reveal=%<CR>'),
      defkey('<C-F>b', '<cmd>Fern bookmark:/// -drawer<CR>'),
    },
    dependencies = {
      { -- https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim
        'hrsh7th/fern-mapping-collapse-or-leave.vim',
      },
      { -- https://github.com/lambdalisue/fern-bookmark.vim
        'lambdalisue/fern-bookmark.vim',
      },
      { -- https://github.com/lambdalisue/fern-git-status.vim
        'lambdalisue/fern-git-status.vim',
      },
      { -- https://github.com/lambdalisue/fern-hijack.vim
        'lambdalisue/fern-hijack.vim',
      },
      { -- https://github.com/lambdalisue/fern-mapping-git.vim
        'lambdalisue/fern-mapping-git.vim',
      },
      { -- https://github.com/lambdalisue/fern-mapping-mark-children.vim
        'lambdalisue/fern-mapping-mark-children.vim',
      },
      { -- https://github.com/lambdalisue/fern-mapping-project-top.vim
        'lambdalisue/fern-mapping-project-top.vim',
      },
      { -- https://github.com/lambdalisue/fern-mapping-quickfix.vim
        'lambdalisue/fern-mapping-quickfix.vim',
      },
      { -- https://github.com/yuki-yano/fern-preview.vim
        'yuki-yano/fern-preview.vim',
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('fern-startup', {}),
        pattern = { 'fern' },
        callback = function()
          vim.keymap.set(
            'n',
            'p',
            '<Plug>(fern-action-preview:toggle)',
            { silent = true, buffer = true, remap = true }
          )
          vim.keymap.set(
            'n',
            '<C-p>',
            '<Plug>(fern-action-preview:auto:toggle)',
            { silent = true, buffer = true, remap = true }
          )
          vim.keymap.set(
            'n',
            '<C-d>',
            '<Plug>(fern-action-preview:scroll:down:half)',
            { silent = true, buffer = true, remap = true }
          )
          vim.keymap.set(
            'n',
            '<C-u>',
            '<Plug>(fern-action-preview:scroll:up:half)',
            { silent = true, buffer = true, remap = true }
          )
          vim.keymap.set(
            'n',
            '<C-u>',
            '<Plug>(fern-action-preview:scroll:up:half)',
            { silent = true, buffer = true, remap = true }
          )
          vim.keymap.set(
            'n',
            '<C-u>',
            '<Plug>(fern-action-preview:scroll:up:half)',
            { silent = true, buffer = true, remap = true }
          )
          vim.keymap.set(
            'n',
            'q',
            '<C-W>c',
            { silent = true, buffer = true, remap = true }
          )
        end,
      })
    end,
  },
}
