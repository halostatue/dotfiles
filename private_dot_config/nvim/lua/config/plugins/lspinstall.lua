local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local completion = require('completion')
local aerial = require('aerial')

local function common_on_attach(client, bufnr)
  -- ... set up buffer keymaps, etc.
  completion.on_attach({
    sorting = 'alphabet',
    matching_strategy_list = {'exact', 'fuzzy', 'substring'},
  })

  aerial.on_attach(client)

  -- Aerial does not set any mappings by default, so you'll want to set some up
  -- Toggle the aerial window with <leader>a
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
  -- Jump forwards/backwards with '{' and '}'
  vim.api.nvim_buf_set_keymap(0, 'n', '{', '<cmd>AerialPrev<CR>', {})
  vim.api.nvim_buf_set_keymap(0, 'n', '}', '<cmd>AerialNext<CR>', {})
  -- Jump up the tree with '[[' or ']]'
  vim.api.nvim_buf_set_keymap(0, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
  vim.api.nvim_buf_set_keymap(0, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
end

local function opts()
  return {
    on_attach = common_on_attach
  }
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = common_on_attach,
  }

  -- optional customization of server options; check with server.name &c.
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md for server-specific options.
  -- https://github.com/neovim/nvim-lspconfig/wiki/Snippets has suggestions on working with snippets.

  server:setup(opts)
  vim.cmd [[do User LspAttachBuffers]]
end)

-- local ok, rust_analyzer = lsp_installer_servers.get_server("rust_analyzer")
-- if ok then
--     if not rust_analyzer:is_installed() then
--         rust_analyzer:install()
--     end
-- end
