vim9script

if !packix#IsPluginInstalled('AndrewRadev/sideways.vim')
  finish
endif

nnoremap <c-h> <Cmd>SidewaysLeft<CR>
nnoremap <c-j> <Cmd>SidewaysRight<CR>
