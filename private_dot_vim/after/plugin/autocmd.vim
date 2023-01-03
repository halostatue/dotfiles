scriptencoding utf-8

augroup on_all_buffers
  autocmd!

  " Check for updates on window entry
  autocmd WinEnter * checktime

  " Auto reload if file was changed somewhere else (for autoread)
  au CursorHold * checktime

  " Reset paste mode after leaving insert.
  autocmd InsertLeave * if &paste | set nopaste mouse=a | endif

  " Update the diff, if showing a diff, after leaving insert.
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

augroup packager_opt_on_filetypes
  autocmd!
  autocmd FileType javascript packadd vim-js-file-import
  autocmd FileType go packadd vim-go
augroup END

augroup vim_dadbod_completion
  autocmd!
  autocmd FileType sql
        \  if exists('*vim_dadbod_completion#omni')
        \|   setlocal omnifunc=vim_dadbod_completion#omni
        \| endif
augroup END

augroup vimscript_syntax
  autocmd!
  autocmd Syntax vim call hz#_vimscript_user_commands()
augroup END

" if hz#is#plugged('goyo.vim')
"   if hz#is#plugged('limelight.vim')
"     augroup junegunn-goyo-limelight
"       autocmd! User GoyoEnter Limelight
"       autocmd! User GoyoLeave Limelight!
"     augroup END
"   endif
" endif
