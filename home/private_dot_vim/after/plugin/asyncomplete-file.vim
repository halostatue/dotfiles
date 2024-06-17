vim9script

if !exists('*asyncomplete#sources#file#get_source_options')
  finish
endif

augroup asyncomplete-file
  autocmd User asyncomplete_setup
        \ call asyncomplete#register_source(
        \   asyncomplete#sources#file#get_source_options({
        \     'name': 'file',
        \     'allowlist': ['*'],
        \     'priority': 10,
        \     'completor': function('asyncomplete#sources#file#completor')
        \ }))
augroup END
