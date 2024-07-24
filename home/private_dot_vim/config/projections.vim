vim9script

g:projectionist_heuristics = g:->get('projectionist_heuristics', {})

# Adapted from andyl/vim-projectionist-elixir and https://hauleth.dev/post/vim-for-elixir/
g:projectionist_heuristics['mix.exs'] = {
  '*': {
    console: 'iex -S mix',
    dispatch: 'mix',
    make: 'mix',
    start: 'iex -S mix'
  },
  '*.ex': {
    makery: {
      lint: { compiler: 'credo' },
      test: { compiler: 'exunit' },
      build: { compiler: 'mix' }
    }
  },
  'lib/*.ex': {
    alternate: 'test/{}_test.exs',
    type: 'lib',
    template: ['defmodule {camelcase|capitalize|dot} do', '', 'end']
  },
  'test/*_test.exs': {
    alternate: 'lib/{}.ex',
    type: 'test',
    dispatch: 'mix test {file}',
    make: 'mix test {file}',
    template: [
      'defmodule {camelcase|capitalize|dot}Test do',
      '  use ExUnit.Case, async: true',
      '',
      '  alias {camelcase|capitalize|dot}',
      '',
      '  doctest {camelcase|capitalize|dot}',
      '',
      '  describe "#run/1" do',
      '    test "description" do',
      '      assert false',
      '    end',
      '  end',
      'end'
    ],
  },
  'apps/*/mix.exs': { type: 'app' },
  'mix.exs': { type: 'mix' },
  'config/*.exs': { type: 'config' },
}

g:projectionist_heuristics['rebar.config'] = {
  '*.erl': {
    template: ['-module({basename}).', '', '-export([]).', ''],
  },
  'src/*.app.src': { 'type': 'app' },
  'src/*.erl': {
    'type': 'src',
    'alternate': 'test/{}_SUITE.erl',
  },
  'test/*_SUITE.erl': {
    'type': 'test',
    'alternate': 'src/{}.erl',
  },
  'rebar.config': { 'type': 'rebar' }
}
