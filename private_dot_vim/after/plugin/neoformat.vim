scriptencoding utf-8

augroup neoformat_config
  autocmd!
  autocmd BufWritePre * silent! undojoin | Neoformat
augroup END
