vim9script

if get(g:, 'hz_config_key_mappings_loaded')
  finish
endif

g:hz_config_key_mappings_loaded = true

## 1. Use keymappings defined in tpope/vim-sensible or sheerun/vimrc.

# Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and call
# :diffupdate.
if maparg('<C-L>', 'n')->empty()
  nnoremap <silent> <C-l> <Cmd>nohlsearch<Bar><Cmd>diffupdate<CR><C-l>
endif

# Close the current undo sequence and start a new undo sequence before
# deleting the word before the cursor (C-w) or clearing all characters to the
# beginning of the line (C-u).
if empty(mapcheck('<C-u>', 'i'))
  inoremap <C-u> <C-g>u<C-u>
endif

if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-w> <C-g>u<C-w>
endif

# Visually select the text that was last edited or pasted.
noremap gV `[v`]

# Expand %% to the path of the current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') .. '/' : '%%'

# Prevent Q from dropping us into Ex mode.
map Q <Nop>

# Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

# Keep flags when repeating last substitute command.
nnoremap & <Cmd>&&<CR>
xnoremap & <Cmd>&&<CR>

# Reselect the previously selected visual area on shift left or right.
xnoremap > >gv
xnoremap < <gv

# Rotate the view position to the top, centre, or bottom of the window.
noremap <expr> gzz (winline() == (winheight(0) + 1) / 2)
      \ ? 'zt'
      \ : (winline() < (&scrolloff + 2))
      \ ? 'zb'
      \ : 'zz'

# Center the viewport when jumping around.
nnoremap g; g;zz
nnoremap g, g,zz

# Make CTRL-^ rebound to the line and column in the alternate file.
noremap <C-^> <C-^>`"

# Allow for easy copying and pasting
vnoremap <silent> y y`]
nnoremap <silent> p p`]

# Show more information under <C-G>.
noremap <C-G> 2<C-G>

# Duplicate the current selection.
xnoremap <leader>D y'>p

## 2. Define useful global mappings

# Make it easy to get into the command-line editor buffer with ';;' by making
# some plug-style private mappings.
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-U>

# Next, use these private mappings. This makes it harder to override.
nmap ;; <SID>(command-line-enter)
xmap ;; <SID>(command-line-enter)

# Default to strict linewise vertical motion. (j -> gj, k -> gk, etc.)
hz#behaviour#JkLinewise(hz#behaviour#JK_STRICT)

# Toggle between j -> gj (etc.) and normal behaviour.
nmap <leader>gj <Cmd>hz#bheaviour#JkLinewise()<CR>

# Configure kennypete/vim-tene toggles.
map <Leader>T% <Plug>Tene%
map <Leader>Tb <Plug>TeneB
map <Leader>Tc <Plug>TeneC
map <Leader>Tf <Plug>TeneF
map <Leader>Tg <Plug>TeneG
map <Leader>Th <Plug>TeneH
map <Leader>Tk <Plug>TeneK
map <Leader>Tl <Plug>TeneL
map <Leader>Tm <Plug>TeneM
map <Leader>Tp <Plug>TeneP
map <Leader>Ts <Plug>TeneS
map <Leader>Tu <Plug>TeneU
map <Leader>Tv <Plug>TeneV
map <Leader>Tw <Plug>TeneW
map <Leader>Tz <Plug>TeneZ

# t9md/vim-choosewin
nmap <C-W><S-C> <Plug>(choosewin)

# Move deferred processing into packix
import 'deferred.vim'

# deferred.Define('CheckHealth', 'vim-healthcheck')
deferred.Define('Vitalize', 'vital.vim')


if mapcheck('<Plug>NormalizeHomoglyphs') == ''
  nmap zy <Plug>(NormalizeHomoglyphs)
  xmap zy <Plug>(NormalizeHomoglyphs)
  nmap zu <Plug>(HighlightHomoglyphs)
endif

# Make sure pasting in visual mode doesn't replace paste buffer
vnoremap <silent> <expr> p hz#VisualPaste()
