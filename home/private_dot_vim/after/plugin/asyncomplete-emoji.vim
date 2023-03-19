scriptencoding utf-8

if exists('*asyncomplete#sources#emoji#get_source_options')
  augroup asyncomplete-emoji
    autocmd!
    autocmd User asyncomplete_setup
          \ call asyncomplete#register_source(
          \   asyncomplete#sources#emoji#get_source_options({
          \     'name': 'emoji',
          \     'whitelist': ['*'],
          \     'completor': function('asyncomplete#sources#emoji#completor'),
          \ }))
  augroup END
endif
