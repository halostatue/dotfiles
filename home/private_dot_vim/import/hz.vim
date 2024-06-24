vim9script

import 'hz/immutable.vim'

def Bool(value: any): bool
  return !!value
enddef

final Info: dict<bool> = {
  windows: Bool(has('win16') || has('win32') || has('win64')),
  cygwin: Bool(has('win32unix')),
}

Info.mac = Bool(!Info.windows && !Info.cygwin && (
  has('mac') || has('macunix') || has('gui_macvim') || (
    !executable('xdg-open') && system('uname') =~? '^darwin'
  )
))
Info.macgui = Bool(Info.mac && has('gui_running'))
Info.sudo = Bool($SUDO_USER !=# '' && $USER !=# $SUDO_USER
  && $HOME !=# expand('~' .. $USER) && $HOME ==# expand('~' .. $SUDO_USER))
Info.tmux = Bool(exists('$TMUX'))

const ToggleWindowCommands = {
  location: { close: 'lclose', open: 'lopen' },
  quickfix: { close: 'cclose', open: 'copen' },
}

export def Platform(): string
  if Is('windows')
    return 'windows'
  elseif Is('cygwin')
    return 'cygwin'
  elseif Is('mac')
    return 'mac'
  else
    return 'unix'
  endif
enddef

export def Is(type: string): bool
  return Info->has_key(type) && Info[type]
enddef

export def IsValidFunction(value: any): bool
  return value != null && (
    value->type() == v:t_func || (
      value->type() == v:t_string && exists('*' .. value->substitute('()$', '', ''))
    )
  )
enddef

export def Wrap(value: any): list<any>
  return value->type() == v:t_list ? value : [value]
enddef

export def Mkpath(path: string, force: bool = false)
  if !isdirectory(path)
    if force || input(printf('"%s" does not exist; create? [y/N]', path)) =~? '^y'
      mkdir(iconv(path, &encoding, &termencoding), 'p')
    endif
  endif
enddef

export def Isotime(time: any = null): string
  var zone = strftime('%z', time == null ? localtime() : time)
    ->substitute('\([-+]\)\(\d\{2}\)\(\d\{2}\)', '\1\2:\3', '')

  return time == null ?
    printf('%s%s', strftime('%Y-%m-%dT%H:%M:%S'), zone) :
    printf('%s%s', strftime('%Y-%m-%dT%H:%M:%S', time), zone)
enddef

export def Try(Func: any, options: dict<any> = {}): any
  var dict: dict<any> = get(options, 'dict', null_dict)
  var args: list<any> = get(options, 'args', [])
  var default: any = get(options, 'default', null)

  if Func->type() == v:t_func || (Func->type() == v:t_string && exists('*' .. Func))
    return dict == null_dict ? Func->call(args) : Func->call(args, dict)
  endif

  return default
enddef

export def In(haystack: any, needle: any): bool
  if haystack->type() == v:t_string
    return needle->type() == v:t_string && haystack->stridx(needle) != -1
  endif

  if haystack->type() == v:t_list
    return haystack->index(needle) != -1
  endif

  if haystack->type() == v:t_dict
    return haystack->values()->index(needle) != -1
  endif

  return false
enddef

export def TrimLeading(value: string, pattern: string = '\_s'): string
  return value->substitute(printf('^%s\+', pattern), '', '')
enddef

export def TrimTrailing(value: string, pattern: string = '\_s'): string
  return value->substitute(printf('%s\+$', pattern), '', '')
enddef

export def Trim(value: string, pattern: string = '\_s'): string
  return TrimTrailing(TrimLeading(value, pattern), pattern)
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

export def GetSetting(name: string, default: any = null): any
  return get(b:, name, get(g:, name, default))
enddef

export def GetMotion(motion: string): string
  var cursor = getpos('.')
  var reg = getreg('z')
  var regtype = getregtype('z')

  execute 'normal! ' .. motion .. '"zy'

  var text = @z

  setreg('z', reg, regtype)
  setpos('.', cursor)

  return text
enddef

export def SwitchWindow(bufname: string)
  var nr = bufwinnr(bufname)

  if nr >= 0
    execute printf(':%dwincmd w', nr)
  endif
enddef

export def RangeUniq(line1: number, line2: number, ignore_ws: bool = false)
  var NormalizeWS = (str: string) =>
    str->substitute('^\s\+|\s\+$', '', 'g')->substitute('\s+', ' ', 'g')

  var seen: dict<bool> = {}
  var uniq: list<any> = []

  for line in getline(line1, line2)
    var nline = '>' .. (ignore_ws ? NormalizeWS(line) : line)
    if !seen->has_key(nline)
      uniq->add(line)
      seen[nline] = true
    endif
  endfor

  execute printf(':%s,%sdelete', line1, line2)
  append(line1 - 1, uniq)
enddef

export def XdgBase(type: string, ...parts: list<any>): string
  var base: list<string>

  if type ==# 'data'
    base = exists('$XDG_DATA_HOME') ? [$XDG_DATA_HOME] : [$HOME, '.local/share']
  elseif type ==# 'config'
    base = exists('$XDG_CONFIG_HOME') ? [$XDG_CONFIG_HOME] : [$HOME, '.config']
  elseif type ==# 'cache'
    base = exists('$XDG_CACHE_HOME') ? [$XDG_CACHE_HOME] : [$HOME, '.cache']
  else
    throw 'Unknown XDG path type "' .. type .. '".'
  endif

  if parts->len() > 0
    base->extend(parts->flattennew())
  endif

  return base->join('/')
enddef

export def XdgVimPath(type: string, ...parts: list<any>): string
  return XdgBase(type, flattennew(['vim', parts]))
enddef

export def MkXdgPath(type: string, ...parts: list<string>): string
  var path = XdgBase(type, parts)
  mkdir(path, 'p')
  return path
enddef

export def MkXdgVimPath(type: string, ...parts: list<any>): string
  var path = XdgVimPath(type, parts)
  mkdir(path, 'p')
  return path
enddef

export def AddVimscriptUserCommandsSyntax()
  var cmdList: string

  redir => cmdList
  silent! command
  redir END

  var commands =
    cmdList
      ->split('\n')[1 : ]
      ->map((_, v) => matchstr(v, '[!"b]*\s\+\zs\u\w*\ze'))
      ->join()

  if empty(commands)
    return
  else
    execute 'syntax keyword vimCommand' .. commands
  endif
enddef

export def ToggleJkMapping(mode: string = null_string)
  var target = index(['alt', 'normal'], mode) >= -1
    ? mode
    : maparg('j', 'n') ==# 'gj'
    ? 'normal'
    : 'alt'

  if target ==# 'normal'
    noremap <buffer> j j
    noremap <buffer> k k
    noremap <buffer> gj gj
    noremap <buffer> gk gk
  else
    noremap <buffer> j gj
    noremap <buffer> k gk
    noremap <buffer> gj j
    noremap <buffer> gk k
  endif
enddef

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

export def UrlEncode(url: string): string
  var parts = url->split('/', true)
  var index = parts[0] =~# '^https\=' ? 3 : 1

  parts[index : ] = parts[index : ]->map(
    (_i, part) => {
      return substitute(
        part,
        '\([^-[:alnum:].=?&]\)',
        (m) => printf('%%%02X', char2nr(m[1])),
        'g'
      )
    }
  )

  return parts->join('/')
enddef

export def UrlDecode(url: string): string
  return url
    ->substitute('%0[Aa]\n$', '%0A', '')
    ->substitute('%0[Aa]', '\n', 'g')
    ->substitute('+', ' ', 'g')
    ->substitute('%\(\x\x\)', (m) => nr2char(str2nr('0x' .. m[1], 16)), 'g')
enddef

defcompile
