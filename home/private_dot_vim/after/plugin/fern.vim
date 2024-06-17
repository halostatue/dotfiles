vim9script

if !exists(':Fern')
  finish
endif

if mapcheck('<C-F>.', 'n') ==# ''
  nmap <C-F>. :Fern . -drawer -reveal=%<CR>
  nmap <C-F>, :Fern . -drawer -stay -reveal=%<CR>
  nmap <C-F>b :Fern bookmark:/// -drawer<CR>
endif

# if !exists('g:fern_preview_loaded')
#   g:fern_preview_loaded = 1
#   call extend(g:fern#mapping#mappings, ['preview'])
# endif

def Init()
  nmap <silent> <buffer> p <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
enddef

augroup fern-startup
  autocmd!
  autocmd FileType fern call <ScriptCmd>Init()
augroup END
