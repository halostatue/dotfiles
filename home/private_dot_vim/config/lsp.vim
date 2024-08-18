vim9script

# https://github.com/prabirshrestha/vim-lsp
# https://github.com/mattn/vim-lsp-settings
g:lsp_settings_filetype_ruby = [
  'standardrb', 'ruby-lsp', 'solargraph', 'ruby_language_server', 'steep'
]

def OnLspBufferEnabled()
  # setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  # setlocal tagfunc=lsp#tagfunc

  nmap <buffer> gd <Plug>(lsp-definition)
  nmap <buffer> <Leader>d <Plug>(lsp-definition)
  nmap <buffer> <Leader>s <Plug>(lsp-document-symbol-search)
  nmap <buffer> <Leader>S <Plug>(lsp-workspace-symbol-search)
  nmap <buffer> <Leader>r <Plug>(lsp-references)
  nmap <buffer> <Leader>i <Plug>(lsp-implementation)
  nmap <buffer> <Leader>D <Plug>(lsp-type-definition)
  nmap <buffer> <Leader>rn <Plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <Plug>(lsp-hover)
  nnoremap <buffer> <expr><C-f> lsp#scroll(+4)
  nnoremap <buffer> <expr><C-d> lsp#scroll(-4)

  g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre *.rs,*.go execute('LspDocumentFormatSync')

  # refer to doc to add more commands
enddef

augroup lsp_install
  autocmd!
  # Call OnLspBufferEnabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled OnLspBufferEnabled()
augroup END
