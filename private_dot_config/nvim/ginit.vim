scriptencoding utf-8

" let &guifont="CascadiaCode-Light:h10"
let &guifont="FiraCode-Retina:h10"

if has('gui_win32')
  noremap <A-Space> :simalt ~<CR>
  inoremap <A-Space> <C-O>:simalt ~<CR>
  cnoremap <A-Space> <C-C><A-Space>
endif

" Keep the system clipboard and the vim pasteboard separate. If this behaviour is not desired, uncomment the if
" statement below.
set clipboard&
" if has('unnamedplus')
"   set clipboard^=unnamedplus
" else
"   set clipboard^=unnamed
" endif

if has('gui_macvim')
  set antialias
  set guioptions-=T
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=b
  set guioptions-=h

  set fuoptions=maxvert,maxhorz
  set macligatures

  if get(g:, 'transparency') && has('transparency')
    set transparency=5 blurradius=25
  endif

  nmap <D-/> gcc
  xmap <D-/> gc
endif

function! OnRight()
  set lines=57 columns=106
  winpos 641 25
endfunction

function! OnLeft()
  set lines=57 columns=106
  winpos 0 25
endfunction

function! FullWidth()
  set lines=57 columns=213
  winpos 0 25
endfunction

set nomousefocus mousehide
set winaltkeys=no
