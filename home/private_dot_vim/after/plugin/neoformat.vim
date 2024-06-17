vim9script

if !exists(':Neoformat')
  finish
endif

def Neoformat()
  try
    undojoin
    Neoformat
  catch /^Vim\%((\a\+)\)\=:E790/
  finally
    silent Neoformat 
  endtry
enddef

def Enable()
  augroup neoformat_config
    autocmd!
    autocmd BufWritePre * call <ScriptCmd>Neoformat()
  augroup END
enddef

def Disable()
  autocmd! neoformat_config
enddef

command! EnableNeoformat call <ScriptCmd>Enable()
command! DisableNeoformat call <SCriptCmd>Disable()
