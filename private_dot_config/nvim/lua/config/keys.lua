-- vim.cmd [[
-- \" Switch to strict linewise vertical motion.
-- call hz#_toggle_jk_mapping('alt')

-- \" Visually select the text that was last edited or pasted.
-- noremap gV `[v`]

-- \" Expand %% to the path of the current buffer in command mode.
-- cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

-- \" Make sure pasting in visual mode doesn't replace paste buffer
-- vnoremap <silent> <expr> p hz#_replace_paste_buffer()

-- inoremap <C-u> <C-g>u<C-u>
-- inoremap <C-w> <C-g>u<C-w>

-- map Q <Nop>
-- nnoremap Y y$

-- xnoremap > >gv
-- xnoremap < <gv

-- \" Move the view to the top/centre/bottom
-- noremap <expr> gzz (winline() == (winheight(0) + 1) / 2)
--       \ ? 'zt'
--       \ : (winline() == 1)
--       \ ? 'zb'
--       \ : 'zz'

-- \" Center the viewport when jumping around.
-- nnoremap g; g;zz
-- nnoremap g, g,zz

-- \" Make CTRL-^ rebound to the line and column in the alternate file.
-- noremap <C-^> <C-^>`"

-- \" Show more information under <C-G>.
-- noremap <C-G> 2<C-G>

-- \" Duplicate the current selection.
-- xnoremap <leader>D y'>p

-- \" Make it easy to get into the command-line editor buffer with ';;' by making
-- \" some plug-style private mappings.
-- nnoremap <SID>(command-line-enter) q:
-- xnoremap <SID>(command-line-enter) q:
-- nnoremap <SID>(command-line-norange) q:<C-U>

-- \" Next, use these private mappings. This makes it harder to override.
-- nmap ;; <SID>(command-line-enter)
-- xmap ;; <SID>(command-line-enter)

-- nmap <leader>gj :ToggleGJK<CR>
-- ]]
