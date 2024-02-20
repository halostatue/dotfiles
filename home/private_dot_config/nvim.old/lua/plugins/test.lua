return {
  { -- https://github.com/vim-test/vim-test
    'vim-test/vim-test',
    cmd = {
      'TestClass',
      'TestFile',
      'TestLast',
      'TestNearest',
      'TestSuite',
      'TestVisit',
    },
    config = function()
      vim.g['test#strategy'] = {
        nearest = 'basic',
        file = 'dispatch',
        suite = 'floaterm',
      }
      vim.g['test#neovim#start_normal'] = true
      vim.g['test#basic#start_normal'] = true
    end,
  },
}
