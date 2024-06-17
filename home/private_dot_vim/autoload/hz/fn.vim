vim9script

## 
# Add a copy of {item} to a copy of {list}. See |add()|.
export def hz#fn#add(list: list<any>, item: any): list<any>
  return list->deepcopy()->add(item->deepcopy())
enddef

##
# Merge {expr2} to a copy of {expr1}. See |extend()|.
export def hz#fn#extend(expr1: any, expr2: any, expr3: any): any
  if expr3 ==# null
    return expr1->deepcopy()->extend(expr2->deepcopy())
  else
    return expr1->deepcopy()->extend(expr2->deepcopy(), expr3) 
  endif
enddef

##
# Remove items from a copy of {expr1} using {expr2}. See |filter()|.
export def hz#fn#filter(expr1: any, expr2: any): any
  return expr1->deepcopy()->filter(expr2)
enddef

##
# @usage {list} {index} [default]
# Get a copy of the item at {index} from |List| {list}, returning [default] if
# it is not available.
#
# @usage {dict} {key} [default]
# Get an copy of the item with key {key} from |Dictionary| {dict}, returning
# [default] if it is not available.
#
# @usage {func} {what}
# Get an item {what} from Funcref {func}.
#
# @all
# See |get()|.
export def hz#fn#get(expr: any, index: any, default: any = null): any
  if expr->type() == v:t_func
    return expr->get(index)
  else
    return expr->get(index, default)->deepcopy()
  endif
enddef

##
# Insert a copy of {item} into a copy of {list}, at [index]. See |insert()|.
export def hz#fn#insert(list: list<any>, item: any, index: number = 0): list<any>
  return list->deepcopy()->insert(item->deepcopy(), index)
enddef

##
# @usage {list} {idx} [end]
# Removes and returns a copy of the item at {idx} in {list}. If [end] is
# present, removes and returns a list containing a copy of the items from {idx}
# to [end].
#
# @usage {dict} {key}
# Returns and removes a copy of the item with the key {key} in {dict}.
#
# @all
# This function is similar to |remove()|, but has a different return signature
# (`[item, copy]` or `[[item, ...], copy]`) so that the immutability of the
# list or dictionary is maintained.
export def hz#fn#remove(collection: any, index: any, endval: any = null): list<any>
  var newCollection = collection->deepcopy()

  if newCollection->type() == t:v_dict
    return [newCollection->remove(index)->deepcopy(), newCollection]
  else
    return [newCollection->remove(index, endval)->deepcopy(), newCollection]
  endif
enddef

##
# Return a reversed copy of {list}. See |reverse()|.
export def hz#fn#reverse(list: any): any
  return list->deepcopy()->reverse()
enddef

##
# @usage {list} [func] [dict]
# Return a sorted copy of {list}. See |sort()|.
export def hz#fn#sort(list: list<any>, how: any = null, self: any = null): list<any>
  var newList = list->deepcopy()

  if self != null
    return newList->sort(how, self)
  elseif how != null
    return newList->sort(how)
  else
    return newList->sort()
  endif
enddef

##
# @usage {list} [func] [dict]
# Return a copy of a list with second and succeeding copies of repeated
# adjacent list items in-place. See |uniq()|.
export def hz#fn#uniq(list: list<any>, how: any = null, self: any = null): list<any>
  var newList = list->deepcopy()

  if self != null
    return newList->uniq(how, self)
  elseif how != null
    return newList->uniq(how)
  else
    return newList->uniq()
  endif
enddef

##
# Return a copy of the keys of {dict}. See |keys()|.
export def hz#fn#keys(dict: dict<any>): list<string>
  return dict->keys()->deepcopy()
enddef

##
# Return a copy of the values of {dict}. See |values()|.
export def hz#fn#values(dict: dict<any>): list<any>
  return dict->values()->deepcopy()
enddef

##
# Returns a list with a copy of all the key-value pairs of {dict}. Each item
# is a list containing the key and the corresponding value. See |items()|.
export def hz#fn#items(dict: dict<any>): list<list<any>>
  dict->deepcopy()->items()
enddef

##
# @usage {list} {idx} {item}
# Returns a copy of {list} where the item at {index} is a copy of {item}.
#
# @usage {dict} {key} {value}
# Returns a copy of {dict} where the item with key {key} is a copy of {item}.
export def hz#fn#replace(collection: any, index: any, value: any): any
  var result = collection->deepcopy()
  result[index] = value->deepcopy()
  return result
enddef

##
# @usage {list} {idx}
# Returns a copy of {list} where the item at {index} has been removed.
#
# @usage {dict} {key}
# Returns a copy of {dict} where the item with key {key} has been removed.
export def hz#fn#pop(collection: any, index: any): any
  var result = collection->deepcopy()
  collection->remove(index)
  return collection
enddef

##
# If {expr} is a list, returns {expr}. Otherwise, it wraps {expr} in a list.
export def hz#fn#wrap(expr: any): any
  if type(expr) == v:t_list
    return expr
  else
    return [expr]
  endif
endfunction

##
# @usage {list...}
# Return a flattened copy of {list...}.
export def hz#fn#flatten(...list: any): list<any>
  var flat: list<any> = []
  var items: list<any> = list->deepcopy()

  while !empty(items)
    var item = remove(list, 0)

    if type(item) == v:t_list
      item->extend(items)
    else
      flat->add(item)
    endif
  endwhile

  return flat
enddef

##
# Returns a copy of {expr1} that has each item replaced with the result of
# evaluating {expr2}. See |map()|.
export def hz#fn#map(expr1: any, expr2: any): any
  return expr1->deepcopy()->map(expr2)
enddef

##
# Returns a copy of {expr1} containing items where {expr2} is false. See
# |filter()|.
export def hz#fn#reject(expr1: any, Expr2: any): any
  var negated = type(Expr2) == v:t_string ? printf('!(%s)', Expr2) :
    (k, v) => !Expr2(k, v)

  return expr1->deepcopy()->filter(negated)
enddef

##
# @usage {expr} [initial] {Fn}
# Loops over the items in {expr} (which must be a |List| or |Dictionary|) and
# executes {Fn}. If [initial] is not provided, the first item in {expr} is
# used as the initial value. The default [initial] value for a dictionary is an
# empty dictionary.
#
# When {expr} is empty, the [initial] value will be returned.
#
# {Fn} must be a function reference or lambda that returns the accumulator
# (`acc`) value. If {expr} is a |List|, {Fn} must accept two arguments (`val`
# and `acc`). If {expr} is a |Dict|, {Fn} must accept three arguments (`key`,
# `val`, and `acc`). Unlike |map()| and |filter()|, {Fn} may not be a string
# value (there is no easy way to simulate a `v:acc` parameter).
export def hz#fn#reduce(expr: any, initial: any, fn: any = null): any
  var collection = expr->deepcopy()
  var Fn: Funcref
  var acc: any

  if fn == null
    Fn = Ref(initial)
    acc = type(collection) == v:t_dict ? {} : remove(collection, 0)
  else
    Fn = Ref(fn)
    acc = initial->deepcopy()
  endif

  if type(Fn) != v:t_func
    throw 'hz#fn#reduce requires a function name or reference.'
  endif

  if type(collection) == v:t_dict
    for [k, v] in items(collection)
      acc = Fn(k, v, acc)
    endfor
  else
    for v in collection 
      acc = Fn(v, acc) 
    endfor
  endif

  return acc
enddef

##
# Loops over the items in {expr} and executes {Fn}, returning true if {Fn} is
# true for any value in {expr}. The value of {Fn} is the same as can be found
# for |filter()|.
#
# If {Fn} is a string that is not the name of a function, this function will
# be slower than if it is a function name or a function reference.
export def hz#fn#any(expr: any, fn: any): bool
  var collection = expr->deepcopy()
  var Fn = Ref(fn)

  if type(Fn) == v:t_func
    if type(collection) == v:t_dict
      for [k, v] in items(collection)
        if Fn(k, v)
          return true
        endif
      endfor
    else
      for v in collection
        if Fn(v)
          return true
        endif
      endfor
    endif

    return false
  endif

  return !(collection->filter(Fn)->empty())
enddef

##
# Loops over the items in {expr} and executes {Fn}, returning false if {Fn} is
# true for any value in {expr}. The value of {Fn} is the same as can be found
# for |filter()|.
#
# If {Fn} is a string that is not the name of a function, this function will
# be slower than if it is a function name or a function reference.
export def hz#fn#none(expr: any, fn: any): bool
  return !hz#fn#any(expr, fn)
enddef

##
# Loops over the items in {expr} and executes {Fn}, returning false if {Fn} is
# false for any value in {expr}. The value of {Fn} is the same as can be found
# for |filter()|.
#
# If {Fn} is a string that is not the name of a function, this function will
# be slower than if it is a function name or a function reference.
export def hz#fn#all(expr: any, fn: any): bool
  var Fn = Ref(fn)

  Fn = type(Fn) == v:t_string ? printf('!(%s)', Fn) : (k, v) => !Fn(k, v)

  return !hz#fn#any(expr, Fn)
endfunction

def Ref(fn: any): any
  return type(fn) == v:t_string && Fn =~# '^\I\i+$' && exists('*' .. fn) ?
    function(fn) : fn
enddef
