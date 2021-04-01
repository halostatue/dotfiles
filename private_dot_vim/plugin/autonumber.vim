""
" autonumber.vim
" - Forked from myusuf3/numbers.vim and b3niup/numbers.vim
"
" Assumes either Neovim or Vim 8+.

if exists('g:autonumber_loaded') && g:autonumber_loaded | finish | endif

let g:autonumber_loaded = v:true

let s:version = '1.0'
lockvar s:version

let g:autonumber_enable = get(g:, 'autonumber_enable', v:true)

let g:autonumber_exclude_filetype = get(g:, 'autonumber_exclude_filetype', [
            \ 'Mundo',
            \ 'MundoDiff',
            \ 'fern',
            \ 'gundo',
            \ 'minibufexpl',
            \ 'nerdtree',
            \ 'startify',
            \ 'tagbar',
            \ 'unite',
            \ 'vimshell',
            \ 'w3m'
            \ ])

let s:save_cpo = &cpo
set cpo&vim

" Commands
command! -nargs=0 AutonumberToggle call autonumber#toggle()
command! -nargs=0 AutonumberEnable call autonumber#enable()
command! -nargs=0 AutonumberDisable call autonumber#disable()
command! -nargs=0 AutonumberOnOff call autonumber#toggleAll()

let &cpo = s:save_cpo

if g:autonumber_enable | call autonumber#enable() | endif
