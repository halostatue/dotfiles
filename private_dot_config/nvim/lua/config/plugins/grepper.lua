require('astronauta.keymap')

local nnoremap = vim.keymap.nnoremap
local nmap = vim.keymap.nmap
local xmap = vim.keymap.xmap

nnoremap { '<leader>G', ':Grepper<CR>' }
nmap { 'gG', '<Plug>(GrepperOperator)' }
xmap { 'gG', '<Plug>(GrepperOperator)' }
