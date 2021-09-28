local g = vim.g

g.rooter_patterns = {
  '.git',
  '_darcs',
  '.hg',
  '.bzr',
  '.svn',
  'Makefile',
  'package.json',
  '!../Cargo.toml',
  '!../../Cargo.toml',
  'Cargo.toml',
  'init.lua',
  'init.vim',
}

g.rooter_silent_chdir = 1
