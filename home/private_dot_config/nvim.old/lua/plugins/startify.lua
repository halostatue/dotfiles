return {
  { -- https://github.com/mhinz/vim-startify
    'mhinz/vim-startify',
    lazy = false,
    config = function()
      local xdg_path = vim.fn['hz#xdg_path']
      local mkpath = vim.fn['hz#mkpath']

      vim.g.startify_session_dir = mkpath(xdg_path('cache', 'session'), true)
      vim.g.startify_fortune_use_unicode = 1
      vim.g.startify_change_to_dir = 0
      vim.g.startify_change_to_vcs_root = 1
      vim.g.startify_change_cmd = 'cd'

      vim.g.startify_commands = {
        -- {u = {'Update plugins', 'PackerUpdate'}}, {c = {'Clean plugins', 'PackerClean'}},
        { t = { 'Time startup', 'StartupTime' } },
        { s = { 'Start Prosession', 'Prosession .' } },
      }
    end,
  },
}
