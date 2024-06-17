vim9script

const Promise = vital#fern#import('Async.Promise')

g:fern#mapping#preview#disable_default_mappings = g:->get(
  'fern#mapping#preview#disable_default_mappings', false
)
def PreviewLeafNode(helper: dict<any>): any
  var node = helper.sync.get_cursor_node()

  if node.status !=# g:fern#STATUS_NONE || node.bufname->empty()
    return Promise.reject(printf('%s is not a previewable node', node.name))
  endif

  quickui#preview#open(node.bufname, {})

  return Promise.resolve()
endfunction

enddef

def Call()
  fern#mapping#call(PreviewLeafNode)
enddef

export def fern#mapping#preview#init(disable_default_mappings: bool = false)
  nnoremap <buffer><silent> <Plug>(fern-action-preview-leaf-node) :<C-u>call <ScriptCmd>Call()<CR>

  if !disable_default_mappings && !g:fern#mapping#preview#disable_default_mappings
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
enddef
