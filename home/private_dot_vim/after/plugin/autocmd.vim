vim9script

augroup on_all_buffers
  autocmd!

  # Check for updates on window entry
  autocmd WinEnter * checktime

  # Auto reload if file was changed somewhere else (for autoread)
  au CursorHold * checktime

  # Reset paste mode after leaving insert.
  autocmd InsertLeave * if &paste | set nopaste mouse=a | endif

  # Update the diff, if showing a diff, after leaving insert.
  autocmd InsertLeave * if &l:diff | diffupdate | endif
augroup END

augroup on_cmdwin
  autocmd!

  autocmd CmdwinEnter *
        \  nnoremap <buffer><silent> q :<C-u>quit<Return>
        \| nnoremap <buffer><silent> <Tab> :<c-u>quit<Return>
        \| call cursor(line('$'), 0)
        \| startinsert!
augroup END

augroup vimscript_syntax
  autocmd!
  autocmd Syntax vim call hz#_vimscript_user_commands()
augroup END
