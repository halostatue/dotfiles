local g = vim.g
local xdg_path = vim.fn['hz#xdg_path']
local mkpath = vim.fn['hz#mkpath']

g.startify_session_dir = mkpath(xdg_path('cache', 'session'), true)
g.startify_fortune_use_unicode = 1
g.startify_change_to_dir = 0
g.startify_change_to_vcs_root = 1
g.startify_change_cmd = 'cd'

g.startify_commands = {
  {u = {'Update plugins', 'PackerUpdate'}}, {c = {'Clean plugins', 'PackerClena'}},
  {t = {'Time startup', 'StartupTime'}}, {s = {'Start Prosession', 'Prosession .'}}
}
