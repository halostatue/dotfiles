vim9script

if !packix#IsPluginInstalled('Konfekt/vim-unicode-homoglyphs')
  finish
endif

if mapcheck('<Plug>NormalizeHomoglyphs') == ''
  nmap zy <Plug>(NormalizeHomoglyphs)
  xmap zy <Plug>(NormalizeHomoglyphs)
  nmap zu <Plug>(HighlightHomoglyphs)
endif
