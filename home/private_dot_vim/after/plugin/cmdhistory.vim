vim9script

if !packix#IsPluginInstalled('mityu/vim-cmdhistory')
  finish
endif

cnoremap <C-o> <Cmd>call cmdhistory#Select()<CR>

augroup setup-cmdhistory-plugin-for-cmdwin
  autocmd!

  autocmd CmdWinEnter * nnoremap <buffer> / <Cmd>call cmdhistory#Select()<CR>
  autocmd User cmdhistory-initialize cmdhistory#SetDefaultMappings()
augroup END
