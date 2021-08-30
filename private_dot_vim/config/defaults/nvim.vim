scriptencoding utf-8

" Core defaults that only apply to Neovim and not VIM.
if !has('nvim') | finish | endif

if has('nvim-0.5')
  set fillchars=vert:\│,fold:\·,foldsep:\│
else
  set fillchars=vert:\│,fold:\·
endif

set shada^=!

if !exists('g:loaded_config_defaults_nvim') | let g:loaded_config_defaults_nvim = 1 | endif
