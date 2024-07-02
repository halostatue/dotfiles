vim9script

export const JK_NORMAL = 'jk_normal'
export const JK_STRICT = 'jk_strict'

const JK_MAPPINGS = { j: 'gj', k: 'gk', gj: 'j', gk: 'k' }

def JkLinewiseNormal()
  for key in JK_MAPPINGS->keys()
    execute printf('nunmap %s', key)
    execute printf('vunmap %s', key)
  endfor
enddef

def JkLinewiseStrict()
  for [k, v] in JK_MAPPINGS->items()
    execute printf('nnoremap %s %s', k, v)
    execute printf('vnoremap %s %s', k, v)
  endfor
enddef

export def JkLinewise(mode: string = null_string)
  if mode == null_string
    if maparg('j', 'n') ==# 'gj'
      JkLinewiseNormal()
    else
      JkLinewiseStrict()
    endif
  elseif mode ==# JK_NORMAL
    JkLinewiseNormal()
  elseif mode ==# JK_STRICT
    JkLinewiseStrict()
  else
    throw 'Mode must be omitted or one of hz#behaviour#JK_NORMAL or hz#behaviour#JK_STRICT'
  endif
enddef

const ToggleWindowCommands = {
  location: { close: 'lclose', open: 'lopen' },
  quickfix: { close: 'cclose', open: 'copen' },
}

export def ToggleSpecialWindow(type: string)
  var w = winnr('$')

  execute ToggleWindowCommands[type].close

  if w == winnr('$')
    execute ToggleWindowCommands[type].open
    setlocal nowrap whichwrap=b,s
  endif
enddef

export def GetSynstack(): string
  return synstack(line('.'), col('.'))
    ->map('synIDattr(v:val, ''name'')')
    ->join(' > ')
enddef

export def VisualPaste()
  var savedReg = @"

  def Restore()
    @" = savedReg
  enddef

  return "p@=Restore()\<CR>"
enddef
