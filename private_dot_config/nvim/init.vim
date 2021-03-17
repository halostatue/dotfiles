set runtimepath^=~/.vim runtimepath+=~/.vim/after

if filereadable(expand("~/.vimrc"))
  source ~/.vimrc
elseif filereadable(expand("~/.vim/vimrc"))
  source ~/.vim/vimrc
endif
