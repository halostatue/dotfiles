vim9script

# Load packages on demand. Lifted from junegunn/vim-plug and adapted for use
# with Vim 8+ packaging using vim 9 script

final CommandPackages: dict<list<string>> = {}

def Run(name: string, bang: any, line1: any, line2: any, args: any)
  if !has_key(CommandPackages, name)
    throw 'Command ' .. name .. ' does not have packages defined.'
  endif

  execute "delcommand " .. name

  var packages = CommandPackages[name]

  remove(CommandPackages, name)

  try
    for pkg in packages
      packadd pkg
    endfor

    execute printf('%s%s%s %s', (l1 == l2 ? '' : (l1 .. ',' .. l2)), name, bang, args)
  endtry
enddef

export def Define(name: string, ...packages: list<string>)
  if name !~# '^[A-Z][a-zA-Z0-9]*$'
    throw 'Command name must begin with an uppercase letter'
  endif

  if exists(':' .. name)
    throw 'Command ' .. name .. ' already exists.'
  endif

  if has_key(CommandPackages, name)
    throw 'Command ' .. name .. ' already deferred.'
  endif

  if len(packages) < 1
    throw 'Command ' .. name .. ' must have at least one package to add.'
  endif

  CommandPackages[name] = packages

  var fcall = printf('call <ScriptCmd>Run("%s", "<bang>", <line1>, <line2>, <q-args>)', name)
  var cmd = printf('command! -nargs=* -range -bang -complete=file %s %s', name, fcall)

  execute cmd
enddef
