vim9script

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
Info.neovim = false
Info.sudo = Bool($SUDO_USER !=# '' && $USER !=# $SUDO_USER
  && $HOME !=# expand('~' .. $USER) && $HOME ==# expand('~' .. $SUDO_USER))
Info.tmux = Bool(exists('$TMUX'))

const ToggleWindowCommands = {
  location: { close: 'lclose', open: 'lopen' },
  quickfix: { close: 'cclose', open: 'copen' },
}

##
# @section Introduction, introduction
# @stylized Hz.vim
# @library
# @order introduction config functions compatibility licence
#
# @plugin(stylized) is a collection of functions and commands that power
# Austin Ziegler's vim configuration.

##
# @section Compatibility
#
# All of the functions in @plugin are known to work with MacVim 9.1 and have
# been rewritten to use Vim 9 script.

##
# @section Licence
#
# @plugin(stylized) is public domain where possible, or licensed under CC0 1.0
# where not. There are no warranties, implied or expressed, about this @plugin
# or its suitability or fitness for any particular purpose.
#
# See https://creativecommons.org/publicdomain/zero/1.0/legalcode for more
# information.

##
# Returns a string representing the underlying platform as @plugin understands
# it. Will be one of `windows`, `cygwin`, `mac`, or `unix`.
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

##
# Returns true if the underlying status is the {type} declared. An
# unknown type returns false. Supported values for {type} are: cygwin, mac,
# macgui, neovim, nvim, sudo, tmux, vim, windows.
export def Is(type: string): bool
  return Info[type]
enddef

##
# Report whether the function name provided exists and contains a valid
# function name. The function name may be a bare name (`fn`) or have
# parentheses at the end (`fn()`).
export def IsValidFunction(value: string = null_string): bool
  return value != null_string && exists(
    '*' .. substitute(value, '()$', '', '')
  )
enddef

##
# Make {path}, prompting unless [force] is provided.
export def Mkpath(path: string, force: bool = false)
  if !isdirectory(path)
    if force || input(printf('"%s" does not exist; create? [y/N]', path)) =~? '^y'
      mkdir(iconv(path, &encoding, &termencoding), 'p')
    endif
  endif
enddef

##
# Portably produce a proper ISO 8601/RFC3339 timestamp. If [time] is not
# provided, the current time will be used.
export def Isotime(time: number = null)
  var zone = strftime('%z', time == null ? getftime() : time)
    ->substitute('\([-+]\)\(\d\{2}\)\(\d\{2}\)', '\1\2:\3', '')

  return time == null ?
    printf('%s%s', strftime('%Y-%m-%dT%H:%M:%S'), zone) :
    printf('%s%s', strftime('%Y-%m-%dT%H:%M:%S', time), zone)
enddef

##
# @usage [dict] [default] Func [args]
#
# Try to call the given [Func] with an optional dictionary, default, and
# arguments.
#
#     Try('fugitive#statusline')
#     Try(function('fugitive#statusline'))
#
# If [Func] is a dictionary function (and not a partial function reference),
# it is necessary to provide the [dict] parameter to properly provide `self`.
#
#     Try({}, 'dict.Func')
#
# A [default] value may be provided before the function reference, if it is
# inside of a list.
#
#     Try(['default'], 'F')
#
# Arguments are passed after the function name or reference.
#
#     Try(['default'], 'F', 1, 2, 3)
#
# This function is originally by Tim Pope as part of Flagship.
#
# @default default=''
# @default dict={}
# @default args=[]
export def Try(args: list<any>): any
  var params = copy(args)
  var dict: dict<any> = {}
  var default: any = null

  if type(get(params, 0)) == v:t_dict
    dict = remove(params, 0)
  endif

  if type(get(params, 0)) == v:t_list
    default = remove(params, 0)[0]
  endif

  if empty(params)
    return default
  endif

  var Func = remove(params, 0)

  if type(Func) == v:t_func || exists('*' .. Func)
    return call(Func, args, dict)
  end

  return default
enddef

##
# Answers if {needle} can be found in the provided {haystack} which may be a
# string, list, or dictionary (where is searches the values).
#
# If {haystack} is a string, but {needle} is not, returns false.
# If {haystack} is neither a string, list, nor dictionary, returns false.
export def In(haystack: any, needle: any): bool
  if type(haystack) == v:t_string
    return type(needle) == v:t_string && strdix(haystack, needle) != -1
  elseif type(haystack) == v:t_list
    return index(haystack, needle) != -1
  elseif type(haystack) == v:t_dict
    return index(values(haystack), needle) != -1
  endif

  return false
enddef

##
# Trims leading [pattern] from {string}.
#
# @default pattern='\_s' The regex for whitespace and newlines.
export def TrimLeading(value: string, pattern: string = '\_s'): string
  return value->substitute(printf('^%s\+', pattern), '', '')
enddef

##
# Trims trailing [pattern] from {string}.
#
# @default pattern='\_s' The regex for whitespace and newlines.
export def TrimTrailing(value: string, pattern: string = '\_s'): string
  return value->substitute(printf('%s\+$', pattern), '', '')
enddef

##
# Trims both leading and trailing [pattern] from {string}.
#
# @default pattern='\_s' The regex for whitespace and newlines.
export def Trim(value: string, pattern: string = '\_s'): string
  return TrimTrailing(TrimLeading(string, pattern), pattern)
enddef

##
# Executes {command} while saving and restoring the window state.
export def ExecuteInPlace(cmd: string)
  var saved_view = winsaveview()
  execute cmd
  call winrestview(saved_view)
enddef

##
# Executes {command} while saving and restoring the most recent saved search
# history and the window state.
export def ExecuteWithSavedSearch(cmd: string)
  var ch = histnr('search')
  In_place(cmd)

  while ch != histnr('search')
    histdel('search', -1) 
  endwhile

  @/ = histget('search', -1)
enddef

##
# Clean trailing whitespace from the range.
export def CleanWhitespace(line1: any, line2: any)
  var range = line1 == null ? '' :
    line2 == null ? string(line1) :
    string(line1) .. ',' .. string(line2)

  ExecuteWithSavedSearch(printf('%ss/\s\+$//e', range))
enddef

##
# Gets the value of {setting}, checking for a buffer override then a global
# value. That is, {setting} will be pulled from |b:|, then |g:|. A [default]
# value may be provided.
export def GetSetting(name: string, default: any = null): any
  return get(b:, name, get(g:, name, default))
enddef

##
# Execute the normal mode {motion} and return the text that it marks. For this
# to work, the {motion} must include a visual mode key (`V`, `v`, or `gv`).
#
# Both the 'z' register and the original cursor position will be restored
# after the text is yanked.
export def GetMotion(motion: string): string
  var cursor = getpos('.')
  var reg = getreg('z')
  var regtype = getregtype('z')

  execute 'normal!' a:motion . '"zy'

  text = @z

  setreg('z', reg, regtype)
  setpos('.', cursor)

  return text
enddef

##
# Programmatically jump to the window identified by {bufname}.
export def SwitchWindow(bufname: string)
  var nr = bufwinnr(bufname)

  if nr >= 0
    execute printf(':%dwincmd w', nr)
  endif
enddef

##
# Returns a base XDG path. The {type} must be provided and must be one of
# {data}, {config}, or {runtime}. Additional arguments will be appended to
# the path.
#
# This will produce results on Windows, but they will not be meaningful to
# how Windows directories are structured.
export def XdgBase(type: string, parts: list<string> = []): string
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

  base->extend(parts)

  return base->join('/')
enddef

##
# Returns the vim XDG path requested. The {type} must be provided and must be
# one of data, config, or runtime. Additional arguments will be appended to
# the path.
#
# This will produce results on Windows, but they will not be meaningful to how
# Windows directories are structured.
export def XdgPath(type: string, parts: list<string>): string
  return XdgBase(type, ['vim']->extend(parts))
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
