local fn = vim.fn

local install_path = fn['hz#xdg_path']('data', 'site', 'pack', 'packer', 'start', 'packer.nvim')

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})

  vim.cmd [[
     augroup vim-packer-install
       autocmd!
       autocmd VimEnter * if exists(':PackerSync') | PackerSync | endif
       autocmd BufWritePost plugins.lua source <afile> | PackerCompile
     augroup END
   ]]
end
