vim9script

if !packix#IsPluginInstalled('machakann/vim-sandwich')
  finish
endif

runtime macros/sandwich/keymap/surround.vim

g:sandwich#recipes += [
  {
    buns: ['{ ', ' }'],
    nesting: 1,
    match_syntax: 1,
    kind: ['add', 'replace'],
    action: ['add'],
    input: ['{']
  },
  {
    buns: ['[ ', ' ]'],
    nesting: 1,
    match_syntax: 1,
    kind: ['add', 'replace'],
    action: ['add'],
    input: ['[']
  },
  {
    buns: ['( ', ' )'],
    nesting: 1,
    match_syntax: 1,
    kind: ['add', 'replace'],
    action: ['add'],
    input: ['(']
  },
  {
    buns: ['{\s*', '\s*}'],
    nesting: 1,
    regex: 1,
    match_syntax: 1,
    kind: ['delete', 'replace', 'textobj'],
    action: ['delete'],
    input: ['{']
  },
  {
    buns: ['\[\s*', '\s*\]'],
    nesting: 1,
    regex: 1,
    match_syntax: 1,
    kind: ['delete', 'replace', 'textobj'],
    action: ['delete'],
    input: ['[']
  },
  {
    buns: ['(\s*', '\s*)'],
    nesting: 1,
    regex: 1,
    match_syntax: 1,
    kind: ['delete', 'replace', 'textobj'],
    action: ['delete'],
    input: ['(']
  }
]
