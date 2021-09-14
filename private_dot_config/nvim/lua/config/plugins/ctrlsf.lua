local inoremap = vim.keymap.inoremap
local nmap = vim.keymap.nmap
local nnoremap = vim.keymap.nnoremap
local vmap = vim.keymap.vmap

nmap { '<C-F>f', '<Plug>CtrlSFPrompt' }
vmap { '<C-F>f', '<Plug>CtrlSFVwordPath' }
vmap { '<C-F>F', '<Plug>CtrlSFVwordExec' }
nmap { '<C-F>n', '<Plug>CtrlSFCwordPath' }
nmap { '<C-F>p', '<Plug>CtrlSFPwordPath' }
nnoremap { '<C-F>o', ':CtrlSFOpen<CR>' }
nnoremap { '<C-F>t', ':CtrlSFToggle<CR>' }
inoremap { '<C-F>t', '<Esc>:CtrlSFToggle<CR>' }
