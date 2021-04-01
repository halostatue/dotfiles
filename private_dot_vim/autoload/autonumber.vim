scriptencoding utf-8

""
" autonumber.vim
" - Forked from myusuf3/numbers.vim and b3niup/numbers.vim and auwsmit/vim-active-numbers
"
" Assumes either Neovim or Vim 8+.

function! autonumber#off() abort
    setlocal norelativenumber number
endfunction

function! autonumber#relative() abort
    let w:autonumber_mode = 0
    call autonumber#reset()
endfunction

function! autonumber#numbers() abort
    let w:autonumber_mode = 1
    call autonumber#reset()
endfunction

function! autonumber#hidden() abort
    let w:autonumber_mode = 2
    call autonumber#reset()
endfunction

function! autonumber#toggle() abort
    if w:autonumber_mode == 1
        let w:autonumber_lock = v:true
        call autonumber#hidden()
    elseif w:autonumber_mode == 2
        let w:autonumber_lock = v:false
        call autonumber#relative()
    elseif w:autonumber_mode == 0
        let w:autonumber_lock = v:false
        call autonumber#numbers()
    endif
endfunction

function! autonumber#reset() abort
    let w:autonumber_mode = get(w:, 'autonumber_mode', 0)
    let w:autonumber_lock = get(w:, 'autonumber_lock', v:false)

    if w:autonumber_lock | return | endif

    if w:autonumber_mode == 0
        setlocal relativenumber number
    elseif w:autonumber_mode == 1
        call autonumber#off()
        setlocal number
    elseif w:autonumber_mode == 2
        call autonumber#off()
        setlocal nonumber
    endif

    if index(g:autonumber_exclude_filetype, &ft) >= 0
        setlocal norelativenumber nonumber
    endif
endfunction

function! autonumber#enable() abort
    let g:autonumber_enable = v:true
    let w:autonumber_lock = v:false
    call autonumber#relative()

    augroup autonumber_enable
        autocmd!
        autocmd InsertEnter,WinLeave * :call autonumber#numbers()
        autocmd InsertLeave,VimEnter,WinEnter * :call autonumber#relative()
        autocmd BufNewFile,BufReadPost,FileType * :call autonumber#reset()
    augroup END
endfunction

function! autonumber#disable() abort
    call autonumber#hidden()
    let w:autonumber_lock = v:true
    let g:autonumber_enable = v:false
    autocmd! autonumber_enable
endfunction

function! autonumber#toggleAll() abort
    if get(g:, 'autonumber_enable', v:false) == 1
        call autonumber#disable()
    else
        call autonumber#enable()
    endif
endfunction
