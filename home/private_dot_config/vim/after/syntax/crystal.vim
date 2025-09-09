vim9script

if exists('*lexiv#paren_open')
  inoremap <buffer> <expr> {% lexiv#paren_open('{%')
  inoremap <buffer> <expr> %} lexiv#paren_close('%}')
endif
