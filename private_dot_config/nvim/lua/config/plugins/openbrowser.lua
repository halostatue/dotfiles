local g = vim.g
local nmap = vim.keymap.nmap
local vmap = vim.keymap.vmap

g.openbrowser_default_search = 'duckduckgo'
g.openbrowser_no_default_menus = true
g.openbrowser_message_verbosity = 1

nmap { 'gx', '<Plug>(openbrowser-smart-search)' }
vmap { 'gx', '<Plug>(openbrowser-smart-search)' }
