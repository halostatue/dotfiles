scriptencoding utf-8

if exists('*asyncomplete#sources#file#get_source_options')
  augroup asyncomplete-file
    autocmd User asyncomplete_setup
          \ call asyncomplete#register_source(
          \   asyncomplete#sources#file#get_source_options({
          \     'name': 'file',
          \     'whitelist': ['*'],
          \     'priority': 10,
          \     'completor': function('asyncomplete#sources#file#completor')
          \ }))
  augroup END
endif
