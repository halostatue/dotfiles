scriptencoding utf-8

""
" Add {item} to a copy of {list}. See |add()|.
function! hz#fn#add(list, item) abort
  return add(deepcopy(a:list), deepcopy(a:item))
endfunction

""
" Merge {expr2} to a copy of {expr1}. See |extend()|.
function! hz#fn#extend(expr1, expr2, ...) abort
  let l:expr1 = deepcopy(a:expr1)
  let l:expr2 = deepcopy(a:expr2)
  if a:0
    return extend(l:expr1, l:expr2, a:1)
  else
    return extend(l:expr1, l:expr2)
  endif
endfunction

""
" Remove items from a copy of {expr1} using {expr2}. See |filter()|.
function! hz#fn#filter(expr1, expr2) abort
  return filter(deepcopy(a:expr1), a:expr2)
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
function! hz#fn#get(expr, index, ...) abort
  if type(a:expr) == v:t_func
    return get(a:expr, a:index)
  elseif a:0
    return deepcopy(get(a:expr, a:index, a:1))
  else
    return deepcopy(get(a:expr, a:index))
  endif
endfunction

""
" Insert {item} into a copy of {list}, at [index]. See |insert()|.
" @default index = 0
function! hz#fn#insert(list, item, ...) abort
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
function! hz#fn#remove(collection, index, ...) abort
  let l:collection = deepcopy(a:collection)
  if type(l:collection) == t:v_dict || !a:0
    return [deepcopy(remove(l:collection, a:index)), l:collection]
  else
    return [deepcopy(remove(l:collection, a:index, a:1)), l:collection]
  endif
endfunction

""
" Return a reversed copy of {list}. See |reverse()|.
function! hz#fn#reverse(list) abort
  return reverse(deepcopy(a:list))
endfunction

""
" @usage {list} [func] [dict]
" Return a sorted copy of {list}. See |sort()|.
function! hz#fn#sort(list, ...) abort
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
function! hz#fn#uniq(list, ...) abort
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
" Note that there is no hz#fn#keys() because dictionary keys are essentially
" immutable in Vim as they can only be strings.
function! hz#fn#values(dict) abort
  return deepcopy(values(a:dict))
endfunction

""
" @usage {list} {idx} {item}
" Returns a copy of {list} where the item at {index} is a copy of {item}.
"
" @usage {dict} {key} {value}
" Returns a copy of {dict} where the item with key {key} is a copy of {item}.
function! hz#fn#replace(collection, index, value) abort
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
function! hz#fn#pop(collection, index) abort
  let l:collection = deepcopy(a:collection)
  call remove(l:collection, a:index)
  return l:collection
endfunction

""
" If {expr} is a list, returns {expr}. Otherwise, it wraps {expr} in a list.
function! hz#fn#wrap(expr) abort
  if type(a:expr) == v:t_list
    return a:expr
  else
    return [a:expr]
  endif
endfunction

""
" @usage {list...}
" Return a flattened copy of {list...}.
function! hz#fn#flatten(list, ...) abort
  let l:flat = []
  let l:list = extend(hz#fn#wrap(deepcopy(a:list)), deepcopy(a:000))
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
" Returns a copy of {expr1} that has each item replaced with the result of
" evaluating {expr2}. See |map()|.
function! hz#fn#map(expr1, expr2) abort
  return map(deepcopy(a:expr1), a:expr2)
endfunction

""
" Returns a copy of {expr1} containing items where {expr2} is true. See
" |filter()|.
function! hz#fn#filter(expr1, expr2) abort
  return filter(deepcopy(a:expr1), a:expr2)
endfunction

""
" Returns a list with a copy of all the key-value pairs of {dict}. Each item is
" a list containing the key and the corresponding value. See |items()|.
function! hz#fn#items(dict) abort
  return items(deepcopy(a:dict))
endfunction

""
" Returns a copy of {expr1} containing items where {expr2} is false. See
" |filter()|.
function! hz#fn#reject(expr1, expr2) abort
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
function! hz#fn#reduce(expr, initial, ...) abort
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

  let l:Fn = hz#fn#_ref(l:Fn)
  if type(l:Fn) != v:t_func
    throw 'hz#fn#reduce requires a function name or reference.'
  endif

  if type(l:expr) == v:t_dict
    for [l:k, l:v] in items(l:expr) | let l:a = l:Fn(l:k, l:v, l:a) | endfor
  else
    for l:v in l:expr | let l:a = l:Fn(l:v, l:a) | endfor
  endif

  return l:a
endfunction

""
" Loops over the items in {expr} and executes {Fn}, returning true if {Fn} is
" true for any value in {expr}. The value of {Fn} is the same as can be found
" for |filter()|.
"
" If {Fn} is a string that is not the name of a function, this function will be
" slower than if it is a function name or a function reference.
function! hz#fn#any(expr, Fn) abort
  let l:expr = deepcopy(a:expr)
  let l:Fn = hz#fn#_ref(a:Fn)

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
" Loops over the items in {expr} and executes {Fn}, returning false if {Fn} is
" true for any value in {expr}. The value of {Fn} is the same as can be found
" for |filter()|.
"
" If {Fn} is a string that is not the name of a function, this function will be
" slower than if it is a function name or a function reference.
function! hz#fn#none(expr, Fn) abort
  return !hz#fn#any(a:expr, a:Fn)
endfunction

""
" Loops over the items in {/expr} and executes {Fn}, returning false if {Fn} is
" false for any value in {expr}. The value of {Fn} is the same as can be found
" for |filter()|.
"
" If {Fn} is a string that is not the name of a function, this function will be
" slower than if it is a function name or a function reference.
function! hz#fn#all(expr, Fn) abort
  let l:expr = deepcopy(a:expr)
  let l:Fn = hz#fn#_ref(a:Fn)

  if type(l:Fn) == v:t_func
    if type(l:expr) == v:t_dict
      let l:Fn = { k, v -> !l:Fn(k, v) }
    else
      let l:Fn = { v -> !l:Fn(v) }
    endif
  else
    let l:Fn = printf('!(%s)', l:Fn)
  endif

  return !hz#fn#any(l:expr, l:Fn)
endfunction

function! hz#fn#_ref(Fn) abort
  if type(a:Fn) == v:t_string && a:Fn =~# '^\I\i+$' && exists('*' . a:Fn)
    return function(a:Fn)
  else
    return a:Fn
  endif
endfunction
