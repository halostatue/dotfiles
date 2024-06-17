vim9script

if !exists(':Startify')
  finish
endif

g:startify_session_dir = hz#xdg_path('cache', 'session')
hz#mkpath(g:startify_session_dir, true)

g:startify_fortune_use_unicode = 1
g:startify_change_to_dir = 0
g:startify_change_to_vcs_root = 1
g:startify_change_cmd = 'cd'

def OptInstalled(name: string): bool
  var found = false

  for item in split(&packpath, ',')
    if finddir(name, item .. '/pack/*/opt') !=# ''
      return true
    endif
  endfor

  return false
enddef

g:startify_commands = []

if exists(':StartupTime') == 2
  g:startify_commands->add({ T: ['Time startup', 'StartupTime'] })
endif

if OptInstalled('vim-obsession') && OptInstalled('vim-prosession')
  g:startify_commands->insert(
    { S: ['Start Prosession', 'packadd vim-obsession | packadd vim-prosession | Prosession .'] }
  )
endif

if exists(':PackixInstall') == 2
  g:startify_commands->extend(
    [
      { r: ['Install plugins', 'PackixInstall'] },
      { u: ['Update plugins', 'PackixUpdate'] },
      { c: ['Clean plugins', 'PackixClean'] },
      { s: ['Plugin status', 'PackixStatus'] },
    ]
  )
endif
