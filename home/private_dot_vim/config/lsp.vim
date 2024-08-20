vim9script

# Settings for LSP, Autocomplete, and Snippets
#
# Both yegappan/lsp and prabirshrestha/vim-lsp use the same settings library,
# mattn/vim-lsp-settings (these actually use my fork, halostatue/vim-lsp-settings, which
# adds standardrb LSP mode).

# vim9 LSP: yegappan/lsp, mattn/vim-lsp-settings, normen/vim-lsp-settings-adapter,
# girishji/vimcomplete, hrsh7th/vim-vsnip, hrsh7th/vim-vsnip-integ,
# rafamadriz/friendly-snippets
def WithVim9Lsp()
  if !packix#IsPluginInstalled('yegappan/lsp') | return | endif

  setlocal tagfunc=lsp#lsp#TagFunc

  nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
  nnoremap <buffer> <leader>s <Cmd>LspSymbolSearch<CR>
  nnoremap <buffer> <leader>r <Cmd>LspShowReferences<CR>
  nnoremap <buffer> <leader>i <Cmd>LspGotoImpl<CR>
  nnoremap <buffer> <Leader>D <Cmd>LspGotoTypeDef<CR>
  nnoremap <buffer> <Leader>rn <Cmd>LspRename<CR>
  nnoremap <buffer> [g <Cmd>LspDiag prev<CR>
  nnoremap <buffer> ]g <Cmd>LspDiag next<CR>
  nnoremap <buffer> K <Cmd>LspHover<CR>

  if !packix#IsPluginInstalled('girishji/vimcomplete') | return | endif

  var vim_complete_options = {
    completor: { noNewlineInCompletionEver: true },
    buffer: { priority: 1, urlComplete: true, envComplete: true },
    lsp: { enable: true, priority: 20 },
    path: { showPathSeparatorAtEnd: true },
    vimscript: { enable: true, filetypes: ['vim'], priority: 30 },
    vsnip: { enable: true, priority: 15 },
  }

  if !packix#IsPluginInstalled('hrsh7th/vim-vnsip')
    vim_complete_options.vsnip.enable = false
  endif

  g:vimcomplete_tab_enable = true

  g:VimCompleteOptionsSet(vim_complete_options)
enddef

# vim LSP: prabirshrestha/vim-lsp, mattn/vim-lsp-settings,
# prabirshrestha/asyncomplete.vim, prabirshrestha/asyncomplete-lsp.vim,
# prabirshrestha/asyncomplete-file.vim, tsuyoshicho/asyncomplete-anylist
def WithVimLsp()
  if !packix#IsPluginInstalled('prabirshrestha/vim-lsp') | return | endif

  setlocal tagfunc=lsp#tagfunc

  nmap <buffer> gd <Plug>(lsp-definition)
  nmap <buffer> <Leader>s <Plug>(lsp-workspace-symbol-search)
  nmap <buffer> <Leader>r <Plug>(lsp-references)
  nmap <buffer> <Leader>i <Plug>(lsp-implementation)
  nmap <buffer> <Leader>D <Plug>(lsp-type-definition)
  nmap <buffer> <Leader>rn <Plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <Plug>(lsp-hover)
  nnoremap <buffer> <expr><C-f> lsp#scroll(+4)
  nnoremap <buffer> <expr><C-d> lsp#scroll(-4)
enddef

def WithLsp()
  setlocal signcolumn=yes

  if packix#IsPluginInstalled('yegappan/lsp')
    WithVim9Lsp()
  elseif packix#IsPluginInstalled('prabirshrestha/vim-lsp')
    WithVimLsp()
  endif
enddef

augroup hz-lsp-config
  autocmd!

  autocmd User LspAttached WithLsp()
  autocmd User lsp_buffer_enabled WithLsp()
augroup END
