scriptencoding utf-8

augroup on_all_buffers
  autocmd!

  " Check for updates on window entry or if the file was changed somewhere else
  autocmd WinEnter * checktime
  autocmd CursorHold * checktime

  " Reset paste mode after leaving insert.
  autocmd InsertLeave * if &paste | set nopaste mouse=a | endif

  " Update the diff, if showing a diff, after leaving insert.
  autocmd InsertLeave * if &l:diff | diffupdate | endif

  autocmd TextYankPost * silent! lua vim.highlight.on_yank { 'higroup' : 'IncSearch' }
augroup END

augroup on_cmdwin
  autocmd!

  autocmd CmdwinEnter *
        \   nnoremap <buffer><silent> q :<C-u>quit<Return>
        \ | nnoremap <buffer><silent> <Tab> :<c-u>quit<Return>
        \ | call cursor(line('$'), 0)
        \ | startinsert!
augroup END

augroup vim_dadbod_completion
  autocmd!

  autocmd FileType sql
        \   if exists('*vim_dadbod_completion#omni')
        \ |   setlocal omnifunc=vim_dadbod_completion#omni
        \ | endif
augroup END

augroup vimscript_syntax
  autocmd!
  autocmd FileType vim call hz#_vimscript_user_commands()
augroup END
