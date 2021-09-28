local ts_completion = {
  { complete_items = { 'lsp' } },
  { complete_items = { 'ts' } },
  { complete_items = { 'path' }, triggered_only = { '/' } },
  { complete_items = { 'buffers' } },
}

vim.g.completion_chain_complete_list = {
  default = {
    { complete_items = { 'lsp' } },
    { complete_items = { 'path' }, triggered_only = { '/' } },
    { complete_items = { 'buffers' } },
    { mode = { '<c-p>' } },
    { mode = { '<c-n>' } },
  },
  c = ts_completion,
  python = ts_completion,
  lua = ts_completion,
  string = { { complete_items = { 'path' }, triggered_only = { '/' } }, },
  sql = { complete_items = { 'vim-dadbod-completion' } },
  comment = {}
}

vim.g.completion_sorting = 'alphabet'
vim.g.completion_matching_strategy_list = {'exact', 'fuzzy', 'substring'}
vim.g.completion_matching_ignore_case = 1

vim.cmd [[
augroup completion-nvim
  autocmd!

  autocmd BufEnter * lua require'completion'.on_attach()
  autocmd FileType sql let g:completion_trigger_character = ['.', '"', '`', '[']
augroup END
]]
