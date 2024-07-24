vim9script

# Silence `q:` message for the command-line window.
if exists('#vimHints#CmdWinEnter#*')
	autocmd! vimHints
endif

# Note that when the GUI starts, `t_vb` gets reset to `<Esc>|f`, so we use
# this auto command group that does this when the GUI is entered.
augroup hz-reset-bells-no-really
  autocmd!
  autocmd GUIEnter * set t_vb=
augroup END


augroup hz-set-format-options
  autocmd!
  # autocmd BufEnter * formatoptions+=t formatoptions-=2l
  autocmd BufEnter * setlocal formatoptions=crqn2l1j
augroup END

# Auto reload if file was changed somewhere else (for autoread)
augroup hz-checktime
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI,WinEnter * {
    if !bufexists('[Command Line]')
      checktime
    endif
  }
augroup END

# Reset paste mode after leaving insert.
augroup hz-reset-paste-mode
  autocmd!
  autocmd InsertLeave * if &paste | set nopaste mouse=a | endif
augroup END

# Update the diff, if showing a diff, after leaving insert.
augroup hz-update-diff-on-edit
  autocmd!
  autocmd InsertLeave * if &l:diff | diffupdate | endif
augroup END

# Improve the behaviour of the command window a little (q:)
augroup hz-command-window
  autocmd!
  autocmd CmdwinEnter * {
    nnoremap <buffer><silent> q <Cmd>quit<CR>
    nnoremap <buffer><silent> <Tab> <Cmd>quit<CR>
    cursor(line('$'), 0)
    startinsert!
  }
augroup END

# Add the current defined user commands to vim syntax
augroup hz-vimscript-syntax
  autocmd!
  autocmd Syntax vim hz#behaviour#AddVimscriptUserCommandsSyntax()
augroup END

augroup hz-close-help
  autocmd!
  autocmd FileType help silent! nmap <buffer> q <Cmd>close<CR>
augroup END

augroup hz-bufferize
  autocmd!
  autocmd FileType bufferize command! -buffer Rerun exec 'Bufferize ' .. b:bufferize_source_command
augroup END
