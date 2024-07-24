vim9script

##
# Close the QuickFix window if open; open if not.
command! -nargs=0 -bar ToggleQuickfix hz#behaviour#ToggleSpecialWindow('quickfix')

##
# Close the Location window if open; open if not.
command! -nargs=0 -bar ToggleLocation hz#behaviour#ToggleSpecialWindow('location')

##
# Show the syntax highlighting stack under the cursor.
command! -nargs=0 -bar SynStack echo hz#behaviour#GetSynstack()

##
# Clean trailing whitespace.
command! -range CleanWhitespace hz#behaviour#CleanWhitespace('<line1>', '<line2>')

##
# Clean ANSI color escapes from the range.
command! CleanAnsiColors hz#behaviour#WithSavedSearch("s/\\e\\[.\\{-}m//ge")

##
# Clean trailing <CR> characters from the range.
command! CleanTrailingCR hz#behaviour#WithSavedSearch("s/\\r$//e")

##
# Clean multiple newlines.
command! CleanDoubleLines hz#behaviour#WithSavedSearch("s/^\\n\\+/\\r/e")

##
# Toggle between strict linewise and wrapped vertical motion.
command! -nargs=0 -bar ToggleGJK hz#behaviour#JkLinewise()

if executable('pdftotext')
  def ReadPDF(file: string)
    enew
    execute printf('read !pdftotext -nopgbrk -layout "%s" -', file)
    setlocal nomodifiable nomodified readonly
  enddef

  command! -complete=file -nargs=1 Pdf <ScriptCmd>ReadPDF(<q-args>)
endif

# bufdo, but return to the current buffer after completion
def BufDo(command: string)
  var current = bufnr('%')
  execute 'bufdo ' .. command
  execute 'buffer ' .. current
enddef

command! -bar -nargs=+ -complete=command Bufdo BufDo(<q-args>)

# Extract a block range into a new subfile.
# From https://github.com/dhruvasagar/dotfiles/base/master/vim/plugin/extract.vim (fetch)
function Extract(cmd, fname) range abort
  let l:ext = expand('%:e')
  let l:fname = l:ext->empty() ? a:fname : a:fname .. '.' .. l:ext
  let [l:first, l:last] = [a:firstline, a:lastline]
  let l:range = l:first .. ',' .. l:last
  let l:spaces = l:first->getline()->matchstr('^ *')
  let l:buf = @@
  silent execute ':' .. range .. 'yank'

  let l:partial = @@
  let @@ = l:buf

  let l:ai = &ai

  try
    let &ai = 0
    silent execute 'normal! :' .. range .. 'change<CR>' .. spaces .. a:fname .. '<CR>.<CR>'
  finally
    let &ai = l:ai
  endtry

  execute a:cmd .. ' ' .. expand('%:p:h') .. '/' .. l:fname

  let @@ = partial
  silent put
  :0delete
  let @@ = buf

  if !l:spaces->empty()
    silent! execute '%substitute/^' .. spaces .. ' //'
  endif
endfunction

command! -bar -nargs=1 -range SExtract :<line1>,<line2>call Extract('split', <q-args>)
command! -bar -nargs=1 -range VExtract :<line1>,<line2>call Extract('vsplit', <q-args>)
# command! -bar -nargs=1 -range TExtract :<line1>,<line2>call Extract('tabnew', <q-args>)
