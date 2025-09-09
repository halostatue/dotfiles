vim9script

if !packix#IsPluginInstalled('Donaldttt/fuzzyy')
  finish
endif

g:files_respect_gitignore = true
g:fuzzy_devicons = false
g:fuzzy_dropdown = true

nnoremap <silent> <leader>tb :FuzzyInBuffer<CR>
nnoremap <silent> <leader>tc :FuzzyColors<CR>
nnoremap <silent> <leader>td :FuzzyHelps<CR>
nnoremap <silent> <leader>tf :FuzzyFiles<CR>
nnoremap <silent> <leader>th :FuzzyHighlights<CR>
nnoremap <silent> <leader>ti :FuzzyCommands<CR>
nnoremap <silent> <leader>tr :FuzzyGrep<CR>
nnoremap <silent> <leader>tt :FuzzyBuffers<CR>

if g:->get('enable_fuzzyy_MRU_files')
  nnoremap <silent> <leader>tm :FuzzyMRUFiles<CR>
endif
