scriptencoding utf-8

" packadd goyo.vim
" packadd limelight.vim

" Distraction-free writing mode
let g:pencil#textwidth = 80
let g:goyo_width = 80
let g:vim_markdown_frontmatter = 1

" Enable spellchecking for Markdown
setlocal nolist
setlocal spell
setlocal foldlevel=999
setlocal nocindent
setlocal textwidth=80
setlocal colorcolumn=+1

" If the buffer is in the wiki
if(expand('%:p:h')=~"vimwiki")
  nmap <buffer> <CR> <Plug>VimwikiFollowLink
  nmap <buffer> <Backspace> <Plug>VimwikiGoBackLink
else
  " Basically unmap it
  nmap <buffer> <F14> <Plug>VimwikiFollowLink
  nmap <buffer> <F15> <Plug>VimwikiGoBackLink
endif

" Distraction-free writing mode
function! s:goyo_enter()
  " light theme
  setlocal background=light
  colorscheme onehalflight

  " turn off cursor-line-highlight auto-indent, whitespace, and in-progress
  " commands
  setlocal noai nolist noshowcmd nocursorline

  " turn on autocorrect
  setlocal spell complete+=s

  Limelight  " Focus on the current paragraph, dim the others
  SoftPencil " Turn on soft breaks
  Wordy weak " Highlight weak words
endfunction

function! s:goyo_leave()
  setlocal cursorline
  setlocal showcmd list ai
  setlocal nospell complete-=s
  setlocal background=dark
  Limelight!
  NoPencil
  NoWordy
  colorscheme monokai-phoenix
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" nmap <leader>df :Goyo<CR>
