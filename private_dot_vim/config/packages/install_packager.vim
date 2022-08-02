scriptencoding utf-8

let s:dir = hz#xdg_path('data', 'site')
call hz#mkpath(s:dir, true)

if &packpath !~# s:dir
  let &packpath = s:dir . ',' . &packpath
endif

let s:dir = s:dir . '/pack/packager/opt/vim-packager'

if has('vim_starting') && !isdirectory(s:dir . '/.git')
  echo "Installing vim-packager.\n"

  execute join([
    \ 'silent !git clone https://github.com/kristijanhusak/vim-packager.git',
    \ s:dir
    \ ])

  augroup vim-packager-install
    autocmd!
    autocmd VimEnter * if exists(':PackagerInstall') | PackagerInstall | endif
  augroup END
endif
