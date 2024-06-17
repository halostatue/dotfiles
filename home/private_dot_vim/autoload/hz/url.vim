vim9script

##
# Encodes non-urlsafe values in {url} with percent hex-encoding (e.g., ' '
# becomes '%20'. Only the path and query parameters are encoded.
#
# Improves on a version ripped from haskellmode.vim by Andrew Radev (which
# encoded the entire URL).
export def hz#url#encode(url: string): string
  var parts = url->split('/', true)
  var index = parts[0] =~# '^https\=' ? 3 : 1

  parts[index : ] = parts[index : ]->map(
    (_i, part) => {
      return substitute(
        part,
        '\([^-[:alnum:].=?&]\)',
        (m) => printf('%%%02X', char2nr(m[1])) },
        'g'
      )
    }
  )

  return parts->join('/')
enddef

##
# Decodes an encoded {url} back to plain-text.
#
# Based on a version ripped from unimpaired.vim by Andrew Radev.
export def hz#url#decode(url: string): string
  return url
    ->substitute('%0[Aa]\n$', '%0A', '')
    ->substitute('%0[Aa]', '\n', 'g')
    ->substitute('+', ' ', 'g')
    ->substitute('%\(\x\x\)', (m) => nr2char('0x' . m[1]), 'g')
enddef
