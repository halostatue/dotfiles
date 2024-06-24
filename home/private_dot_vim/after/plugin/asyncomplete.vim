vim9script

if !exists('g:asyncomplete_manager')
  finish
endif

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
  inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'
  inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
endif

if packix#is_plugin_installed('vim-emoji')
  var _cache: list<dict<any>>

  def CompleteEmoji(opt: dict<any>, ctx: dict<any>)
    if empty(_cache)
      _cache = emoji#data#dict()
        ->keys()
        ->sort()
        ->map((_, val) => {
          return { word: ':' .. val .. ':', kind: emoji#for(val) }
        })

      asyncomplete#log('cached emojis')
    endif

    var typed = ctx['typed']
    var startcol = match(typed, ':[^: \t]*$')

    if startcol > -1
      asyncomplete#complete(opt['name'], ctx, startcol + 1, _cache)
    endif
  enddef

  def RegisterEmoji()
    asyncomplete#register_source({
      name: 'emoji',
      allowlist: ['*'],
      completor: CompleteEmoji
    })
  enddef

  augroup asyncomplete-emoji
    autocmd!

    autocmd User asyncomplete_setup call RegisterEmoji()
  augroup END
endif
