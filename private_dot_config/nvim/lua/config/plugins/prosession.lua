local g = vim.g
local xdg_path = vim.fn['hz#xdg_path']

g.prosession_tmux_title = 1
g.prosession_on_startup = 0
g.prosession_dir = xdg_path('cache', 'sessions')
