vim9script

if !exists(':Scope')
  finish
endif

import autoload 'scope/fuzzy.vim'
import autoload 'scope/popup.vim'

popup.OptionsSet({ maxheight: 30, maxwidth: 75, emacsKeys: true })

nnoremap <leader>tf <ScriptCmd>fuzzy.File('fd -tf --follow')<CR>
nnoremap <leader>tF <ScriptCmd>fuzzy.GitFile()<CR>
nnoremap <leader>tg <ScriptCmd>fuzzy.Grep('rg --vimgrep --smart-case')<CR>
nnoremap <leader>tG <ScriptCmd>fuzzy.Grep('rg --vimgrep --smart-case', true, '<cword>')<CR>
nnoremap <leader>tb <ScriptCmd>fuzzy.Buffer()<CR>
nnoremap <leader>ts <ScriptCmd>fuzzy.BufSearch()<CR>

nnoremap <leader>tc <ScriptCmd>fuzzy.Colorscheme()<CR>
nnoremap <leader>tw <ScriptCmd>fuzzy.Window()<CR>
nnoremap <leader>th <ScriptCmd>fuzzy.Help()<CR>
nnoremap <leader>tt <ScriptCmd>fuzzy.Filetype()<CR>
nnoremap <leader>tj <ScriptCmd>fuzzy.Jumplist()<CR>

augroup scope-quickfix-history
  autocmd!

  autocmd QuickFixCmdPost chistory cwindow
  autocmd QuickFixCmdPost lhistory lwindow
augroup END

defcompile
