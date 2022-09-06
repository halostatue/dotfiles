scriptencoding utf-8

" Load various initialization scripts. All of these should be loaded before
" packages are loaded, except the one below.

try
  packadd chezmoi.vim
catch /^Vim\%((\a\+)\)\=:E919:/
endtry

runtime config/defaults.vim

autocmd User DirenvLoaded normal lh
