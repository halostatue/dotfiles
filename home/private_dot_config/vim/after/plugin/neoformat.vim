vim9script

if !exists(':Neoformat')
  finish
endif

def ApplyNeoformat()
  try
    undojoin
    Neoformat
  catch /^Vim\%((\a\+)\)\=:E790/
  finally
    silent Neoformat 
  endtry
enddef

def EnableNeoformat()
  augroup neoformat_config
    autocmd!
    autocmd BufWritePre * call ApplyNeoformat()
  augroup END
enddef

def DisableNeoformat()
  autocmd! neoformat_config
enddef

command! EnableNeoformat call EnableNeoformat()
command! DisableNeoformat call DisableNeoformat()

EnableNeoformat()
