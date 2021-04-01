scriptencoding utf-8

" Core defaults that only apply to VIM and not Neovim.
if has('nvim') | finish | endif

if has('autocmd') | filetype plugin indent on | endif
if has('syntax') && !exists('g:syntax_on') | syntax enable | endif

set viminfo^=!
set fillchars+=vert:\│,fold:\·,foldsep:\│

if !exists('g:loaded_config_defaults_vim') | let g:loaded_config_defaults_vim = 1 | endif
