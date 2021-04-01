scriptencoding utf-8

" Rulers
iabbrev raz abcdefghijklmnopqrstuvwxyz
iabbrev Raz ABCDEFGHIJKLMNOPQRSTUVWXYZ
iabbrev r10 1234567890
iabbrev r40 1234567890123456789012345678901234567890
iabbrev r80 12345678901234567890123456789012345678901234567890123456789012345678901234567890
iabbrev r72 123456789012345678901234567890123456789012345678901234567890123456789012
iabbrev R10 ----------
iabbrev R40 ----------------------------------------
iabbrev R80 --------------------------------------------------------------------------------
iabbrev R72 ------------------------------------------------------------------------

" General echo editing abbreviations
" yyyymmdd
iabbrev cdate <C-R>=strftime("%Y%m%d")<CR>
" yyyy.mm.dd
iabbrev cfdate <C-R>=strftime("%Y.%m.%d")<CR>
" hh:mm
iabbrev ctime <C-R>=strftime("%H:%M")<CR>
" yyyymmdd hh:mm
iabbrev cdatetime <C-R>=strftime("%Y%m%d %H:%M")<CR>
" yyyy.mm.dd hh:mm
iabbrev cfdatetime <C-R>=strftime("%Y.%m.%d %H:%M")<CR>
" system long date
iabbrev clongdate <C-R>=strftime("%a %b %d %X %z %Y")<CR>
" formatted long date
iabbrev cpdate <C-R>=strftime("%A, %d %B %Y")<CR>
" ISO datetime
iabbrev cisodt <C-R>=strftime("%Y-%m-%dT%H:%M:%S%z")<CR>

iabbrev cdt <C-R>=hz#isotime()<CR>

iabbrev Lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
