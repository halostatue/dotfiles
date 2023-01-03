return {
  { -- https://github.com/tpope/vim-dispatch
    'tpope/vim-dispatch',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/hauleth/asyncdo.vim
    'hauleth/asyncdo.vim',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/kevinhwang91/nvim-bqf
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  },
  { -- https://github.com/junegunn/fzf
    'junegunn/fzf',
    event = { 'VeryLazy' },
    build = function() vim.fn['fzf#install']() end,
  },
  { -- https://github.com/junegunn/fzf.vim
    'junegunn/fzf.vim',
    event = { 'VeryLazy' },
  },
}

-- https://github.com/skywind3000/asyncrun.vim
-- https://github.com/skywind3000/asynctasks.vim
