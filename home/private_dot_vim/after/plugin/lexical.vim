scriptencoding utf-8

command! -bang DownloadThesaurus call s:download_thesaurus('<bang>')

function! s:download_thesaurus(force) abort
  if hz#is#windows()
    let l:path = expand('~/vimfiles/thesaurus/mthesaur.txt')
  else
    let l:path = expand('~/.vim/thesaurus/mthesaur.txt')
  endif
  let l:url = 'https://raw.githubusercontent.com/zeke/moby/master/words.txt'
  let l:download = empty(glob(l:path))
  if a:force ==# '!' | let l:download = 1 | endif

  if l:download
    echo 'Downloading the Moby thesaurus…'
    let l:command = '!curl -fLo ' . l:path . ' --create-dirs ' . l:url
    silent execute l:command
  endif
endfunction
