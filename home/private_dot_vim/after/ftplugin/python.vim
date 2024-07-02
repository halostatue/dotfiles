vim9script

if exists(':Scope')
  import autoload 'scope/popup.vim'

  def Things()
    var things = []

    for nr in range(1, line('$'))
      var line = getline(nr)

      if line =~ '\(^\|\s\)\(def\|class\) \k\+(' || line =~ 'if __name__ == "__main__":'
        things->add({ text: $"{line} ({nr})", linenr: nr })
      endif
    endfor

    popup.FilterMenu.new("Py Things", things,
      (res, key) => {
        exe $":{res.linenr}"
        normal! zz
      },
      (winid, _) => {
        win_execute(winid, "syn match FilterMenuLineNr '(\\d\\+)$'")
        hi def link FilterMenuLineNr Comment
      })
  enddef

  nnoremap <buffer> <leader>tp <scriptcmd>Things()<CR>
endif
