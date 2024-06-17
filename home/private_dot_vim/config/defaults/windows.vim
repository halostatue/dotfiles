vim9script

if !hz#is('windows') 
 finish 
endif

# Why Windows still has drive letters in 2015^W2018^W2021^W2023^W2024, I have
# no clue. Ignore the "floppy" drives.
set viminfo+=rA:,rB:

# In Windows, certain .exe files can't be found when the $PATH doesn't contain
# $VIM. Let's fix that.
if $PATH !~? printf('\(^\|;\)%s\(;\|$\)', escape($VIM, '\\'))
  let $PATH = printf('%s;%s', $VIM, $PATH)
endif
