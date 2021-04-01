scriptencoding utf-8

inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : '<CR>'
imap <C-Space> <Plug>(asyncomplete_force_refresh)

if exists('*vsnip#jumpable')
  inoremap <expr> <Tab> pumvisible()
        \ ? '<C-n>'
        \ : vsnip#jumpable(1)
        \ ? '<Plug>(vsnip-jump-next)'
        \ : '<Tab>'
  inoremap <expr> <S-Tab> pumvisible()
        \ ? '<C-p>'
        \ : vsnip#jumpable(-1)
        \ ? '<Plug>(vsnip-jump-prev)'
        \ : '<S-Tab>'
else
  inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '\<Tab>'
  inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'
endif
