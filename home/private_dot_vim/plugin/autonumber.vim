vim9script

# autonumber.vim
#
# Automatically switch between 'number' and 'relativenumber' contextually.
#
# Derived from:
#
# - https://github.com/b3niup/numbers.vim
# - https://github.com/myusuf3/numbers.vim

if exists('g:autonumber_loaded') && g:autonumber_loaded
  finish
endif

g:autonumber_loaded = true

const version = '1.0'

g:autonumber_enable = get(g:, 'autonumber_enable', true)

g:autonumber_exclude_filetype = get(g:, 'autonumber_exclude_filetype', [
  'Mundo', 'MundoDiff', 'fern', 'gundo', 'minibufexpl', 'nerdtree',
  'startify', 'tagbar', 'undotree', 'unite', 'vimshell', 'w3m'
])

if type(get(g:, 'autonumber_exclude_filetype_extra')) == v:t_list
  extend(g:autonumber_exclude_filetype, g:autonumber_exclude_filetype_extra)
endif

import autoload 'autonumber.vim'

# Commands
command! -nargs=0 AutonumberToggle call autonumber.Toggle()
command! -nargs=0 AutonumberEnable call autonumber.Enable()
command! -nargs=0 AutonumberDisable call autonumber.Disable()
command! -nargs=0 AutonumberOnOff call autonumber.TogglePlugin()
command! -bang -bar AutonumberIgnore call autonumber.IgnoreWindow('<bang>')

if g:autonumber_enable
  autonumber.Enable()
endif
