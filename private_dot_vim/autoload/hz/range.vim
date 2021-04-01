scriptencoding utf-8

""
" Loop over the range of text and remove duplicate lines without changing the
" sort order. Originally by Damian Conway, presented in Scripting the Vim
" Editor, Part 4 at IBM developerWorks.
"
" https://www.ibm.com/developerworks/library/l-vim-script-4/index.html
"
" Add mappings:
"
"     nmap ;u :%call hz#range#uniq()<CR>
"
"     vmap u :call hz#range#uniq()<CR>
function! hz#range#uniq() range abort
  let l:seen = {}
  let l:uniq = []

  for l:line in getline(a:firstline, a:lastline)
    let l:normalized = '>' . l:line
    if !has_key(l:seen, l:normalized)
      call add(l:uniq, l:line)
      let l:seen[l:normalized] = 1
    endif
  endfor

  execute a:firstline . ',' . a:lastline . 'delete'
  call append(a:firstline - 1, l:uniq)
endfunction


