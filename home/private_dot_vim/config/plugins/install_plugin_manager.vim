vim9script

const vim_site = hz#mk_xdg_vim_path('data', 'site')

if &packpath !~# vim_site
    &packpath = vim_site .. ',' .. &packpath
endif

const pack_root = vim_site .. '/pack/packix/opt'

mkdir(pack_root, 'p')

const packix_path = pack_root .. '/vim-packix'
const packix_url = "https://github.com/halostatue/vim-packix.git"

if has('vim_starting') && !isdirectory(packix_path .. '/.git')
  const command = printf('silent !git clone %s %s', packix_url, packix_path)

  silent execute command

  augroup install-vim-packix
    autocmd!
    autocmd VimEnter * if exists(':PackixInstall') == 2 | PackixInstall | endif
  augroup END
endif
