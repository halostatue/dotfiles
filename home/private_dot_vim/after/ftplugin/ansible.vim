vim9script

g:ansible_goto_role_paths = g:->get('ansible_goto_role_paths', './roles,../_common/roles')

def FindAnsibleRoleUnderCursor(mode: string)
  var role_paths = g:->get('ansible_goto_role_paths', './roles')
  var tasks_main = expand('<cfile>') .. '/tasks/main.yml'
  var found = findfile(tasks_main, role_paths)

  if found->empty()
    echo tasks_main .. ' not found'
  else
    execute printf('%s %s', mode, found_role_path->fnameescape())
  endif
enddef

for [key, mode] in items({ gr: "edit", grs: "split", grt: "tabedit", grv: "vertical split" })
  var cmd = printf('<leader>%s <Cmd>FindAnsibleRolUnderCursor("%s")<CR>', key, mode)
  execute printf('nnoremap <buffer> %s', cmd)
  execute printf('vnoremap <buffer> %s', cmd)
endfor

# nnoremap <buffer> <leader>gr <Cmd>FindAnsibleRoleUnderCursor("edit")<CR>
# nnoremap <buffer> <leader>grs <Cmd>FindAnsibleRoleUnderCursor("split")<CR>
# nnoremap <buffer> <leader>grt <Cmd>FindAnsibleRoleUnderCursor("tabedit")<CR>
# nnoremap <buffer> <leader>grv <Cmd>FindAnsibleRoleUnderCursor("vertical split")<CR>
# vnoremap <buffer> <leader>gr <Cmd>FindAnsibleRoleUnderCursor("edit")<CR>
# vnoremap <buffer> <leader>grs <Cmd>FindAnsibleRoleUnderCursor("split")<CR>
# vnoremap <buffer> <leader>grt <Cmd>FindAnsibleRoleUnderCursor("tabedit")<CR>
# vnoremap <buffer> <leader>grv <Cmd>FindAnsibleRoleUnderCursor("vertical split")<CR>
