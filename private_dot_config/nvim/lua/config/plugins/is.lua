require('astronauta.keymap')

local nmap = vim.keymap.nmap

nmap { 'n', '<Plug>(is-nohl)<Plug>(anzu-n-with-echo)zz' }
nmap { 'N', '<Plug>(is-nohl)<Plug>(anzu-N-with-echo)zz' }
nmap { '*', '<Plug>(asterisk-z*)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)' }
nmap { 'g*', '<Plug>(asterisk-gz*)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)' }
nmap { '#', '<Plug>(asterisk-z#)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)' }
nmap { 'g#', '<Plug>(asterisk-gz#)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)' }
