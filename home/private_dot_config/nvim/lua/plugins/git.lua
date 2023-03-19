local signs = function(plugin)
  if plugin == 'signify' then
    return { -- https://github.com/mhinz/vim-signify
      'mhinz/vim-signify',
      event = { 'VeryLazy' },
      dependencies = {
        { -- https://github.com/junegunn/vim-emoji
          'junegunn/vim-emoji',
          lazy = false,
        },
      },
      setup = function()
        local emoji = vim.fn['emoji#for']

        vim.g.signify_vcs_list = { 'git', 'hg' }
        vim.g.signify_sign_add = emoji('small_blue_diamond')
        vim.g.signify_sign_delete = emoji('small_red_triangle')
        vim.g.signify_sign_delete_first_line = emoji('small_red_triangle')
        vim.g.signify_sign_change = emoji('collision')
        vim.g.signify_sign_changedelete = emoji('collision')
      end,
    }
  elseif plugin == 'gitsigns' then
    return { -- https://github.com/lewis6991/gitsigns.nvim
      'lewis6991/gitsigns.nvim',
      cmd = { 'GitSigns' },
      config = true,
    }
  end
end

return {
  { -- https://github.com/tpope/vim-fugitive
    'tpope/vim-fugitive',
    cmd = {
      'G',
      'GBrowse',
      'GDelete',
      'GMove',
      'GRemove',
      'GRename',
      'GUnlink',
      'GcLog',
      'Gcd',
      'Gdiffsplit',
      'Gdrop',
      'Ge',
      'Ghdiffsplit',
      'Gedit',
      'Ggrep',
      'Git',
      'Gitgrep',
      'GitGrepAdd',
      'GlLog',
      'Glcd',
      'Glgrep',
      'Gllog',
      'Gpedit',
      'Gr',
      'Gread',
    },
  },
  { -- https://github.com/junegunn/gv.vim
    'junegunn/gv.vim',
    cmd = { 'GV' },
  },
  { -- https://github.com/rhysd/git-messenger.vim
    'rhysd/git-messenger.vim',
    cmd = { 'GitMessenger' },
  },
  { -- https://github.com/jreybert/vimagit
    'jreybert/vimagit',
    cmd = { 'Magit' },
  },
  { -- https://github.com/TimUntersberger/neogit
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    config = function()
      require('neogit').setup {
        disable_commit_confirmation = true,
        disable_signs = true,
      }
    end,
  },
  { -- https://github.com/tpope/vim-rhubarb
    'tpope/vim-rhubarb',
    event = { 'VeryLazy' },
  },
  signs('gitsigns'),
}
