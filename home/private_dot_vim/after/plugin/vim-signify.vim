vim9script

if !exists(':SignifyEnable')
  finish
endif

g:signify_skip = {
  vcs: {
    deny: [
      'accurev', 'bzr', 'cvs', 'darcs', 'perforce', 'rcs', 'svn', 'tfs',
      'yadm'
    ]
  }
}

# g:signify_line_highlight = true
g:signify_number_highlight = true
g:signify_sign_show_count = true

if packix#is_plugin_installed('vim-emoji')
  g:signify_sign_add = emoji#for('heavy_plus_sign')
  g:signify_sign_delete = emoji#for('heavy_minus_sign')
  g:signify_sign_delete_first_line = emoji#for('small_red_triangle_down')
  g:signify_sign_change = emoji#for('collision')
  g:signify_sign_change_delete = emoji#for('collision')
endif
