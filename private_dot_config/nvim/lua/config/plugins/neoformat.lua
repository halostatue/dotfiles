vim.cmd [[
augroup neoformat_config
  autocmd!

  autocmd BufWritePre * silent! undojoin | Neoformat
augroup END
]]
