local is = vim.fn['hz#is']

if not is('windows') and not is('cygwin') then
  return
end

-- Why Windows still has drive letters in 2015^W2018^W2021, I have no clue.
-- Ignore the "floppy" drives.
vim.opt.shada:append { 'ra:', 'rb:' }
