scriptencoding utf-8

""
" Functions required to work with installable packages. Mostly install functions,
" if required.

function! packages#install_rose_pine(plugin) abort
    let l:colors = a:plugin.dir . '/colors'
    exe '!mkdir -p ' . l:colors
    exe '!cp ' . a:plugin.dir . '/*.vim ' . l:colors
endfunction
