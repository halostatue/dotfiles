vim9script

def TransformUmbrellaTest(cmd: string): string
  if match(cmd, '^apps/') >= 0
    return substitute(
      cmd,
      'mix test apps/\([^/*]\)/',
      'mix cmd --app \1 mix test --color ',
      ''
    )
  endif

  return cmd
enddef

g:test#custom_transformations = { elixir_umbrella: TransformUmbrellaTest }
g:test#transformation = 'elixir_umbrella'

if exists('g:projectionist_heuristics')
  g:projectionist_heuristics['mix.exs'] = {
    'apps/*/mix.exs': { type: 'app' },
    'lib/*.ex': {
      type: 'lib',
      alternate: 'test/{}_test.exs',
      template: ['defmodule {camelcase|capitalize|dot} do', 'end'],
    },
    'test/*_test.exs': {
      type: 'test',
      alternate: 'lib/{}.ex',
      template: [
        'defmodule {camelcase|capitalize|dot}Test do',
        '  use ExUnit.Case',
        '',
        '  alias {camelcase|capitalize|dot}',
        '',
        '  doctest {camelcase|capitalize|dot}',
        'end'
      ],
    },
    'mix.exs': { type: 'mix' },
    'config/*.exs': { type: 'config' },
    '*.ex': {
      makery: {
        lint: { compiler: 'credo' },
        test: { compiler: 'exunit' },
        build: { compiler: 'mix' }
      }
    },
    '*.exs': {
      makery: {
        lint: { compiler: 'credo' },
        test: { compiler: 'exunit' },
        build: { compiler: 'mix' }
      }
    }
  }
endif
