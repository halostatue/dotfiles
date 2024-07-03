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

export def VisualPaste(): any
  var savedReg = @"

  def Restore()
    @" = savedReg
  enddef

  return "p@=Restore()\<CR>"
enddef

export def ExecuteInPlace(cmd: string)
  var saved_view = winsaveview()
  execute cmd
  call winrestview(saved_view)
enddef

export def ExecuteWithSavedSearch(cmd: string)
  var ch = histnr('search')
  ExecuteInPlace(cmd)

  while ch != histnr('search')
    histdel('search', -1)
  endwhile

  @/ = histget('search', -1)
enddef

export def CleanWhitespace(line1: any, line2: any)
  var range = line1 == null ? '' :
    line2 == null ? string(line1) :
    string(line1) .. ',' .. string(line2)

  ExecuteWithSavedSearch(printf('%ss/\s\+$//e', range))
enddef

export def Colors(): list<string>
  var known = globpath(&runtimepath, 'colors/*.vim', 0, 1) +
    globpath(&packpath, 'pack/*/opt/*/colors/*.vim', 0, 1)

  return known
    ->map((_, v) => v->fnamemodify(':t:r'))
    ->sort()
    ->uniq()
enddef

defcompile
