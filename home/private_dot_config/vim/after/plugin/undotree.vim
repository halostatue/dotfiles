vim9script

if !exists(':UndotreeToggle')
  finish
endif

if mapcheck('F5', 'n') ==# ''
  nnoremap <F5> :UndotreeToggle<CR>
endif
