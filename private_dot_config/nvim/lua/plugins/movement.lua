return {
  { -- https://github.com/chaoren/vim-wordmotion
    'chaoren/vim-wordmotion',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/wellle/targets.vim
    'wellle/targets.vim',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/rhysd/clever-f.vim
    'rhysd/clever-f.vim',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/ggandor/flit.nvim
    'ggandor/flit.nvim',
    event = { 'VeryLazy' },
    dependencies = {
      { -- https://github.com/ggandor/leap.nvim
        'ggandor/leap.nvim',
        event = { 'VeryLazy' },
        config = function()
          -- require('leap').add_default_mappings()
        end,
      },
    },
    config = true,
  },
}
