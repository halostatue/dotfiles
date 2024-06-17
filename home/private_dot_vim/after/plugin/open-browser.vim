vim9script

if !exists('*openbrowser#_keymap_smart_search')
  finish
endif

g:openbrowser_default_search = 'duckduckgo'
g:openbrowser_no_default_menus = v:true
g:openbrowser_message_verbosity = 1

if mapcheck('<Plug>(openbrowser-smart-search)') == ''
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif
