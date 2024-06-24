vim9script

if !exists(':Fern')
  finish
endif

if mapcheck('<C-F>.', 'n') ==# ''
  nmap <C-F>. :Fern . -drawer -stay -reveal=%<CR>
  nmap <C-F>, :Fern . -drawer -reveal=%<CR>
  nmap <C-F>b :Fern bookmark:/// -drawer<CR>
endif

g:fern#default_hidden = true
g:fern#drawer_width = 30

if packix#is_plugin_installed('vim-emoji')
  if packix#is_plugin_installed('vim-fern-git-status') 
    g:fern_git_status#indexed_characters = emoji#for('heavy_plus_sign')
    g:fern_git_status#stained_characters = emoji#for('question')
  endif
endif

def Init()
  if packix#is_plugin_installed('fern-preview')
    nmap <silent> <buffer> p <Plug>(fern-action-preview:toggle)
    nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
    nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
    nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
    nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
    nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
  endif

  nnoremap <silent> <buffer> <Plug>(fern-my-enter-project-root) :<C-u>call fern#helper#call(MapEnterProjectRoot)<CR>
  nnoremap <silent> <buffer> <expr> ^ fern#smart#schema('^', { file: '\<Plug>(fern-my-enter-project-root') })

  nmap <silent> <buffer> m <Plug>(fern-action-mark)j
  nmap <silent> <buffer> D <Plug>(fern-action-trash=)
  nmap <silent> <buffer> r <Plug>(fern-action-rename)

  if packix#is_plugin_installed('fern-mapping-reload-all')
    nmap <silent> <buffer> R <Plug>(fern-action-reload:all)
  endif
enddef

def MapEnterProjectRoot(helper: dict<any>)
  execute printf(
    'Fern %s', 
    finddir('.git/..', helper.get_root_node()._path .. ';')
  )
enddef

augroup fern-startup
  autocmd!
  autocmd FileType fern call Init()
augroup END
