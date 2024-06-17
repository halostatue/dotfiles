vim9script

const TARGET = hz#is('windows') ?
  expand('~/vimfiles/thesaurus/mthesaur.txt') :
  expand('~/.vim/thesaurus/mthesaur.txt')

const URL = 'https://raw.githubusercontent.com/zeke/moby/master/words.txt'

def DownloadThesaurus(bang: string)
  if bang ==# '!' || empty(glob(TARGET))
    echo 'Downloading the Moby thesaurus…'
    silent execute printf('!curl -fsSLo %s --create-dirs %s', TARGET, URL)
  endif
enddef

command! -bang DownloadThesaurus call <ScriptCmd>DownloadThesaurus('<bang>')
