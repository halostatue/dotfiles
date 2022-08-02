scriptencoding utf-8

" Load various initialization scripts. All of these should be loaded before
" packages are loaded, except the one below.

let s:dir = hz#xdg_path('data', 'site')
call hz#mkpath(s:dir, true)

if &packpath !~# s:dir
  let &packpath = s:dir . ',' . &packpath
endif

let s:dir = s:dir . '/pack/packager/opt/chezmoi.vim'

if has('vim_starting') && !isdirectory(s:dir . './git')
  execute join([
    \ 'silent !git clone https://github.com/alker0/chezmoi.vim',
    \ s:dir
    \ ])
endif

try
  packadd chezmoi.vim
catch /^Vim\%((\a\+)\)\=:E919:/
endtry

runtime config/defaults.vim

autocmd User DirenvLoaded normal lh
