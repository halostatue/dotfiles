local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local termcode = require('config.utils').termcode

local fn = vim.fn

local function check_backspace()
  local col = fn.col('.') - 1
  return col == 0 or fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local feedkeys = fn.feedkeys
local pumvisible = fn.pumvisible
local next_item_keys = termcode('<c-n>')
local prev_item_keys = termcode('<c-p>')
local backspace_keys = termcode('<tab>')
local snippet_next_keys = termcode('<plug>luasnip-expand-or-jump')
local snippet_prev_keys = termcode('<plug>luasnip-jump-prev')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind
      return vim_item
    end,
  },
  mapping = {
    ['<cr>'] = cmp.mapping.confirm(),
    ['<tab>'] = cmp.mapping(function(fallback)
      if pumvisible() == 1 then
        feedkeys(next_item_keys, 'n')
      elseif luasnip.expand_or_jumpable() then
        feedkeys(snippet_next_keys, '')
      elseif check_backspace() then
        feedkeys(backspace_keys, 'n')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  ['<s-tab>'] = cmp.mapping(function(fallback)
    if pumvisible() == 1 then
      feedkeys(prev_item_keys, 'n')
    elseif luasnip.jumpable(-1) then
      feedkeys(snippet_prev_keys, '')
    else
      fallback()
    end
  end, {
    'i',
    's',
  }),
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'luasnip' },
  },
}

-- autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
