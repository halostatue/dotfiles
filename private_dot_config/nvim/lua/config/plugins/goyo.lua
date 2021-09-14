vim.cmd [[
augroup junegunn-goyo-limelight
  autocmd!

  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!
augroup END
]]
