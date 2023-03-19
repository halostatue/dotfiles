scriptencoding utf-8

let g:signify_vcs_list = [ 'git', 'hg']

if exists('*emoji#for')
  let g:signify_sign_add = emoji#for('small_blue_diamond')
  let g:signify_sign_delete = emoji#for('small_red_triangle')
  let g:signify_sign_delete_first_line = emoji#for('small_red_triangle')
  let g:signify_sign_change = emoji#for('collision')
  let g:signify_sign_changedelete = emoji#for('collision')
endif
