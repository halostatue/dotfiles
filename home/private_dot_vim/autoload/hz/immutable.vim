scriptencoding utf-8

import 'hz/immutable.vim'

function! hz#immutable#add(object, expr) abort
  return s:immutable.Add(a:object, a:expr)
endfunction

function! hz#immutable#extend(expr1, expr2, expr3 = v:null) abort
  return s:immutable.Extend(a:expr1, a:expr2, a:expr3)
endfunction

function! hz#immutable#filter(expr1, expr2) abort
  return s:immutable.Filter(a:expr1, a:expr2)
endfunction

function! hz#immutable#get(expr, index, default = v:null) abort
  return s:immutable.Get(a:expr, a:index, a:default)
endfunction

function! hz#immutable#insert(object, item, idx = 0) abort
  return s:immutable.Insert(a:object, a:item, a:idx)
endfunction

function! hz#immutable#remove(object, idx, end = v:null) abort
  return s:immutable.Remove(a:object, a:idx, a:end)
endfunction

function! hz#immutable#reverse(object) abort
  return s:immutable.Reverse(a:object)
endfunction

function! hz#immutable#sort(list, how = v:null, self = v:null) abort
  return s:immutable.Sort(a:list, a:how, a:self)
endfunction

function! hz#immutable#uniq(list, func = v:null, self = v:null) abort
  return s:immutable.Uniq(a:list, a:func, a:self)
endfunction

function! hz#immutable#keys(dict) abort
  return s:immutable.Keys(a:dict)
endfunction

function! hz#immutable#values(dict) abort
  return s:immutable.Values(a:dict)
endfunction

function! hz#immutable#items(dict) abort
  return s:immutable.Items(a:dict)
endfunction

function! hz#immutable#replace(collection, idx, value) abort
  return s:immutable.Replace(a:collection, a:idx, a:value)
endfunction

function! hz#immutable#remove_item(collection, index) abort
  return s:immutable.RemoveItem(a:collection, a:index)
endfunction

function! hz#immutable#wrap(value) abort
  return s:immutable.Wrap(a:value)
endfunction

function! hz#immutable#flatten(list, maxdepth = v:null) abort
  return s:immutable.Flatten(a:list, a:maxdepth)
endfunction

function! hz#immutable#map(expr1, expr2) abort
  return s:immutable.Map(a:expr1, a:expr2)
endfunction

function! hz#immutable#reject(expr1, expr2) abort
  return s:immutable.Reject(a:expr1, a:expr2)
endfunction

function! hz#immutable#reduce(expr, reducer, initial = v:null) abort
  return s:immutable.Reduce(a:expr, a:reducer, a:initial)
endfunction

function! hz#immutable#any(expr, fn) abort
  return s:immutable.Any(a:expr, a:fn)
endfunction

function! hz#immutable#none(expr, fn) abort
  return s:immutable.None(a:expr, a:fn)
endfunction

function! hz#immutable#all(expr, fn) abort
  return s:immutable.All(expr, fn)
endfunction
