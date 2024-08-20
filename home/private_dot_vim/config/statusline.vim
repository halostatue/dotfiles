vim9script

var hz_statusline_type = g:->get('hz_statusline_type', 'tene')

if hz_statusline_type ==# 'tene'
  # This is an interim status line shaped from kennypete/vim-tene but simplified so that
  # it is no longer configurable and that icons are all emoji instead of using an icon
  # font.

  # BSD 3-Clause License
  # https://github.com/kennypete/vim-tene/blob/main/LICENCE
  # Copyright © 2023 Peter Kenny

  g:tene_hi = {
    c: 'StatusLineTermNC', i: 'WildMenu', n: 'Visual',
    o: 'ErrorMsg', r: 'Pmenu', s: 'StatusLine',
    v: 'DiffAdd', x: 'StatusLineNC',
  }

  g:tene_modes = {
    'CTRL-S': '^𝕊', 'CTRL-V': '^𝕍', 'CTRL-Vs': '^𝕍𝕤', 'noCTRL-V': '𝕆^𝕍',
    R: 'ℝ', Rc: 'ℝ𝕔', Rvc: '𝕍ℝ𝕔', Rvx: '𝕍ℝ𝕩', Rx: 'ℝ𝕩',
    S: '𝕊', s: '𝕤',
    V: '𝕍', Vs: '𝕍𝕤', v: '𝕧', vs: 'v𝕤',
    c: 'ℂ', ce: '𝕏', cr: 'ℂ𝕣', ct: 'ℂ𝕥', cv: 'ℂ𝕩', cvr: 'ℂ𝕩𝕣',
    i: '𝕚', ic: '𝕚𝕔', ix: '𝕚𝕩',
    n: 'ℕ', niR: 'ℝ𝕟', niV: '𝕍ℝ', niI: '𝕀𝕟', no: '𝕆', noV: '𝕆𝕍', nov: '𝕆𝕧', nt: '𝕋ℕ',
    t: '𝕋',
  }

  g:tene_ga = {
    'bufnr': 'в', 'buftypehelp': '⍰', 'col()': '⩙', 'dg': 'Æ', 'key': '🔑', 'line()': '',
    'mod': '⊕', 'noma': '⊖', 'paste': '🅿', 'pvw': '📺', 'recording': '⊙', 'ro': '🚫',
    'spell': '✓', 'virtcol()': '', 'winnr': 'ш',
  }

  g:tene_state_S = ' I '

  # }}}
  # Autocommand group {{{
  augroup tene
    autocmd!
    # :h tene-autocommand  :h ModeChanged   :h redrawstatus
    autocmd ModeChanged *:[^t]\+ redrawstatus
  augroup END
  # }}}
  # Statusline commands {{{
  set statusline=
  # :h mode() (NB: its order is followed)  :h tene-config-mode-names
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'n'?'%#'..g:tene_hi->get('n')..'#\ '..g:tene_modes->get('n')..'\ ':''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'no'?'%#'..g:tene_hi->get('o')..'#\ '..(g:tene_modes->get('no')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'nov'?'%#'..g:tene_hi->get('o')..'#\ '..(g:tene_modes->get('nov')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'noV'?'%#'..g:tene_hi->get('o')..'#\ '..(g:tene_modes->get('noV')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'no'?'%#'..g:tene_hi->get('o')..'#\ '..(g:tene_modes->get('noCTRL-V')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'niI'?'%#'..g:tene_hi->get('n')..'#\ '..(g:tene_modes->get('niI')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'niR'?'%#'..g:tene_hi->get('n')..'#\ '..(g:tene_modes->get('niR')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'niV'?'%#'..g:tene_hi->get('n')..'#\ '..(g:tene_modes->get('niV')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'nt'?'%#'..g:tene_hi->get('n')..'#\ '..(g:tene_modes->get('nt')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'v'?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('v')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'vs'?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('vs')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'V'?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('V')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'Vs'?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('Vs')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#''?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('CTRL-V')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'s'?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('CTRL-Vs')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'s'?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('s')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'S'?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('S')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#''?'%#'..g:tene_hi->get('v')..'#\ '..(g:tene_modes->get('CTRL-S')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'i'&&state()!=#'S'&&&iminsert!=1?'%#'..g:tene_hi->get('i')..'#\ '..(g:tene_modes->get('i')..'\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'i'&&state()!=#'S'&&&iminsert==1?'%#'..g:tene_hi->get('i')..'#\ '..(g:tene_modes->get('i')..'\ ')..('%k\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'i'&&state()==#'S'?'%#'..g:tene_hi->get('o')..'#'..g:tene_state_S..'%#'..g:tene_hi->get('i')..'#\ '..(g:tene_modes->get('i')..'\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'ic'?'%#'..g:tene_hi->get('i')..'#\ '..(g:tene_modes->get('i')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'ix'?'%#'..g:tene_hi->get('i')..'#\ '..(g:tene_modes->get('i')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'R'&&state()!=#'S'&&&iminsert!=1?'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('R')..'\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'R'&&state()!=#'S'&&&iminsert==1?'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('R')..'\ ')..('%k\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'R'&&state()==#'S'?'%#'..g:tene_hi->get('o')..'#'..g:tene_state_S..'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('R')..'\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'Rc'?'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('Rc')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'Rx'?'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('Rc')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'Rv'&&state()!=#'S'&&&iminsert!=1?'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('Rv')..'\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'Rv'&&state()!=#'S'&&&iminsert==1?'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('Rv')..'\ ')..('%k\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()?(mode(1)==#'Rv'&&state()==#'S'?'%#'..g:tene_hi->get('o')..'#'..g:tene_state_S..'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('Rv')..'\ '):''):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'Rvc'?'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('Rvc')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'Rvx'?'%#'..g:tene_hi->get('r')..'#\ '..(g:tene_modes->get('Rvx')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'c'&&len(&keymap)==0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('c')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'c'&&len(&keymap)>0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('c')..'\ ')..('%k\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'ct'&&len(&keymap)==0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('ct')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'ct'&&len(&keymap)>0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('ct')..'\ ')..('%k\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'cr'&&len(&keymap)==0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('cr')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'cr'&&len(&keymap)>0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('cr')..'\ ')..('%k\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'cv'&&len(&keymap)==0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('cv')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'cv'&&len(&keymap)>0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('cv')..'\ ')..('%k\ '):''%}
  # cvr currently only will display if the <Insert> keystroke occurs in the command following entering :redrawstatus, so it is not very practical.  Refer https://github.com/vim/vim/issues/14347
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'cvr'&&len(&keymap)==0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('cvr')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'cvr'&&len(&keymap)>0?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('cvr')..'\ ')..('%k\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'ce'?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('ce')..'\ '):''%}
  set statusline+=%{%g:actual_curwin==win_getid()&&mode(1)==#'t'?'%#'..g:tene_hi->get('c')..'#\ '..(g:tene_modes->get('t')):''%}
  # Highlight the rest of the active/current window's statusline.
  set statusline+=%{%g:actual_curwin==win_getid()?('%#'..((mode(1)==#'t'\|\|mode(1)==#'nt')?g:tene_hi->get('t'):g:tene_hi->get('s'))..'#'):''%}
  # Highlight the rest of the inactive/non-current windows' statuslines.
  set statusline+=%{%g:actual_curwin==win_getid()?'':'%#'..((mode(1)==#'t'\|\|mode(1)==#'nt')?g:tene_hi->get('c'):g:tene_hi->get('x'))..'#'%}
  # Display help indicator in help windows.
  set statusline+=%{&buftype=='help'?'\ '..((g:tene_ga['buftypehelp'])):''}
  set statusline+=\
  # The buffer number of the buffer in each window - optional.
  # This could have a total buffers option added with set statusline+=\ %(%{'b'.bufnr('%')}/%{len(getbufinfo())}\ %)
  # but testing showed it was very distracting because the buffers are created and wiped not only by the user, so the number moves around a lot.
  set statusline+=%{((g:tene_ga['bufnr']))..bufnr()..'\ '}
  ## Truncate the statusline here.
  set statusline+=%<
  # A paste indicator &paste is on.  :h 'paste'
  set statusline+=%{!&readonly&&&paste!=0?((g:tene_ga['paste'])..'\ '..'\ '):''}
  # Modified flag (but only display it where the buftype is not 'terminal' because there is no point showing that since it's immediately modified)
  set statusline+=%{&modified&&&buftype!='terminal'?((g:tene_ga['mod'])..'\ '..'\ '):''}
  # Modifiable flag (similar to Modified but also show not modifiable in Terminal-Normal mode, so 't', not the buftype, which includes Terminal-Job).
  set statusline+=%{(!&modifiable&&mode()!=#'t')?((g:tene_ga['noma'])..'\ '..'\ '):''}
  # Display Preview indicator in Preview windows.
  set statusline+=%{&previewwindow==1?((g:tene_ga['pvw'])..'\ '..'\ '):''}
  # Display digraph indicator when digraph is enabled.
  set statusline+=%{!&readonly&&&digraph!=0&&(mode(1)==#'cv'\|\|mode(1)==#'cvr'\|\|mode(1)==#'ct'\|\|mode(1)==#'cr'\|\|mode(1)==#'c'\|\|mode(1)==#'i'\|\|mode(1)==#'Rv'\|\|mode(1)==#'R')?((g:tene_ga['dg'])..'\ '..'\ '):''}
  # Display a key indicator when key option is on: i.e., the buffer is encrypted.
  set statusline+=%{&key!=''?(((g:tene_ga['key']))..(&cryptmethod!='blowfish2'?'('..&cryptmethod..')':'').'\ '):''}
  # Display a spell indicator when spell checking option is on.
  set statusline+=%{!&readonly&&&spell!=0?((g:tene_ga['spell'])..'\ '..'\ '):''}
  # Display a macro recording indicator when a macro is being recorded.
  set statusline+=%{reg_recording()==''?'':((g:tene_ga['recording']))..reg_recording()..'\ '}
  # The filename.  Just 'tail' if that option is chosen, noting items %f and %t
  # show as '[No Name]' for the initial buffer - using expand('%:t') prevents that.
  set statusline+=%{%&filetype!='netrw'?expand('%:t')..'\ ':''%}
  # Read only flag.
  set statusline+=%{&readonly?((g:tene_ga['ro'])):''}
  # Separation point between left and right aligned items.
  set statusline+=%=
  # Where the window isn't a terminal, the file type and a space, otherwise nil.
  set statusline+=%{&buftype!='terminal'?&filetype..(&filetype==''?'':'\ '):''}
  # File encoding, including the byte order mark (when applicable), and a space.
  set statusline+=%{(&fileencoding==''?&encoding:&fileencoding)..(&bomb?'[BOM]':'')..'\ '}
  # File format.  Display nothing if no file type.
  set statusline+=%{&filetype!=''?&fileformat..'\ ':''}
  # Line number and line numbers; line('.') is %l and line('$') is %L.
  set statusline+=%{mode()!=#'t'?g:tene_ga['line()']..line('.'):''}
  set statusline+=%{mode()!=#'t'?'/'..line('$'):''}
  set statusline+=%{mode()!=#'t'?'\ ':''}
  # The virtual column, virtcol('.'), which differs from either %v or %V.
  set statusline+=%{(mode()!=#'t')?((g:tene_ga['virtcol()']))..virtcol('.'):''}
  set statusline+=%{(mode()!=#'t')?'\ ':''}
  # Unicode information, e.g. ¢ is U+00A2.  Zeros are omitted to save space.
  set statusline+=%{%mode()!=#'t'?'U+%B':''%}
  # Handling composing characters too like नि (U+928,U+93F) and Ä (U+41,U+308).
  set statusline+=%{mode()!=#'t'&&byteidxcomp(matchstr(getline('.')[col('.')-1:-1],'.'),2)!=-1?',U+'..printf('%X',strgetchar(matchstr(getline('.')[col('.')-1:-1],'.'),1)):''}
  set statusline+=%{mode()!=#'t'&&byteidxcomp(matchstr(getline('.')[col('.')-1:-1],'.'),3)!=-1?',U+'..printf('%X',strgetchar(matchstr(getline('.')[col('.')-1:-1],'.'),2)):''}
  set statusline+=%{mode()!=#'t'?'\ ':''}
  # }}}

endif
