scriptencoding utf-8

let s:Promise = vital#fern#import('Async.Promise')

function! fern#mapping#preview#init(disable_default_mappings) abort
  nnoremap <buffer><silent> <Plug>(fern-action-preview-leaf-node) :<C-u>call <SID>call('preview_leaf_node')<CR>

  if !a:disable_default_mappings && !g:fern#mapping#preview#disable_default_mappings
    nmap <buffer> m <Plug>(fern-action-preview-leaf-node)

    nmap <buffer><expr> j
          \ fern#smart#drawer(
          \   "j\<Plug>(fern-action-preview-leaf-node)",
          \   "j",
          \ )
    nmap <buffer><expr> k
          \ fern#smart#drawer(
          \   "k\<Plug>(fern-action-preview-leaf-node)",
          \   "k",
          \ )
  endif
endfunction

function! s:call(name, ...) abort
  return call(
        \ 'fern#mapping#call',
        \ [funcref(printf('s:map_%s', a:name))] + a:000,
        \)
endfunction

function! s:map_preview_leaf_node(helper) abort
  let node = a:helper.sync.get_cursor_node()

  if node.status !=# g:fern#STATUS_NONE || empty(node.bufname)
    return s:Promise.reject(printf('%s is not a previewable node', node.name))
  endif

  call quickui#preview#open(node.bufname, {})

  return s:Promise.resolve()
endfunction

let g:fern#mapping#preview#disable_default_mappings = get(g:, 'fern#mapping#preview#disable_default_mappings', 0)
