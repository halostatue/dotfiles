vim9script

if mapcheck('<Plug>(esearch)') == ''
  finish
endif

if !has_key(g:, 'esearch')
  g:esearch = {}
endif

g:esearch.case = 'smart'
g:esearch.win_new = (esearch: dict<any>) => {
  esearch#buf#goto_or_open(esearch.name, 'botright 20split')
}

if exists('*FugitiveExtractGitDir')
  g:esearch.git_dir = (cwd: string) => FugitiveExtractGitDir(cwd)
  g:esearch.git_url = (path: string, dir: string) => FugitiveFind(path, dir)
endif
