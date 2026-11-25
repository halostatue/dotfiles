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

const FORMAT_FOR_GITHUB = 'rumdl fmt --no-config -s ' ..
  shellescape('-c') .. ' ' .. shellescape('MD013.reflow = true') .. ' ' ..
  shellescape('-c') .. ' ' .. shellescape('MD013.reflow-mode = "normalize"') .. ' ' ..
  shellescape('-c') .. ' ' .. shellescape('MD013.line-length = 0') .. ' -'

def FormatPR(first: number = 1, last: number = line('$'))
  var input = getline(first, last)
  var output = systemlist(FORMAT_FOR_GITHUB, input)

  if v:shell_error != 0
    echohl ErrorMsg
    echomsg 'rumdl fmt failed: ' .. join(output, ' ')
    echohl None
    return
  endif

  if output ==# input
    return
  endif

  var view = winsaveview()
  var common = min([len(input), len(output)])
  setline(first, output[ : common - 1])
  if len(output) > len(input)
    appendbufline('%', last, output[common : ])
  elseif len(output) < len(input)
    deletebufline('%', first + common, last)
  endif
  winrestview(view)
enddef

command! -range=% PRFormat FormatPR(<line1>, <line2>)

command! EnableNeoformat call EnableNeoformat()
command! DisableNeoformat call DisableNeoformat()
command! PreparePR call DisableNeoFormat() | call FormatPR()

EnableNeoformat()
