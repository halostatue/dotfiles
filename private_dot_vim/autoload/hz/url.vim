scriptencoding utf-8

""
" Encodes non-urlsafe values in {url} with percent hex-encoding (e.g., ' '
" becomes '%20'. Only the path and query parameters are encoded.
"
" Improves on a version ripped from haskellmode.vim by Andrew Radev (which
" encoded the entire URL).
function! hz#url#encode(url) abort
  let l:parts = split(a:url, '/', v:true)
  let l:index = l:parts[0] =~# '^https\=' ? 3 : 1
  let l:parts[l:index : ] =
        \ map(
        \   l:parts[l:index :],
        \   { _i, part ->
        \     substitute(
        \       part,
        \       '\([^-[:alnum:].=?&]\)',
        \       { m -> printf('%%%02X', char2nr(m[1])) },
        \       'g')
        \   })

  return join(l:parts, '/')
endfunction

""
" Decodes an encoded {url} back to plain-text.
"
" Based on a version ripped from unimpaired.vim by Andrew Radev.
function! hz#url#decode(url) abort
  let l:url = substitute(a:url, '%0[Aa]\n$', '%0A', '')
  let l:url = substitute(l:url, '%0[Aa]', '\n', 'g')
  let l:url = substitute(l:url, '+', ' ', 'g')
  return substitute(l:url, '%\(\x\x\)', { m -> nr2char('0x' . m[1]) }, 'g')
endfunction
