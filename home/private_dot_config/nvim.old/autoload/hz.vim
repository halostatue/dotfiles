scriptencoding utf-8

""
" @section Introduction, introduction
" @stylized Hz.vim
" @library
" @order introduction config functions compatibility licence
"
" @plugin(stylized) is a collection of functions and commands that power
" Austin Ziegler's vim configuration.

""
" @section Compatibility
"
" All of the functions in @plugin are known to work with MacVim 8.1. Most of
" them will work on older Vim versions, other platforms, or NeoVim, but
" compatibility is not guaranteed.

""
" @section Licence
"
" @plugin(stylized) is public domain where possible, or licensed under CC0 1.0
" where not. There are no warranties, implied or expressed, about this @plugin
" or its suitability or fitness for any particular purpose.
"
" See https://creativecommons.org/publicdomain/zero/1.0/legalcode for more
" information.

""
" Returns a string representing the underlying platform as @plugin understands
" it. Will be one of `windows`, `cygwin`, `mac`, or `unix`.
function! hz#platform() abort
  if hz#is('windows')
    return 'windows'
  elseif hz#is('cygwin')
    return 'cygwin'
  elseif hz#is('mac')
    return 'mac'
  else
    return 'unix'
  endif
endfunction

""
" Returns true if the underlying status is the {type} declared. An
" unknown type returns false. Supported values for {type} are: cygwin, mac,
" macgui, neovim, nvim, sudo, tmux, vim, windows.
function! hz#is(type) abort
  return s:is[a:type]
endfunction

""
" Report whether the function in {varname} provided exists, and if so,
" contains a valid function name. The function name may be a bare name (`fn`)
" or have parentheses at the end (`fn()`).
function! hz#valid_function(varname) abort
  return exists(a:varname) && exists('*' . substitute(eval(a:varname), '()$', '', ''))
endfunction

""
" Make {path}, prompting unless [force] is provided. Returns the path.
function! hz#mkpath(path, ...) abort
  if !isdirectory(a:path) && &l:buftype ==# '' &&
        \ ((a:0 && a:1) ||
        \  input(printf('"%s" does not exist; create? [y/N]', a:path)) =~? '^y')
    call mkdir(iconv(a:path, &encoding, &termencoding), 'p')
  endif

  return a:path
endfunction

""
" Portably produce a proper ISO 8601/RFC3339 timestamp. If [time] is not
" provided, the current time will be used.
function! hz#isotime(...) abort
  if a:0
    let l:zone = strftime('%z', a:1)
  else
    let l:zone = strftime('%z')
  endif

  let l:zone = substitute(l:zone, '\([-+]\)\(\d\{2}\)\(\d\{2}\)', '\1\2:\3', '')

  if a:0
    return printf('%s%s', strftime('%Y-%m-%dT%H:%M:%S', a:1), l:zone)
  else
    return printf('%s%s', strftime('%Y-%m-%dT%H:%M:%S'), l:zone)
  endif
endfunction

""
" @usage [dict] [default] Func [args]
"
" Try to call the given [Func] with an optional dictionary, default, and
" arguments.
"
"     hz#try('fugitive#statusline')
"     hz#try(function('fugitive#statusline'))
"
" If [Func] is a dictionary function (and not a partial function reference),
" it is necessary to provide the [dict] parameter to properly provide `self`.
"
"     hz#try({}, 'dict.Func')
"
" A [default] value may be provided before the function reference, if it is
" inside of a list.
"
"     hz#try(['default'], 'F')
"
" Arguments are passed after the function name or reference.
"
"     hz#try(['default'], 'F', 1, 2, 3)
"
" This function is originally by Tim Pope as part of Flagship.
"
" @default default=''
" @default dict={}
" @default args=[]
function! hz#try(...) abort
  let l:args = copy(a:000)
  let l:dict = {}
  let l:default = ''

  if type(get(l:args, 0)) == v:t_dict | let l:dict = remove(l:args, 0) | endif
  if type(get(l:args, 0)) == v:t_list | let l:default = remove(l:args, 0)[0] | endif
  if empty(l:args) | return l:default | endif

  let l:Func = remove(l:args, 0)
  if type(l:Func) == v:t_func || exists('*' . l:Func)
    return call(l:Func, l:args, l:dict)
  else
    return l:default
  endif
endfunction

""
" Add {item} to a copy of {list}. See |add()|.
function! hz#add(list, item) abort
  return add(deepcopy(a:list), deepcopy(a:item))
endfunction

""
" Insert {item} into a copy of {list}, at [index]. See |insert()|.
" @default index = 0
function! hz#insert(list, item, ...) abort
  let l:list = deepcopy(a:list)
  let l:item = deepcopy(a:item)
  if a:0
    return insert(l:list, l:item, a:1)
  else
    return insert(l:list, l:item)
  endif
endfunction

""
" @usage {list} {idx} [end]
" Removes and returns a copy of the item at {idx} in {list}. If [end] is
" present, removes and returns a list containing a copy of the items from {idx}
" to [end].
"
" @usage {dict} {key}
" Returns and removes a copy of the item with the key {key} in {dict}.
"
" @all
" This function is similar to |remove()|, but has a different return signature
" (`[item, copy]` or `[[item, ...], copy]`) so that the immutability of the
" list or dictionary is maintained.
function! hz#remove(collection, index, ...) abort
  let l:collection = deepcopy(a:collection)
  if type(l:collection) == t:v_dict || !a:0
    return [deepcopy(remove(l:collection, a:index)), l:collection]
  else
    return [deepcopy(remove(l:collection, a:index, a:1)), l:collection]
  endif
endfunction

""
" Merge {expr2} to a copy of {expr1}. See |extend()|.
function! hz#extend(expr1, expr2, ...) abort
  let l:expr1 = deepcopy(a:expr1)
  let l:expr2 = deepcopy(a:expr2)
  if a:0
    return extend(l:expr1, l:expr2, a:1)
  else
    return extend(l:expr1, l:expr2)
  endif
endfunction

""
" Returns a copy of {expr1} containing items where {expr2} is true. See
" |filter()|.
function! hz#filter(expr1, expr2) abort
  return filter(deepcopy(a:expr1), a:expr2)
endfunction

""
" Return a reversed copy of {list}. See |reverse()|.
function! hz#reverse(list) abort
  return reverse(deepcopy(a:list))
endfunction

""
" @usage {list} [func] [dict]
" Return a sorted copy of {list}. See |sort()|.
function! hz#sort(list, ...) abort
  let l:list = deepcopy(a:list)
  if a:0 > 1
    return sort(l:list, a:1, a:2)
  elseif a:0
    return sort(l:list, a:1)
  else
    return sort(l:list)
  endif
endfunction

""
" @usage {list} [func] [dict]
" Return a copy of a list with second and succeeding copies of repeated
" adjacent list items in-place. See |uniq()|.
function! hz#uniq(list, ...) abort
  let l:list = deepcopy(a:list)
  if a:0 > 1
    return uniq(l:list, a:1, a:2)
  elseif a:0
    return uniq(l:list, a:1)
  else
    return uniq(l:list)
  endif
endfunction

""
" Return a copy of the values of {dict}. See |values()|.
"
" Note that there is no hz#keys() because dictionary keys are essentially
" immutable in Vim as they can only be strings.
function! hz#values(dict) abort
  return deepcopy(values(a:dict))
endfunction

""
" Returns a copy of {expr1} that has each item replaced with the result of
" evaluating {expr2}. See |map()|.
function! hz#map(expr1, expr2) abort
  return map(deepcopy(a:expr1), a:expr2)
endfunction

""
" Returns a list with a copy of all the key-value pairs of {dict}. Each item is
" a list containing the key and the corresponding value. See |items()|.
function! hz#items(dict) abort
  return items(deepcopy(a:dict))
endfunction

""
" Returns a copy of {expr1} containing items where {expr2} is false. See
" |filter()|.
function! hz#reject(expr1, expr2) abort
  let l:expr1 = deepcopy(a:expr1)
  if type(a:expr2 == v:t_string)
    return filter(l:expr1, printf('!(%s)', a:expr2))
  elseif type(l:expr1 == v:t_dict)
    return filter(l:expr1, { k, v -> !a:expr2(k, v) })
  else
    return filter(l:expr1, { v -> !a:expr2(k, v) })
  endif
endfunction

""
" @usage {expr} [initial] {Fn}
" Loops over the items in {expr} (which must be a |List| or |Dictionary|) and
" executes {Fn}. If [initial] is not provided, the first item in {expr} is
" used as the initial value. The default [initial] value for a dictionary is an
" empty dictionary.
"
" When {expr} is empty, the [initial] value will be returned.
"
" {Fn} must be a function reference or lambda that returns the accumulator
" (`acc`) value. If {expr} is a |List|, {Fn} must accept two arguments (`val`
" and `acc`). If {expr} is a |Dict|, {Fn} must accept three arguments (`key`,
" `val`, and `acc`). Unlike |map()| and |filter()|, {Fn} may not be a string
" value (there is no easy way to simulate a `v:acc` parameter).
function! hz#reduce(expr, initial, ...) abort
  let l:expr = deepcopy(a:expr)
  if a:0
    let l:Fn = a:1
    let l:a = deepcopy(a:initial)
  else
    let l:Fn = a:initial
    if type(l:expr) == v:t_dict
      let l:a = {}
    else
      let l:a = remove(l:expr, 0)
    endif
  endif

  let l:Fn = hz#_ref(l:Fn)
  if type(l:Fn) != v:t_func
    throw 'hz#reduce requires a function name or reference.'
  endif

  if type(l:expr) == v:t_dict
    for [l:k, l:v] in items(l:expr) | let l:a = l:Fn(l:k, l:v, l:a) | endfor
  else
    for l:v in l:expr | let l:a = l:Fn(l:v, l:a) | endfor
  endif

  return l:a
endfunction

""
" Loops over the items in {/expr} and executes {Fn}, returning false if {Fn} is
" false for any value in {expr}. The value of {Fn} is the same as can be found
" for |filter()|.
"
" If {Fn} is a string that is not the name of a function, this function will be
" slower than if it is a function name or a function reference.
function! hz#all(expr, Fn) abort
  let l:expr = deepcopy(a:expr)
  let l:Fn = hz#_ref(a:Fn)

  if type(l:Fn) == v:t_func
    if type(l:expr) == v:t_dict
      let l:Fn = { k, v -> !l:Fn(k, v) }
    else
      let l:Fn = { v -> !l:Fn(v) }
    endif
  else
    let l:Fn = printf('!(%s)', l:Fn)
  endif

  return !hz#any(l:expr, l:Fn)
endfunction


""
" Loops over the items in {expr} and executes {Fn}, returning false if {Fn} is
" true for any value in {expr}. The value of {Fn} is the same as can be found
" for |filter()|.
"
" If {Fn} is a string that is not the name of a function, this function will be
" slower than if it is a function name or a function reference.
function! hz#none(expr, Fn) abort
  return !hz#any(a:expr, a:Fn)
endfunction


""
" Loops over the items in {expr} and executes {Fn}, returning true if {Fn} is
" true for any value in {expr}. The value of {Fn} is the same as can be found
" for |filter()|.
"
" If {Fn} is a string that is not the name of a function, this function will be
" slower than if it is a function name or a function reference.
function! hz#any(expr, Fn) abort
  let l:expr = deepcopy(a:expr)
  let l:Fn = hz#_ref(a:Fn)

  if type(l:Fn) == v:t_func
    if type(l:expr) == v:t_dict
      for [l:k, l:v] in items(l:expr) |
        if l:Fn(l:k, l:v) | return v:true | endif
      endfor
    else
      for l:v in l:expr
        if l:Fn(l:v) | return v:true | endif
      endfor
    endif

    return v:false
  endif

  return !empty(filter(l:expr, l:Fn))
endfunction

""
" @usage {list} {idx} {item}
" Returns a copy of {list} where the item at {index} is a copy of {item}.
"
" @usage {dict} {key} {value}
" Returns a copy of {dict} where the item with key {key} is a copy of {item}.
function! hz#replace(collection, index, value) abort
  let l:collection = deepcopy(a:collection)
  let l:collection[a:index] = deepcopy(a:value)
  return l:collection
endfunction

""
" @usage {list} {idx}
" Returns a copy of {list} where the item at {index} has been removed.
"
" @usage {dict} {key}
" Returns a copy of {dict} where the item with key {key} has been removed.
function! hz#pop(collection, index) abort
  let l:collection = deepcopy(a:collection)
  call remove(l:collection, a:index)
  return l:collection
endfunction

""
" If {expr} is a list, returns {expr}. Otherwise, it wraps {expr} in a list.
function! hz#wrap(expr) abort
  if type(a:expr) == v:t_list
    return a:expr
  else
    return [a:expr]
  endif
endfunction

""
" @usage {list...}
" Return a flattened copy of {list...}.
function! hz#flatten(list, ...) abort
  let l:flat = []
  let l:list = extend(hz#wrap(deepcopy(a:list)), deepcopy(a:000))
  while !empty(l:list)
    let l:item = remove(l:list, 0)
    if type(l:item) == v:t_list
      let l:list = extend(l:item, l:list)
    else
      call add(l:flat, l:item)
    endif
  endwhile
  return l:flat
endfunction

""
" Answers if {needle} can be found in the provided {haystack} which may be a
" string, list, or dictionary (where is searches the values).
"
" If {haystack} is a string, but {needle} is not, returns false.
" If {haystack} is neither a string, list, nor dictionary, returns false.
function! hz#in(haystack, needle) abort
  if type(a:haystack) == v:t_string
    return type(a:needle) == v:t_string && strdix(a:haystack, a:needle) != -1
  elseif type(a:haystack) == v:t_list
    return index(a:haystack, a:needle) != -1
  elseif type(a:haystack) == v:t_dict
    return index(values(a:haystack), a:needle) != -1
  endif

  return v:false
endfunction

""
" Trims leading [pattern] from {string}.
"
" @default pattern='\_s' The regex for whitespace and newlines.
function! hz#trim_leading(string, ...) abort
  return substitute(a:string, printf('^%s\+', a:0 ? a:1 : '\_s'), '', '')
endfunction

""
" Trims trailing [pattern] from {string}.
"
" @default pattern='\_s' The regex for whitespace and newlines.
function! hz#trim_trailing(string, ...) abort
  let l:pattern = '\_s\+$'
  if a:0 == 1 | let l:pattern = a:1 . '\+$' | endif
  return substitute(a:string, printf('%s\+$', l:pattern), '', '')
endfunction

""
" Trims both leading and trailing [pattern] from {string}.
"
" @default pattern='\_s' The regex for whitespace and newlines.
function! hz#trim(string, ...) abort
  let l:pattern = a:0 ? a:1 : '\_s'
  return hz#trim_trailing(hz#trim_leading(a:string, l:pattern), l:pattern)
endfunction

""
" Executes {command} while saving and restoring the window state.
function! hz#in_place(command) abort
  let l:saved_view = winsaveview()
  execute a:command
  call winrestview(l:saved_view)
endfunction

""
" Executes {command} while saving and restoring the most recent saved search
" history and the window state.
function! hz#with_saved_search(command) abort
  let l:ch = histnr('search')
  call hz#in_place(a:command)
  while l:ch != histnr('search') | call histdel('search', -1) | endwhile
  let @/ = histget('search', -1)
endfunction

""
" Clean trailing whitespace from the range.
function! hz#clean_whitespace() abort range
  call hz#with_saved_search(a:firstline . ',' . a:lastline . 's/\s\+$//e')
endfunction

""
" Loop over the range of text and remove duplicate lines without changing the
" sort order. Originally by Damian Conway, presented in Scripting the Vim
" Editor, Part 4 at IBM developerWorks.
"
" https://www.ibm.com/developerworks/library/l-vim-script-4/index.html
"
" Add mappings:
"
"     nmap ;u :%call hz#range_uniq()<CR>
"
"     vmap u :call hz#range_uniq()<CR>
function! hz#range_uniq() range abort
  let l:seen = {}
  let l:uniq = []

  for l:line in getline(a:firstline, a:lastline)
    let l:normalized = '>' . l:line
    if !has_key(l:seen, l:normalized)
      call add(l:uniq, l:line)
      let l:seen[l:normalized] = 1
    endif
  endfor

  execute a:firstline . ',' . a:lastline . 'delete'
  call append(a:firstline - 1, l:uniq)
endfunction


""
" Gets the value of {setting}, checking for a buffer override then a global
" value. That is, {setting} will be pulled from |b:|, then |g:|. A [default]
" value may be provided.
function! hz#get_setting(setting, ...) abort
  return get(b:, a:setting, get(g:, a:setting, get(a:000, 0, '')))
endfunction

""
" @usage {list} {index} [default]
" Get a copy of the item at {index} from |List| {list}, returning [default] if
" it is not available.
"
" @usage {dict} {key} [default]
" Get an copy of the item with key {key} from |Dictionary| {dict}, returning
" [default] if it is not available.
"
" @usage {func} {what}
" Get an item {what} from Funcref {func}.
"
" @all
" See |get()|.
function! hz#get(expr, index, ...) abort
  if type(a:expr) == v:t_func
    return get(a:expr, a:index)
  elseif a:0
    return deepcopy(get(a:expr, a:index, a:1))
  else
    return deepcopy(get(a:expr, a:index))
  endif
endfunction

""
" Execute the normal mode {motion} and return the text that it marks. For this
" to work, the {motion} must include a visual mode key (`V`, `v`, or `gv`).
"
" Both the 'z' register and the original cursor position will be restored
" after the text is yanked.
function! hz#get_motion(motion) abort
  let l:cursor = getpos('.')
  let l:reg = getreg('z')
  let l:type = getregtype('z')

  execute 'normal!' a:motion . '"zy'

  let l:text = @z

  call setreg('z', l:reg, l:type)
  call setpos('.', l:cursor)

  return l:text
endfunction

""
" Run the normal mode {command} from line {start} to {end}, opening any folds.
function! hz#mark_visual(command, start, end) abort
  if a:start != line('.') | execute a:start | endif

  silent! execute printf('%d,%dfoldopen', a:start, a:end)

  if a:end > a:start
    execute 'normal!' a:command . (a:end - a:start) . 'jg_'
  else
    execute 'normal!' a:command . 'g_'
  endif
endfunction

""
" Programmatically jump to the window identified by {bufname}.
function! hz#switch_window(bufname) abort
  let l:nr = bufwinnr(a:bufname)
  if l:nr >= 0 | execute l:nr . 'wincmd w' | endif
endfunction

""
" Returns a |standard-path| with additional parameters appended as path
" components. The {type} must be provided and must be one of {data},
" {config}, {runtime}. The values {config_dirs} and {data_dirs} are supported
" but not recommended.
function! hz#stdpath(type, ...) abort
  let l:base = hz#_xdg_base(a:type)

  if empty(a:000)
    return l:base
  endif

  let l:extra = type(a:000[0]) == v:t_list ? a:000[0] : a:000

  if type(l:base) == v:t_list
    return map(copy(l:base), {_, value -> join(extend([value], l:extra), '/')})
  endif

  return join(extend([l:base], l:extra), '/')
endfunction

function! hz#xdg_base(type, ...) abort
  return hz#stdpath(a:type, a:000)
endfunction

if has('nvim')
  function! hz#_xdg_base(type) abort
    return stdpath(a:type)
  endfunction
else
  function! hz#_xdg_base(type)
    if a:type ==# 'data'
      return exists() ? $XDG_DATA_HOME : s:xdg_base[a:type]
    elseif a:type ==# 'config'
      return exists('$XDG_CONFIG_HOME') ? $XDG_CONFIG_HOME : s:xdg_base[a:type]
    elseif a:type ==# 'cache'
      return exists('$XDG_CACHE_HOME') ? $XDG_CACHE_HOME : s:xdg_base[a:type]
    elseif a:type ==# 'config_dirs' || a:type ==# 'data_dirs'
      let l:var = a:type ==# 'config_dirs' ? '$XDG_CONFIG_DIRS' : '$XDG_DATA_DIRS'

      if exists(l:var)
        return split(eval(l:var), hz#is('windows') ? ';' : ':')
      endif

      return []
    else
      throw 'Unknown stdpath type "' . a:type . '".'
    endif
  endfunction
endif

""
" Returns the vim or neovim XDG path requested. The {type} must be provided
" and must be one of data, config, or runtime. Additional arguments will be
" appended to the path.
"
" This will produce results on Windows, but they will not be meaningful to
" how Windows directories are structured.
function! hz#xdg_path(type, ...) abort
  let l:args = empty(a:000) ? [] : copy(a:000)

  if !has('nvim')
    call insert(l:args, 'vim')
  endif

  return hz#stdpath(a:type, l:args)
endfunction

""
" Determine whether the computer is running on battery or not.
function! hz#on_battery() abort
  if hz#is('windows') || hz#is('cygwin')
    return v:false
  elseif hz#is('mac')
    return system('pmset -g batt') =~? '''Battery Power'''
  elseif filereadable('/sys/class/power_supply/AC/online')
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  else
    return v:false
  endif
endfunction

""
" Encodes non-urlsafe values in {url} with percent hex-encoding (e.g., ' '
" becomes '%20'. Only the path and query parameters are encoded.
"
" Improves on a version ripped from haskellmode.vim by Andrew Radev (which
" encoded the entire URL).
function! hz#url_encode(url) abort
  let l:parts = split(a:url, '/', v:true)
  let l:index = l:parts[0] =~# '^https\=' ? 3 : 1
  let l:parts[l:index : ] =
        \ map(
        \   l:parts[l:index :],
        \   { _i, part ->
        \     substitute(
        \       part,
        \       '\([^-[:alnum:].=?&]\)',
        \       { m -> printf('%%%02X', char2nr(m[1])) },
        \       'g')
        \   })

  return join(l:parts, '/')
endfunction

""
" Decodes an encoded {url} back to plain-text.
"
" Based on a version ripped from unimpaired.vim by Andrew Radev.
function! hz#url_decode(url) abort
  let l:url = substitute(a:url, '%0[Aa]\n$', '%0A', '')
  let l:url = substitute(l:url, '%0[Aa]', '\n', 'g')
  let l:url = substitute(l:url, '+', ' ', 'g')
  return substitute(l:url, '%\(\x\x\)', { m -> nr2char('0x' . m[1]) }, 'g')
endfunction

function! hz#_vimscript_user_commands() abort
  redir => l:commands
  silent! command
  redir END

  let l:commands =
        \ join(
        \   map(
        \     split(l:commands, '\n')[1:],
        \     { _, v -> matchstr(v, '[!"b]*\s\+\zs\u\w*\ze') }))

  if empty(l:commands)
    return
  else
    execute 'syntax keyword vimCommand' l:commands
  endif
endfunction

function! hz#_omni(fn) abort
  if exists(printf('*%s', a:fn)) | let &l:omnifunc=a:fn | endif
endfunction

function! hz#_toggle_jk_mapping(...) abort
  let l:target_mode = a:0
        \ ? a:1 ==# 'alt' ? 'alt' : 'normal'
        \ : maparg('j', 'n') ==# 'gj'
        \ ? 'normal'
        \ : 'alt'

  if l:target_mode ==# 'normal'
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
endfunction

function! hz#_toggle_special_window(type) abort
  let l:w = winnr('$')
  execute s:toggle_window_commands[a:type].close
  if l:w == winnr('$')
    execute s:toggle_window_commands[a:type].open
    setlocal nowrap whichwrap=b,s
  endif
endfunction

function! hz#_synstack() abort
  return join(map(
        \ synstack(line('.'), col('.')), 'synIDattr(v:val, ''name'')'),
        \ ' > ')
endfunction

function! hz#_restore_paste_buffer() abort
  let @" = b:_paste_buffer
  return ''
endfunction

function! hz#_replace_paste_buffer() abort
  let s:restore_reg = @"
  return "p@=s:restore_register()\<cr>"
endfunction

function! hz#_ref(Fn) abort
  if type(a:Fn) == v:t_string && a:Fn =~# '^\I\i+$' && exists('*' . a:Fn)
    return function(a:Fn)
  else
    return a:Fn
  endif
endfunction

if !exists('s:toggle_window_commands')
  let s:toggle_window_commands =
        \ {
        \   'quickfix': { 'close': 'cclose', 'open': 'copen' },
        \   'location': { 'close': 'lclose', 'open': 'lopen' }
        \ }
  lockvar s:toggle_window_commands
endif

if !exists('s:is')
  let s:is = {}
  let s:is.windows = has('win16') || has('win32') || has('win64')
  let s:is.cygwin = has('win32unix')
  let s:is.mac = !s:is.windows && !s:is.cygwin
        \ && (has('mac') || has('macunix') || has('gui_macvim') ||
        \   (!executable('xdg-open') &&
        \     system('uname') =~? '^darwin'))
  let s:is.macgui = s:is.mac && has('gui_running')
  let s:is.neovim = has('nvim')
  let s:is.nvim = s:is.neovim
  let s:is.vim = !s:is.neovim
  let s:is.sudo = $SUDO_USER !=# '' && $USER !=# $SUDO_USER
        \       && $HOME !=# expand('~' . $USER)
        \       && $HOME ==# expand('~' . $SUDO_USER)
  let s:is.tmux = exists('$TMUX')

  lockvar s:is
endif

if !has('nvim') && !exists('s:xdg_base')

  if hz#is('windows')
    let s:xdg_base = {
          \   'cache': expand('~/AppData/Local/vim/cache'),
          \   'config': expand('~/AppData/Local/vim/config'),
          \   'config_dirs': [],
          \   'data': expand('~/AppData/Local/vim/data'),
          \   'data_dirs': [],
          \  }
  else
    let s:xdg_base = {
          \   'cache': expand('~/.cache'),
          \   'config': expand('~/.config'),
          \   'config_dirs': [],
          \   'data': expand('~/.local/share'),
          \   'data_dirs': [],
          \  }
  endif
endif
