scriptencoding utf-8

""
" Close the QuickFix window if open; open if not.
command! -nargs=0 -bar ToggleQuickfix call hz#_toggle_special_window('quickfix')

""
" Close the Location window if open; open if not.
command! -nargs=0 -bar ToggleLocation call hz#_toggle_special_window('location')

""
" Show the syntax highlighting stack under the cursor.
command! -nargs=0 -bar SynStack echo hz#_synstack()<CR>

""
" Clean trailing whitespace.
command! CleanWhitespace call hz#clean_whitespace()

""
" Clean ANSI color escapes from the range.
command! CleanAnsiColors call hz#with_saved_search("s/\\e\\[.\\{-}m//ge")

""
" Clean trailing <CR> characters from the range.
command! CleanTrailingCR call hz#with_saved_search("s/\\r$//e")

""
" Clean multiple newlines.
command! CleanDoubleLines call hz#with_saved_search("s/^\\n\\+/\\r/e")

""
" Toggle between strict linewise and wrapped vertical motion.
command! -nargs=0 -bar ToggleGJK call hz#_toggle_jk_mapping()

if executable('pdftotext')
  command! -complete=file -nargs=1 Pdf call s:ReadPDF(<q-args>)

  function! s:ReadPDF(file)
    enew
    execute 'read !pdftotext -nopgbrk -layout' a:file '-'
    setlocal nomodifiable nomodified readonly
  endfunction
endif
