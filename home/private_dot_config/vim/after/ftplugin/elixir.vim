vim9script

def TransformUmbrellaTest(cmd: string): string
  if cmd->match('^apps/') >= 0
    return cmd->substitute(
      'mix test apps/\([^/*]\)/',
      'mix cmd --app \1 mix test --color ',
      ''
    )
  endif

  return cmd
enddef

g:test#custom_transformations = { elixir_umbrella: TransformUmbrellaTest }
g:test#transformation = 'elixir_umbrella'

nmap <buffer> <Leader>I i\|> IO.inspect(label: "")<ESC>hi
# imap <buffer> <Leader>I \|> IO.inspect(label: "")<ESC>hi
