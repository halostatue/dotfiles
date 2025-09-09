vim9script

# Highlight trailing full stop in commit summary as an error.

syn match gitcommitTrailingFullStop "\.$" contained containedin=gitcommitSummary

# Override existing syntax match so it can contain my match.
# https://github.com/tpope/vim-git/blob/master/syntax/gitcommit.vim#L24-L28

var summary_length: number = get(g:, 'gitcommit_summary_length', 50)

var pattern = summary_length < 0 ?
  '^.*$' : printf('^.*\%%<%dv.', summary_length + 1)

execute printf(
  'syn match gitcommitSummary "%s" contained containedin=%s nextgroup=%s contains=%s',
  pattern,
  'getcommitFirstLine',
  'gitcommitOverflow',
  ['@Spell', 'gitcommitTrailingFullStop']->join(',')
)

hi def link gitcommitTrailingFullStop Error
