scriptencoding utf-8

import 'hz.vim'

function! hz#platform() abort
  return s:hz.Platform()
endfunction

function! hz#is(type) abort
  return s:hz.Is(a:type)
endfunction

function! hz#valid_function(value) abort
  call s:hz.IsValidFunction(a:value)
endfunction

function! hz#mkpath(path, force = v:false) abort
  call s:hz.Mkpath(a:path, a:force)
endfunction

function! hz#isotime(time = v:null) abort
  return s:hz.Isotime(a:time)
endfunction

function! hz#try(...) abort
  return s:hz.Try(a:000)
endfunction

function! hz#in(haystack, needle) abort
  return s:hz.In(a:haystack, a:needle)
endfunction

function! hz#trim_leading(value, pattern = '\_s') abort
  return s:hz.TrimLeading(a:value, a:pattern)
endfunction
 
function! hz#trim_trailing(value, pattern = '\_s') abort
  return s:hz.TrimTrailing(a:value, a:pattern)
endfunction

function! hz#trim(value, pattern = '\_s') abort
  return s:hz.Trim(a:value, a:pattern)
endfunction

function! hz#execute_in_place(cmd) abort
  call s:hz.ExecuteInPlace(a:cmd)
endfunction

function! hz#execute_with_saved_search(cmd) abort
  call s:hz.ExecuteWithSavedSearch(a:cmd)
endfunction

function! hz#clean_whitespace(line1, line2) abort
  call s:hz.CleanWhitespace(a:line1, a:line2)
endfunction

function! hz#get_setting(name, default = v:null) abort
  return s:hz.GetSetting(a:name, a:default)
endfunction

function! hz#get_motion(motion) abort
  return s:hz.GetMotion(a:motion)
endfunction

function! hz#range_uniq(ignore_ws = false) range abort
  call s:hz.RangeUniq(a:firstline, a:lastline, a:a:ignore_ws)
endfunction

function! hz#switch_window(bufname) abort
  call s:hz.SwitchWindow(a:bufname)
endfunction

function! hz#xdg_base(type, ...) abort
  return s:hz.XdgBase(a:type, a:000)
endfunction

function! hz#xdg_path(type, ...) abort
  return s:hz.XdgPath(a:type, a:000)
endfunction

function! hz#_vimscript_user_commands() abort
  call s:hz.AddVimscriptUserCommandsSyntax()
endfunction

function! hz#_toggle_jk_mapping(mode = null_string) abort
  call s:hz.ToggleJkMapping(a:mode)
endfunction

function! hz#_toggle_special_window(type) abort
  call s:hz.ToggleSpecialWindow(a:type)
endfunction

function! hz#_synstack() abort
  call s:hz.GetSynstack()
endfunction

function! hz#url_encode(url) abort
  return s:hz.UrlEncode(a:url)
endfunction

function! hz#url_decode(url) abort
  return s:hz.UrlDecode(a:url)
endfunction
