vim9script

if !hz#is('mac') 
  finish 
endif

# Almost everything that applies to Unix configs applies here, too.
runtime config/defaults/unix.vim

# # Get the value of $PATH from a login shell if MacVim.app was started from the
# # Finder.
# if has('gui_macvim') && has('gui_running')
#   # ps -xc: just the command, not the command-line; including non-terminal
#   #         processes
#   # grep -wsc: suppress errors; word boundary; count of matches.
#   if system('ps -xc | grep -wsc Vim') > 1
#     # If your shell is not on this list, it may be just because we have not
#     # tested it.  Try adding it to the list and see if it works. If so, please
#     # post a note to the vim-mac list!
#     if $SHELL =~# '/\(sh\|csh\|bash\|tcsh\|zsh\)$'
#       let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
#       let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')
#       unlet s:path
#     elseif $SHELL =~# '/\(fish\)$'
#       let s:path = system("echo echo '$PATH' | $SHELL -l")
#       let $PATH = s:path
#       unlet s:path
#     endif
#   endif
#
#   # MacVIM shift+arrow-keys behavior (required in .vimrc)
#   # let g:macvim_hig_shift_movement=1
# endif

# Free up ⌘-P
if exists(':unmenu') > 0
  unmenu File.Print
endif
