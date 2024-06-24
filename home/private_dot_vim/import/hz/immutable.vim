vim9script

export def Add(object: any, expr: any): any
  return list->deepcopy()->add(item->deepcopy())
enddef

export def Extend(expr1: any, expr2: any, expr3: any = null): any
  if expr3 ==# null
    return expr1->deepcopy()->extend(expr2->deepcopy())
  else
    return expr1->deepcopy()->extend(expr2->deepcopy(), expr3) 
  endif
enddef

export def Get(expr: any, idx: any, default: any = null): any
  if expr->type() == v:t_func
    return expr->get(idx)
  else
    return expr->get(idx, default)->deepcopy()
  endif
enddef

export def Insert(list: any, item: any, idx: number = 0): any
  return list->deepcopy()->insert(item->deepcopy(), idx)
enddef

export def Remove(object: any, idx: any, end: any = null): any
  var newCollection = object->deepcopy()

  if newCollection->type() == t:v_dict || end == null
    return [newCollection->remove(idx)->deepcopy(), newCollection]
  else
    return [newCollection->remove(idx, end)->deepcopy(), newCollection]
  endif
enddef

export def Reverse(object): any
  return object->deepcopy()->reverse()
enddef

export def Sort(list: list<any>, how: any = null, dict: dict<any> = null_dict): list<any>
  var newList = list->deepcopy()

  if dict != null_dict
    return newList->sort(how, dict)
  elseif how != null
    return newList->sort(how)
  else
    return newList->sort()
  endif
enddef

export def Uniq(list: list<any>, func: any = null, dict: dict<any> = null_dict): list<any>
  var newList = list->deepcopy()

  if dict != null_dict
    return newList->uniq(func, dict)
  elseif func != null
    return newList->uniq(func)
  else
    return newList->uniq()
  endif
enddef

export def Keys(dict: dict<any>): list<string>
  return dict->keys()->deepcopy()
enddef

export def Values(dict: dict<any>): list<any>
  return dict->values()->deepcopy()
enddef

export def Items(dict: any): list<list<any>>
  return dict->items()->deepcopy()
enddef

export def Replace(object: any, idx: any, value: any): any
  var result = object->deepcopy()
  result[idx] = value->deepcopy()
  return result
enddef

export def RemoveItem(object: any, idx: any): any
  var result = object->deepcopy()
  object->remove(idx)
  return object
enddef

export def Wrap(expr: any): any
  return expr->type() == v:t_list ? expr->deepcopy() : [expr->deepcopy()]
enddef

export def Flatten(list: list<any>, maxdepth: any = null): list<any>
  return maxdepth == null
    ? list->deepcopy()->flattennew() 
    : list->deepcopy()->flattennew(maxdepth)
enddef

export def Map(expr1: any, expr2: any): any
  return expr1->deepcopy()->mapnew(expr2)
enddef

export def Filter(expr1: any, expr2: any): any
  return expr1->deepcopy()->filter(expr2)
enddef

export def Reject(expr1: any, Expr2: any): any
  return expr1->deepcopy()->filter(
    Expr2->type() == v:t_string
      ? printf('!(%s)', Expr2)
      : (k, v) => !Expr2(k, v)
  )
enddef

export def Reduce(expr: any, initial: any, fn: any = null): any
  var object = expr->deepcopy()
  var Fn: Funcref
  var acc: any

  if fn == null
    Fn = Ref(initial)
    acc = object->type() == v:t_dict ? {} : object->remove(0)
  else
    Fn = Ref(fn)
    acc = initial->deepcopy()
  endif

  if Fn->type() != v:t_func
    throw 'Reduce requires a function name or reference.'
  endif

  if expr->empty()
    return initial
  endif

  var arity = Fn->get('args')->length()

  if arity == 2
    if object->type() == v:t_dict
      for [k, v] in object->items()
        acc = Fn([k, v], acc)
      endfor
    else
      for v in object
        acc = Fn(v, acc)
      endfor
    endif
  elseif arity == 3
    for [k, v] in object->items()
      acc = Fn(k, v, acc)
    endfor
  else
    throw 'Invalid argument count for ' .. Fn
  endif

  return acc
enddef

export def Any(expr: any, fn: any): bool
  if expr->empty()
    return false
  endif

  var Fn = Ref(fn)

  if Fn->type() == v:t_func
    var arity = Fn->get('args')->length()

    if arity == 1
      if expr->type() == v:t_dict
        for [k, v] in Items(expr)
          if Fn([k, v])
            return true
          endif
        endfor
      else
        for v in expr->deepcopy()
          if Fn(v)
            return true
          endif
        endfor
      endif
    elseif arity == 2
      for [k, v] in Items(expr)
        if Fn(k, v)
          return true
        endif
      endfor
    else
      throw 'Invalid argument count for ' .. Fn
    endif

    return false
  endif

  return !Filter(expr, Fn)->empty()
enddef

export def None(expr: any, fn: any): bool
  if expr->empty()
    return true
  endif

  return !Any(expr, fn)
enddef

export def All(expr: any, fn: any): bool
  if expr->empty()
    return true
  endif

  var Fn = Ref(fn)

  if Fn->type() == v:t_func
    var arity = Fn->get('args')->length()

    if arity == 1
      if expr->type() == v:t_dict
        for [k, v] in Items(expr)
          if !Fn([k, v])
            return false
          endif
        endfor
      else
        for v in expr->deepcopy()
          if !Fn(v)
            return false
          endif
        endfor
      endif
    elseif arity == 2
      for [k, v] in Items(expr)
        if !Fn(k, v)
          return false
        endif
      endfor
    else
      throw 'Invalid argument count for ' .. Fn
    endif

    return true
  elseif Fn->type() == v:t_string
    return None(expr, printf('!(%s)', Fn))
  endif

  throw 'Invalid type ' .. typename(Fn) .. ' for ' .. Fn
enddef

def Ref(fn: any): any
  return fn->type() == v:t_string && exists('*' .. fn)
    ? function(fn)
    : fn
enddef
