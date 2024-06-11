vim9script
scriptencoding utf-8

const data_site = hz#xdg_path('data', 'site')
hz#mkpath(data_site, v:true)

if &packpath !~# data_site
  &packpath = data_site .. ',' .. &packpath
endif

const packager = data_site .. '/pack/packager/opt/vim-packager'

if has('vim_starting') && !isdirectory(packager .. '/.git')
  const command = join([
    'silent !git clone https://github.com/kristijanhusak/vim-packager.git',
    packager
  ], ' ')

  silent execute command

  augroup vim-packager-install
    autocmd!

    autocmd VimEnter * if exists(':PackagerInstall') == 2 | PackagerInstall | endif
  augroup END
endif
