vim9script

if !exists(':Bufferize')
  finish
endif

augroup bufferize-setup
  autocmd!
  autocmd FileType bufferize command! -buffer Rerun exe 'Bufferize ' .. b:bufferize_source_command
augroup END
