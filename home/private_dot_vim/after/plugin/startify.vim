scriptencoding utf-8

let g:startify_session_dir = hz#xdg_path('cache', 'session')
call hz#mkpath(g:startify_session_dir, v:true)
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_change_cmd = 'cd'

let g:startify_commands = [
      \ {'r': ['Refresh plugins', 'PackagerRefresh']},
      \ {'u': ['Update plugins', 'PackagerUpdate']},
      \ {'c': ['Clean plugins', 'PackagerClean']},
      \ {'t': ['Time startup', 'StartupTime']},
      \ {'s': ['Start Prosession', 'packadd vim-obsession | packadd vim-prosession | Prosession .']}
      \ ]
