vim9script

if !exists(':FuzzyFiles')
  finish
endif

g:files_respect_gitignore = true
g:fuzzy_devicons = false
g:fuzzy_dropdown = true

nnoremap <silent> <leader>zb :FuzzyInBuffer <C-r><C-w><CR>
nnoremap <silent> <leader>zc :FuzzyColors<CR>
nnoremap <silent> <leader>zd :FuzzyHelps<CR>
nnoremap <silent> <leader>zf :FuzzyFiles<CR>
nnoremap <silent> <leader>zi :FuzzyCommands<CR>
nnoremap <silent> <leader>zr :FuzzyGrep <C-r><C-w><CR>
nnoremap <silent> <leader>zt :FuzzyBuffers<CR>
nnoremap <silent> <leader>zh :FuzzyHighlights<CR>
