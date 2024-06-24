vim9script

const URL = 'https://raw.githubusercontent.com/zeke/moby/master/words.txt'

const TARGET = exists('g:thesaurus_path')
  ? g:thesaurus_path .. '/mthesaur.txt'
  : hz#is('windows')
  ? expand('~/vimfiles/thesaurus/mthesaur.txt')
  : expand('~/.vim/thesaurus/mthesaur.txt')

def DownloadThesaurus(bang: string)
  if bang ==# '!' || empty(glob(TARGET))
    echo 'Downloading the Moby thesaurus…'
    silent execute printf('!curl -fsSLo %s --create-dirs %s', TARGET, URL)
  endif
enddef

command! -bang DownloadThesaurus call <ScriptCmd>DownloadThesaurus('<bang>')
