vim9script

if !packix#IsPluginInstalled('junegunn/goyo.vim')
  finish
endif

def Maybe(command: string)
  var name = command->substitute('^:', '', '', '')->substitute('!\=\s*.+$', '')

  if exists(':' .. name)
    exec command
  endif
enddef

def EnterGoyo()
  w:goyo_saved_settings = [
    &autoindent, &list, &showcmd, &cursorline, &spell, &complete, &background,
    g:colors_name
  ]

  if hz#behaviour#Colors()->index('onehalflight') >= 0
    set background=light
    colorscheme 'onehalflight'
  endif

  setlocal noautoindent nolist noshowcmd nocursorline spell complete+=s

  Maybe('Limelight')  # Focus on the current paragraph, dim the others
  Maybe('SoftPencil') # Turn on soft breaks
  Maybe('Wordy weak') # Highlight weak words
enddef

def LeaveGoyo()
  if !get(w:, 'goyo_saved_settings', [])->empty()
    [
      &l:autoindent, &l:list, &l:showcmd, &l:cursorline, &l:spell, &l:complete,
      &l:background, g:colors_name
    ] = w:goyo_saved_settings
  endif

  Maybe('Limelight!')
  Maybe('NoPencil')
  Maybe('NoWordy')
enddef

augroup goyo-activity
  autocmd!

  autocmd! User GoyoEnter ++nested EnterGoyo()
  autocmd! User GoyoLeave ++nested LeaveGoyo()
augroup END

if mapcheck('<Leader>df', 'n') ==# ''
  nmap <Leader>df <Cmd>Goyo<CR>
endif
