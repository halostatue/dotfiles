vim9script

if !exists('g:asyncomplete_manager') || !packix#IsPluginInstalled('asyncomplete-anylist')
  finish
endif

# https://www.conventionalcommits.org/en/v1.0.0/
def GitConventionalCommit(): list<string>
  if &filetype !~? 'git'
    return []
  endif

  return [
    'build', 'ci', 'chore', 'docs', 'feat', 'fix', 'perf', 'refactor',
    'revert', 'style', 'test'
  ]
enddef

final _items: list<dict<any>> = [
  # { name: 'sign', list: ['halostatue', 'aziegler'] },
  { name: 'git', function: GitConventionalCommit, args: [] },
]

if exists('*mr#mrr#list')
  _items->add({ name: 'mrr', function: function('mr#mrr#list'), args: [] })
endif

if exists('*mr#mru#list')
  _items->add({ name: 'mru', function: function('mr#mru#list'), args: [] })
endif

if exists('*mr#mrw#list')
  _items->add({ name: 'mrw', function: function('mr#mrw#list'), args: [] })
endif

def Register()
  asyncomplete#register_source(
    asyncomplete#sources#anylist#get_source_options({
      name: 'anylist',
      allowlist: ['*'],
      completor: function('asyncomplete#sources#anylist_completor'),
      config: {
        matcher: '\(\w\|\f\)+$',
        items: _items
      },
      priority: 20,
    })
  )
enddef

augroup asyncomplete-register-anylist
  autocmd!

  autocmd User asyncomplete_setup call Register()
augroup END
