vim9script

if !exists(':MundoToggle')
  finish
endif

if mapcheck('<F5>', 'n') ==# ''
  nnoremap <F5> :MundoToggle<CR>
endif
