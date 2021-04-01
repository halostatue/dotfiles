scriptencoding utf-8

if mapcheck('<C-F>.', 'n') ==# ''
  nmap <C-F>. :Fern . -drawer -reveal=%<CR>
  nmap <C-F>, :Fern . -drawer -stay -reveal=%<CR>
  nmap <C-F>b :Fern bookmark:/// -drawer<CR>
endif

" function! s:init_fern() abort
"   # NOP for now
" endfunction

" augroup fern-startup
"   autocmd!
"   autocmd FileType fern call s:init_fern()
" augroup END
