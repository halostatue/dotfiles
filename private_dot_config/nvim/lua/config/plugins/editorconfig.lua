vim.cmd [[
augroup EditorConfig
  autocmd!

  autocmd FileType gitcommit let b:EditorConfig_disable = 1
augroup END
]]

vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'fern://.*' }
