vim9script

if !exists(':OpenBrowser')
  finish
endif

g:openbrowser_default_search = 'duckduckgo'
g:openbrowser_no_default_menus = true
g:openbrowser_message_verbosity = 1

if mapcheck('<Plug>(openbrowser-smart-search)') !=# ''
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif
