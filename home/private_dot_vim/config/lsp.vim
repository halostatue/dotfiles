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

# https://github.com/prabirshrestha/asyncomplete.vim
# https://github.com/prabirshrestha/asyncomplete-lsp.vim
# https://github.com/hrsh7th/vim-vsnip-integ
# https://github.com/mattn/vim-lexiv - cohama/lexima.vim?


# https://github.com/reedes/vim-pencil
# https://github.com/reedes/vim-lexical
# opt - https://github.com/junegunn/goyo.vim
# opt - https://github.com/junegunn/limelight.vim

# opt - https://github.com/wellle/targets.vim
# https://github.com/rhysd/clever-f.vim
# https://github.com/edkolev/erlang-motions.vim
# opt - https://github.com/mg979/vim-visual-multi
# https://github.com/christoomey/vim-conflicted
# https://github.com/rhysd/conflict-marker.vim
#
# https://github.com/tpope/vim-dispatch
# https://github.com/hauleth/asyncdo.vim
# https://github.com/romainl/vim-qf
# https://github.com/romainl/vim-qlist
# https://github.com/Olical/vim-enmasse
# https://github.com/igemnace/vim-makery
# off - https://github.com/AndrewRadev/qftools.vim
# off- https://github.com/AndrewRadev/linediff.vim
#
# https://github.com/t9md/vim-choosewin
# https://github.com/dhruvasagar/vim-zoom
#
# Optional debug / test stuff {{{
# opt - https://github.com/Vimjas/vint
# opt - https://github.com/puremourning/vimspector
# https://github.com/vim-test/vim-test
# opt - https://github.com/junegunn/vader.vim
# opt - https://github.com/tpope/vim-scriptease
# opt - https://github.com/tweekmonster/exception.vim
# opt - https://github.com/tweekmonster/helpful.vim
# opt - https://github.com/mhinz/vim-lookup
# opt - https://github.com/thinca/vim-themis
#
# opt - https://github.com/mattn/gist-vim
# opt - https://github.com/mbbill/undotree
#
# Loaded only for specific filetypes on demand.
# Requires autocommands below.
# opt - for go - https://github.com/fatih/vim-go
