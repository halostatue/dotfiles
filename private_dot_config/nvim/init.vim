set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if filereadable(expand("~/.vimrc"))
  source ~/.vimrc
elseif filereadable(expand("~/.vim/vimrc"))
  source ~/.vim/vimrc
endif
