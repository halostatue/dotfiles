scriptencoding utf-8

""
" Create a cleaner tabline.
"
"     let &tabline = '%!hz#ui#tabline()'
function! hz#ui#tabline() abort
  let l:s = []

  for l:i in range(1, tabpagenr('$'))
    let l:bufnrs = tabpagebuflist(l:i)
    let l:bufnr = l:bufnrs[tabpagewinnr(l:i) - 1]

    let l:mod = getbufvar(l:bufnr, '&modified') ? '!' : ''

    let l:title =
          \ !exists('*gettabvar') ?
          \      fnamemodify(bufname(l:bufnr), ':t') :
          \ gettabvar(l:i, 'title') !=# '' ?
          \      gettabvar(l:i, 'title') :
          \      fnamemodify((l:i == tabpagenr() ?
          \       getcwd() : gettabvar(l:i, 'cwd')), ':t')

    call extend(
          \ l:s,
          \ [
          \   '%[',
          \   l:i,
          \   ']%#',
          \   (l:i == tabpagenr() ? 'TabLineSel' : 'TabLine'),
          \   '#',
          \   l:title,
          \   l:mod,
          \   '%#TabLineFill#'
          \ ])
  endfor

  call add(l:s, '%#TabLineFill#%T%=#TabLine#')

  return join(l:s, '')
endfunction

""
" A cleaner foldtext function.
"
"     set foldtext='hz#ui#foldtext()'
function! hz#ui#foldtext() abort
  let l:line = getline(v:foldstart)

  let l:nucolwidth = &foldcolumn + &number * &numberwidth
  let l:windowwidth = winwidth(0) - l:nucolwidth - 13
  let l:foldedlinecount = v:foldend - v:foldstart + 1

  let l:onetab = strpart('          ', 0, &tabstop)
  let l:line = substitute(l:line, '\t', l:onetab, 'g')

  let l:line = strpart(l:line, 0, l:windowwidth - 2 - len(l:foldedlinecount))
  let l:fillcharcount = l:windowwidth - len(l:line) - len(l:foldedlinecount) - 2
  return join([l:line, '… ', repeat(' ', l:fillcharcount), l:foldedlinecount, ' lines'], '')
endfunction

""
" The global default foldtext function for use with
" @function(hz#ui#smart_foldtext()).
let g:hz#ui#default_foldtext = 'hz#ui#foldtext'

""
" @setting b:hz#ui#default_foldtext
" A buffer-specific default foldtext function for use with
" @function(hz#ui#smart_foldtext()).

""
" @usage [foldtext]
" Sets the local 'foldtext' function to either a provided [foldtext]
" function.
"
" Without a [foldtext] function provided, a local 'foldtext' value of
" `getline(v:foldstart)` will be replaced with of
" @setting(b:hz#ui#default_foldtext), @setting(g:hz#ui#default_foldtext), or
" |foldtext()|.
function! hz#ui#smart_foldtext(...) abort
  if a:0 != 0
    let &l:foldtext = a:1
  else
    let l:ftf = &l:foldtext

    if l:ftf !~# 'getline(v:foldstart)' | return | endif

    if hz#valid_function('b:hz#ui#default_foldtext')
      let l:ftf = b:hz#ui#default_foldtext . '()'
    elseif hz#valid_function('g:hz#ui#default_foldtext')
      let l:ftf = g:hz#ui#default_foldtext . '()'
    else
      let l:ftf = 'foldtext()'
    endif

    let &l:foldtext = l:ftf
  endif
endfunction

""
" @setting g:hzvim_guifont
" The value of guifont. Defaults to Fira Code, Input Mono Narrow, Source Code
" Pro, Inconsolata Medium, Anonymous Pro, DejaVu Sans Mono, and Andale Mono.

""
" @setting g:hzvim_guifont_size
" The pointsize of values in @setting(g:hzvim_guifont) when the point size is
" not provided. The default is 10 points.

let s:hzvim_guifont_default =
      \ [
      \   'Fira Code',
      \   'Input Mono Narrow',
      \   'Source Code Pro',
      \   'Inconsolata Medium',
      \   'Anonymous Pro',
      \   'DejaVu Sans Mono',
      \   'Andale Mono',
      \ ]

""
" @usage [dict]
" @usage [list]
" @usage [font...]
"
" Set 'guifont' either from the default @setting(g:hzvim_guifont) or from the
" provided dictionary (`{ 'font' : points }`) or list (each item is either
" `['font', points]`, `['font']`, or `'font'`). If the point size is not
" provided, it is set to @setting(g:hzvim_guifont_size).
function! hz#ui#set_guifont(...) abort
  if a:0 > 1
    let l:list = deepcopy(a:000)
  elseif a:0 == 1
    let l:list = a:1
  else
    let l:list = get(g:, 'hzvim_guifont', s:hzvim_guifont_default)
  endif

  if type(l:list) == v:t_dict
    let l:list = map(l:list, { k, v -> [ k, v ] })
  endif

  if type(l:list) != v:t_list | let l:list = [ l:list ] | endif

  " vint: -ProhibitUnusedVariable
  let l:size = get(g:, 'hzvim_guifont_size', 10)
  let l:list = map(l:list, { _, v -> hz#ui#_ensure_font_size(v, l:size) })
  let l:list = hz#ui#_guifont_join(l:list)
  let &guifont = l:list
  " vint: +ProhibitUnusedVariable

  return l:list
endfunction

function! hz#ui#_ensure_font_size(item, size) abort
  if type(a:item) == v:t_string
    return [ a:item, a:size ]
  elseif type(a:item) == v:t_list
    if len(a:item) == 1
      return [ a:item[0], a:size ]
    elseif len(a:item) == 2
      return a:item
    else
      throw printf('Invalid type (%d) for font spec, too many parts: %s',
            \ type(a:item), string(a:item))
    endif
  else
    throw printf('Invalid type (%d) for font spec: %s', type(a:item),
          \ string(a:item))
  endif
endfunction

function! hz#ui#_guifont_join(list) abort
  if hz#is#mac() || hz#is#windows()
    return join(map(a:list, { _, v -> join(v, ':h') }), ',')
  else
    return join(map(a:list, { _, v -> join(v, ' ') }), ',')
  endif
endfunction

function! hz#ui#_xterm_paste_begin(...)abort
  set paste
  return a:0 ? a:1 : ''
endfunction

function! hz#ui#_pulse_cursor_line(times, delay, ...) abort
  let l:cl = &l:cursorline
  let l:index = 0
  let l:delay = 'sleep' . a:delay . 'm'
  let l:last = a:0 ? 'sleep' . a:1 . 'm' : l:delay

  while l:index < a:times
    setlocal cursorline!
    redraw

    let l:index = l:index + 1

    if l:index < a:times
      exec l:delay
    else
      exec l:last
    endif
  endwhile

  let &l:cursorline = l:cl
endfunction

function! hz#ui#_v_set_search() abort
  let l:temp = @@
  normal! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = l:temp
endfunction

function! hz#ui#_toggle_diff_iwhite() abort
  if &diffopt =~? 'iwhite'
    set diffopt -= iwhite
  else
    set diffopt += iwhite
  endif
  diffupdate
endfunction

function! hz#ui#_is_stdin() abort
  let s:std_in = 1
endfunction

