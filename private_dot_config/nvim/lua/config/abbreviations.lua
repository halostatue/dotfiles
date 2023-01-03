local letters = 'abcdefghijklmnopqrstuvwxyz'
local numbers = '1234567890'
local dashes = '----------'

local iabbrev = function(name, def) vim.cmd(string.format('iabbrev %s %s', name, def)) end

-- Abbreviations for rulers
iabbrev('raz', letters)
iabbrev('Raz', string.upper(letters))
iabbrev('r10', numbers)
iabbrev('r40', string.rep(numbers, 4))
iabbrev('r80', string.rep(numbers, 8))
iabbrev('r72', string.sub(string.rep(numbers, 8), 1, 72))
iabbrev('R10', dashes)
iabbrev('R40', string.rep(dashes, 4))
iabbrev('R80', string.rep(dashes, 8))
iabbrev('R72', string.sub(string.rep(dashes, 8), 1, 72))

-- Abbreviations for date cmmands
iabbrev('cdate', '<C-R>=strftime("%Y%m%d")<CR>') -- yyyymmdd
iabbrev('cfdate', '<C-R>=strftime("%Y.%m.%d")<CR>') -- yyyy.mm.dd
iabbrev('ctime', '<C-R>=strftime("%H:%M")<CR>') -- hh:mm
iabbrev('cdatetime', '<C-R>=strftime("%Y%m%d %H:%M")<CR>') -- yyyymmdd hh:mm
iabbrev('cfdatetime', '<C-R>=strftime("%Y.%m.%d %H:%M")<CR>') -- yyyy.mm.dd hh:mm
iabbrev('clongdate', '<C-R>=strftime("%a %b %d %X %z %Y")<CR>') -- system long date
iabbrev('cpdate', '<C-R>=strftime("%A, %d %B %Y")<CR>') -- formatted long date
iabbrev('cisodt', '<C-R>=strftime("%Y-%m-%dT%H:%M:%S%z")<CR>') -- ISO datetime
iabbrev('cdt', '<C-R>=hz#isotime()<CR>') -- ISO datetime

-- A lorem abbreviation
iabbrev(
  'iabbrev',
  'Lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum'
)
