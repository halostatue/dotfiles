vim9script

if !exists(':Startify')
  finish
endif

g:startify_session_dir = hz#xdg_vim_path('cache', 'session')
hz#mkpath(g:startify_session_dir, true)

g:startify_fortune_use_unicode = true
g:startify_change_to_dir = false
g:startify_change_to_vcs_root = true
g:startify_bookmarks = [ { p: '~/.vim/config/plugins.vim' }]
g:startify_commands = []
g:startify_custom_header = 'startify#pad(startify#fortune#boxed())'
g:startify_custom_footer = [
  '',
  "   Vim is charityware. Please read ':help uganda'.",
  ''
]

if exists(':StartupTime') == 2
  g:startify_commands->add(['Time startup', 'StartupTime'])
endif

if exists(':PackixInstall') == 2
  if packix#is_plugin_installed('vim-obsession') && packix#is_plugin_installed('vim-prosession')
    g:startify_commands->insert(
      { S: ['Start Prosession', 'packadd vim-obsession | packadd vim-prosession | Prosession .'] }
    )
  endif

  g:startify_commands->extend(
    [
      { r: ['Install plugins', 'PackixInstall'] },
      { u: ['Update plugins', 'PackixUpdate'] },
      { c: ['Clean plugins', 'PackixClean'] },
      { s: ['Plugin status', 'PackixStatus'] },
    ]
  )
endif

autocmd User Startified setlocal cursorline
