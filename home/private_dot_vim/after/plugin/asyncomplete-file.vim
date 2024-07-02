vim9script

if !exists('g:asyncomplete_manager') || !packix#IsPluginInstalled('asyncomplete-file')
  finish
endif

augroup asyncomplete-register-file
  autocmd!

  autocmd User asyncomplete_setup
        \ call asyncomplete#register_source(
        \   asyncomplete#sources#file#get_source_options({
        \     'name': 'file',
        \     'allowlist': ['*'],
        \     'priority': 10,
        \     'completor': function('asyncomplete#sources#file#completor')
        \ }))
augroup END
