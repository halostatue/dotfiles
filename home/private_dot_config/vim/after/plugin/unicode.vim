vim9script

if mapcheck('<Plug>(UnicodeGA)') ==# ''
  finish
endif

nmap ga <Plug>(UnicodeGA)
