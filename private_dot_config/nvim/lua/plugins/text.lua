return {
  {
    'folke/zen-mode.nvim', -- https://github.com/folke/zen-mode.nvim
    cmd = { 'ZenMode' },
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 0.95,
          width = 120, -- 0.8
          height = 1, -- 5
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = false }, -- disables git signs
        },
      }
    end,
  },
  {
    'mzlogin/vim-markdown-toc', -- https://github.com/mzlogin/vim-markdown-toc
    cmd = { 'GenTocGFM', 'GenTocGitLab', 'GenTocMarked', 'GenTocRedcarpet', 'RemoveToc' },
  },
  {
    'junegunn/goyo.vim', -- https://github.com/junegunn/goyo.vim
    cmd = { 'Goyo' },
    dependencies = {
      {
        'junegunn/limelight.vim', -- https://github.com/junegunn/limelight.vim
        cmd = { 'Limelight' },
      },
    },
    config = function()
      local goyo = vim.api.nvim_create_augroup('Goyo', {})
      vim.api.nvim_create_autocmd('User GoyoEnter', { command = 'Limelight<CR>' })
      vim.api.nvim_create_autocmd('User GoyoLeave', { command = 'Limelight!<CR>' })
    end,
  },
  { -- https://github.com/nvim-neorg/neorg
    'nvim-neorg/neorg',
    ft = 'norg',
    config = true,
  },
}
