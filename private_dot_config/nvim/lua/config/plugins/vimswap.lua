require('astronauta.keymap')

local nmap = vim.keymap.nmap
local omap = vim.keymap.omap
local xmap = vim.keymap.xmap

nmap { 'g(', '<Plug>(swap-interactive)' }
xmap { 'g(', '<Plug>(swap-interactive)' }
nmap { 'g<', '<Plug>(swap-prev)' }
nmap { 'g>', '<Plug>(swap-next)' }
omap { 'i,', '<Plug>(swap-textobject-i)' }
xmap { 'i,', '<Plug>(swap-textobject-i)' }
omap { 'a,', '<Plug>(swap-textobject-a)' }
xmap { 'a,', '<Plug>(swap-textobject-a)' }
