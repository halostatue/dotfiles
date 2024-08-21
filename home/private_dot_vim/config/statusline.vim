vim9script

var hz_statusline_type = g:->get('hz_statusline_type', 'hz')

if hz_statusline_type ==# 'hz'
  # This is an interim status line shaped from kennypete/vim-tene, but turned into
  # a statusline function instead of a series of ternary expressions. It is no longer
  # configurable and that icons are all emoji instead of using an icon font.
  #
  # It would be possible to switch *back* to a ternary setup based on this, as some of the
  # logic present has been simplified rather than repeated, but there are further changes
  # that I want to investigate.

  # BSD 3-Clause License
  # https://github.com/kennypete/vim-tene/blob/main/LICENCE
  # Copyright © 2023 Peter Kenny

  g:tene_hi = {
    c: 'StatusLineTermNC', i: 'WildMenu', n: 'Visual',
    o: 'ErrorMsg', r: 'Pmenu', s: 'StatusLine',
    v: 'DiffAdd', x: 'StatusLineNC', t: 'StatusLineTerm',
  }
  for m in ['no', 'nov', 'noV', 'no'] | g:tene_hi[m] = g:tene_hi['o'] | endfor
  for m in ['niI', 'niR', 'niV', 'nt'] | g:tene_hi[m] = g:tene_hi['n'] | endfor
  for m in ['vs', 'V', 'Vs', '', 's'] | g:tene_hi[m] = g:tene_hi['v'] | endfor
  for m in ['ic', 'ix'] | g:tene_hi[m] = g:tene_hi['i'] | endfor
  for m in ['R', 'Rc', 'Rvc', 'Rvx', 'Rx'] | g:tene_hi[m] = g:tene_hi['r'] | endfor
  for m in ['ce', 'cr', 'ct', 'cv', 'cvr', 'c'] | g:tene_hi[m] = g:tene_hi['c'] | endfor
  for m in ['S', ''] | g:tene_hi[m] = g:tene_hi['s'] | endfor

  g:tene_modes = {
    '': '^𝕊', '': '^𝕍', 's': '^𝕍𝕤',
    R: 'ℝ', Rc: 'ℝ𝕔', Rvc: '𝕍ℝ𝕔', Rvx: '𝕍ℝ𝕩', Rx: 'ℝ𝕩',
    S: '𝕊', s: '𝕤',
    V: '𝕍', Vs: '𝕍𝕤', v: '𝕧', vs: 'v𝕤',
    c: 'ℂ', ce: '𝕏', cr: 'ℂ𝕣', ct: 'ℂ𝕥', cv: 'ℂ𝕩', cvr: 'ℂ𝕩𝕣',
    i: '𝕚', ic: '𝕚𝕔', ix: '𝕚𝕩',
    n: 'ℕ', niR: 'ℝ𝕟', niV: '𝕍ℝ', niI: '𝕀𝕟', nt: '𝕋ℕ',
    no: '𝕆', noV: '𝕆𝕍', nov: '𝕆𝕧', 'no': '𝕆^𝕍',
    t: '𝕋',
  }

  g:tene_ga = {
    'bufnr': 'в', 'buftypehelp': '⍰', 'col()': '⩙', 'dg': 'Æ', 'key': '🔑', 'line()': '',
    'mod': '⊕', 'noma': '⊖', 'paste': '🅿', 'pvw': '📺', 'recording': '⊙', 'ro': '🚫',
    'spell': '✓', 'virtcol()': '', 'winnr': 'ш',
  }

  g:tene_state_S = ' I '

  def StartsWith(longer: string, shorter: string): bool
    return longer[0 : len(shorter) - 1] ==# shorter
  enddef

  def g:HzStatusline(): string
    var cfn = expand('%')

    var line = ''
    var m1 = mode(1)
    var state = state()

    if g:statusline_winid == win_getid()
      if state ==# 'S' && (m1 ==# 'i' || m1 ==# 'R' || m1 == 'Rv')
        line ..= '%#' .. g:tene_hi['o'] .. '#' .. g:tene_state_S
      endif

      line ..= '%#' .. g:tene_hi[m1] .. '# ' .. g:tene_modes[m1] .. ' '

      if &iminsert == 1 && (m1 ==# 'i' || m1 ==# 'Rv')
        line ..= '%k '
      elseif m1 !=# 'ce' && m1[0] == 'c' && &keymap->len() > 0
        line ..= '%k '
      endif

      if m1 ==# 't' || m1 ==# 'nt'
        line ..= '%#' .. g:tene_hi['t'] .. '#'
      else
        line ..= '%#' .. g:tene_hi['s'] .. '#'
      endif
    else
      if m1 ==# 't' || m1 ==# 'nt'
        line ..= '%#' .. g:tene_hi['t'] .. '#'
      else
        line ..= '%#' .. g:tene_hi['x'] .. '#'
      endif
    endif

    if &buftype == 'help'
      line ..= ' ' .. g:tene_ga['buftypehelp']
    endif

    line ..= ' ' .. g:tene_ga['bufnr'] .. bufnr() .. ' ' .. '%<'

    if !&readonly && &paste
      line ..= g:tene_ga['paste'] .. '  '
    endif

    if &modified && &buftype != 'terminal'
      line ..= g:tene_ga['mod'] .. '  '
    endif

    if !&modifiable && mode() !=# 't'
      line ..= g:tene_ga['noma'] .. '  '
    endif

    if &previewwindow
      line ..= g:tene_ga['pvw'] .. '  '
    endif

    if !&readonly && &digraph && (
        m1 ==# 'cv' || m1 ==# 'cvr' || m1 ==# 'ct' || m1 ==# 'cr' || m1 ==# 'c' ||
        m1 ==# 'i' || m1 ==# 'Rv' || m1 ==# 'R'
      )
      line ..= g:tene_ga['dg'] .. '  '
    endif

    if &key != ''
      line ..= g:tene_ga['key']

      if &cryptmethod ==# 'blowfish2'
        line ..= '(' .. &cryptmethod .. ')'
      endif

      line ..= ' '
    endif

    if !&readonly && &spell
      line ..= g:tene_ga['spell'] .. '  '
    endif

    if reg_recording() != ''
      line ..= g:tene_ga['recording'] .. reg_recording() .. ' '
    endif

    if &filetype != 'netrw'
      line ..= expand('%:t') .. ' '
    endif

    if &readonly
      line ..= g:tene_ga['ro']
    endif

    line ..= '%='

    if &buftype != 'terminal' && !&filetype->empty()
      line ..= &filetype .. ' '
    endif

    line ..= ' ' .. &fileencoding == '' ? &encoding : &fileencoding
    line ..= &bomb ? '[BOM]' : ''

    if &filetype != ''
      line ..= &fileformat .. ' '
    endif

    if mode() != 't'
      line ..= g:tene_ga['line()'] .. line('.') .. '/' .. line('$') .. ' '
      line ..= g:tene_ga['virtcol()'] .. virtcol('.') .. ' '
      line ..= 'U+%B'

      var val = matchstr(getline('.')[col('.') - 1 : -1], '.')

      if byteidxcomp(val, 2) != -1
        line ..= ',U+' .. printf('%X', strgetchar(val, 1))
      endif

      if byteidxcomp(val, 3) != -1
        line ..= ',U+' .. printf('%X', strgetchar(val, 2))
      endif

      line ..= ' '
    endif

    return line
  enddef

  set statusline=%!g:HzStatusline()

  augroup hz-statusline
    autocmd ModeChanged *:[^t]\+ redrawstatus
  augroup END
endif
