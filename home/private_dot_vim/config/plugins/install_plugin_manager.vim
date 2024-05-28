scriptencoding utf-8

let s:data_site = hz#xdg_path('data', 'site')

if &packpath !~# s:data_site
  let &packpath = s:data_site . ',' . &packpath
endif

let s:jetpack =
      \ s:data_site . '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'

if has('vim_starting') && !filereadable(s:jetpack)
  let s:jetpackurl =
        \ 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'

  let s:command = printf(
        \   'curl -fsSLo %s --create-dirs %s',
        \   shellescape(s:jetpack),
        \   shellescape(s:jetpackurl)
        \ )

  silent call system(s:command)
endif

function s:jetpack_install()
  for name in jetpack#names()
    if !jetpack#tap(name)
      call jetpack#sync()
      break
    endif
  endfor
endfunction

augroup vim-packager-install
  autocmd!
  autocmd VimEnter * if exists('*jetpack#names') | call <SID>jetpack_install() | endif
augroup END
