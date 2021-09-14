local g = vim.g
local emoji = vim.fn['emoji#for']

g.signify_vcs_list = { 'git', 'hg' }

g.signify_sign_add = emoji('small_blue_diamond')
g.signify_sign_delete = emoji('small_red_triangle')
g.signify_sign_delete_first_line = emoji('small_red_triangle')
g.signify_sign_change = emoji('collision')
g.signify_sign_changedelete = emoji('collision')
