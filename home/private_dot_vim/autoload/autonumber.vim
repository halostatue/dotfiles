vim9script

# autonumber.vim
#
# Automatically switch between 'number' and 'relativenumber' contextually.
#
# Derived from:
#
# - https://github.com/myusuf3/numbers.vim
# - https://github.com/b3niup/numbers.vim
# - https://github.com/auwsmit/vim-active-numbers

const MODE_RELATIVE = 0
const MODE_ABSOLUTE = 1
const MODE_HIDDEN = 2

def Reset()
  if w:->get('autonumber_ignore', false)
    return
  endif

  w:autonumber_mode = w:->get('autonumber_mode', MODE_RELATIVE)
  w:autonumber_lock = w:->get('autonumber_lock', false)

  if w:autonumber_lock
    return
  endif

  if index(g:autonumber_exclude_filetype, &ft) >= 0
    w:autonumber_mode = MODE_HIDDEN
  endif

  if w:autonumber_mode == MODE_RELATIVE
    setlocal relativenumber number
  elseif w:autonumber_mode == MODE_ABSOLUTE
    Off()
    setlocal number
  elseif w:autonumber_mode == MODE_HIDDEN
    Off()
    setlocal nonumber
  endif
enddef

def Off()
  setlocal norelativenumber number
enddef

def Relative()
  if w:->get('autonumber_ignore', false)
    return
  endif

  w:autonumber_mode = MODE_RELATIVE
  Reset()
enddef

def Absolute()
  if w:->get('autonumber_ignore', false)
    return
  endif

  w:autonumber_mode = MODE_ABSOLUTE
  Reset()
enddef

def Hidden()
  w:autonumber_mode = MODE_HIDDEN
  Reset()
enddef

export def Toggle()
  if w:->get('autonumber_ignore', false)
    return
  endif

  if w:autonumber_mode == MODE_ABSOLUTE
    w:autonumber_lock = true
    Hidden()
  elseif w:autonumber_mode == MODE_HIDDEN
    w:autonumber_lock = false
    Relative()
  elseif w:autonumber_mode == MODE_RELATIVE
    w:autonumber_lock = false
    Absolute()
  endif
enddef

export def Enable()
  g:autonumber_enable = true
  w:autonumber_lock = false
  Relative()

  augroup autonumber_enable
    autocmd!
    autocmd InsertEnter,WinLeave * :call Absolute()
    autocmd BufEnter,InsertLeave,VimEnter,WinEnter * :call Relative()
    autocmd BufNewFile,BufReadPost,FileType * :call Reset()
  augroup END
enddef

export def Disable()
  Hidden()
  w:autonumber_lock = true
  g:autonumber_enable = false
  autocmd! autonumber_enable
enddef

export def TogglePlugin()
  if g:->get('autonumber_enable', false)
    Disable()
  else
    Enable()
  endif
enddef

export def IgnoreWindow(bang: string)
  if bang == '!'
    w:autonumber_ignore = true
  else
    w:autonumber_ignore = false

    Reset()
  endif
enddef
