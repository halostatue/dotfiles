local merge_table = require('config.utils').merge_table
local defkey = function(lhs, rhs, opts) return merge_table({ lhs, rhs }, opts or {}) end

return {
  { -- https://github.com/haya14busa/is.vim
    'haya14busa/is.vim',
    event = { 'VeryLazy' },
    init = function(_plugin) vim.g['is#do_default_mappings'] = 0 end,
    keys = {
      defkey('n', '<Plug>(is-nohl)<Plug>(anzu-n-with-echo)zz', { remap = true }),
      defkey('N', '<Plug>(is-nohl)<Plug>(anzu-N-with-echo)zz', { remap = true }),
      defkey(
        '*',
        '<Plug>(asterisk-z*)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)',
        { remap = true }
      ),
      defkey(
        'g*',
        '<Plug>(asterisk-gz*)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)',
        { remap = true }
      ),
      defkey(
        '#',
        '<Plug>(asterisk-z#)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)',
        { remap = true }
      ),
      defkey(
        'g#',
        '<Plug>(asterisk-gz#)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)',
        { remap = true }
      ),
    },
    dependencies = {
      { -- https://github.com/haya14busa/vim-asterisk
        'haya14busa/vim-asterisk',
        event = { 'VeryLazy' },
      },
      { -- https://github.com/osyo-manga/vim-anzu
        'osyo-manga/vim-anzu',
        event = { 'VeryLazy' },
      },
    },
  },
  { -- https://github.com/dyng/ctrlsf.vim
    'dyng/ctrlsf.vim',
    keys = {
      defkey('<C-F>f', '<Plug>CtrlSFPrompt', { remap = true }),
      defkey('<C-F>f', '<Plug>CtrlSFVwordPath', { mode = 'v', remap = true }),
      defkey('<C-F>F', '<Plug>CtrlSFVwordExec', { mode = 'v', remap = true }),
      defkey('<C-F>n', '<Plug>CtrlSFCwordPath', { remap = true }),
      defkey('<C-F>p', '<Plug>CtrlSFPwordPath', { remap = true }),
      defkey('<C-F>o', '<Cmd>CtrlSFOpen<CR>', { remap = false }),
      defkey('<C-F>t', '<Cmd>CtrlSFToggle<CR>', { remap = false }),
      defkey('<C-F>t', '<Cmd>CtrlSFToggle<CR>', { mode = 'i', remap = false }),
    },
  },
  { -- https://github.com/mhinz/vim-grepper
    'mhinz/vim-grepper',
    keys = {
      defkey('<leader>G', '<Cmd>Grepper<CR>', { remap = false }),
      defkey('gG', '<Plug>(GrepperOperator)', { remap = true }),
      defkey('gG', '<Plug>(GrepperOperator)', { mode = 'x', remap = true }),
    },
  },
  { -- https://github.com/RRethy/vim-illuminate
    'RRethy/vim-illuminate',

    event = { 'VeryLazy' },
    config = function()
      -- default configuration
      require('illuminate').configure {
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          'dirvish',
          'fugitive',
          'fern',
        },
      }
    end,
  },
  { -- https://github.com/romainl/vim-cool
    'romainl/vim-cool',
    event = { 'VeryLazy' },
  },
}
