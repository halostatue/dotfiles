vim9script

##
# Close the QuickFix window if open; open if not.
command! -nargs=0 -bar ToggleQuickfix call hz#behaviour#ToggleSpecialWindow('quickfix')

##
# Close the Location window if open; open if not.
command! -nargs=0 -bar ToggleLocation call hz#behaviour#ToggleSpecialWindow('location')

##
# Show the syntax highlighting stack under the cursor.
command! -nargs=0 -bar SynStack echo hz#_synstack()<CR>

##
# Clean trailing whitespace.
command! -range CleanWhitespace hz#behaviour#CleanWhitespace('<line1>', '<line2>')

##
# Clean ANSI color escapes from the range.
command! CleanAnsiColors call hz#with_saved_search("s/\\e\\[.\\{-}m//ge")

##
# Clean trailing <CR> characters from the range.
command! CleanTrailingCR call hz#with_saved_search("s/\\r$//e")

##
# Clean multiple newlines.
command! CleanDoubleLines call hz#with_saved_search("s/^\\n\\+/\\r/e")

##
# Toggle between strict linewise and wrapped vertical motion.
command! -nargs=0 -bar ToggleGJK call hz#behaviour#JkLinewise()

if executable('pdftotext')
  def ReadPDF(file: string)
    enew
    execute printf('read !pdftotext -nopgbrk -layout "%s" -', file)
    setlocal nomodifiable nomodified readonly
  enddef

  command! -complete=file -nargs=1 Pdf call <ScriptCmd>ReadPDF(<q-args>)
endif
