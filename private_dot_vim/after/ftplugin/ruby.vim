scriptencoding utf-8

if exists('*ale#path#FindNearestFile')
  let b:ale_linters_ignore = []

  if ale#path#FindNearestFile(buffer_number(), '.standard.yml') !=# ''
    call add(b:ale_linters_ignore, 'rubocop')
  endif
endif
