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

export def Reverse(object: any): any
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

export def Reduce(expr: any, Fn: func(any, any): any, initial: any = null): any
  if expr->type() == v:t_dict()
    var default: dict<any> = {}
    return reduce(Items(expr), Fn, initial == null ? default : initial->deepcopy())
  elseif initial == null
    return reduce(expr->deepcopy(), Fn)
  else
    return reduce(expr->deepcopy(), Fn, initial->deepcopy())
  endif
enddef

export def Any(expr: any, Fn: func(any): bool): bool
  if expr->empty()
    return false
  endif

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

  return false
enddef

export def None(expr: any, Fn: func(any): bool): bool
  if expr->empty()
    return true
  endif

  return !Any(expr, Fn)
enddef

export def All(expr: any, Fn: func(any): bool): bool
  if expr->empty()
    return true
  endif

  return Any(expr, (v: any): bool => !Fn(v))
enddef

def Ref(fn: any): any
  return fn->type() == v:t_string && exists('*' .. fn)
    ? function(fn)
    : fn
enddef
