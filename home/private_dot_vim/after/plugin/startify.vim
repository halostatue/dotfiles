vim9script

g:startify_session_dir = hz#xdg_path('cache', 'session')
hz#mkpath(g:startify_session_dir, v:true)

g:startify_fortune_use_unicode = 1
g:startify_change_to_dir = 0
g:startify_change_to_vcs_root = 1
g:startify_change_cmd = 'cd'

def OptInstalled(name: string): bool
  var found = v:false

  for item in split(&packpath, ',')
    if finddir(name, item .. '/pack/*/opt') !=# ''
      return v:true
    endif
  endfor

  return v:false
enddef

g:startify_commands = [ ]

if exists(':StartupTime') == 2
  add(g:startify_commands, { 't': ['Time startup', 'StartupTime'] })
endif

if OptInstalled('vim-obsession') && OptInstalled('vim-prosession')
  insert(
    g:startify_commands,
    { 's': ['Start Prosession', 'packadd vim-obsession | packadd vim-prosession | Prosession .'] }
  )
endif

if exists(':PackagerRefresh') == 2
  extend(
    g:startify_commands,
    [
      { 't': ['Time startup', 'StartupTime'] },
      { 'r': ['Refresh plugins', 'PackagerRefresh'] },
      { 'u': ['Update plugins', 'PackagerUpdate'] },
      { 'c': ['Clean plugins', 'PackagerClean'] },
      { 's': ['Refresh plugins', 'JetpackSync'] },
    ]
  )
elseif exists(':JetpackSync') == 2
  add(g:startify_commands, { 's': ['Refresh plugins', 'JetpackSync'] })
endif
