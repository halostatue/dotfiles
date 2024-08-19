vim9script

if !packix#IsPluginInstalled('t9md/vim-choosewin')
  finish
endif

nmap <C-W><S-C> <Plug>(choosewin)
