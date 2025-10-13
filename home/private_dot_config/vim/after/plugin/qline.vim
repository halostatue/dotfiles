vim9script

import autoload 'qline/config.vim'
import autoload 'qline/preset/default.vim'

g:qline_config = {
  # defined but not used components:
  #   winnr, absolutepath, line, modified, paste, truncation, searchcount, bufnum,
  #   charvaluehex, keymap, percentwin, relativepath, spell, content, column, percent,
  #   charvalue
  #
  # close (tabs)
  # tabs (tabs)
  active: {
    left: [
      ['mode', 'paste'],
      ['fugitive', 'signify', 'filename'],
      ['readonly', 'modified']
    ],
    right: [
      ['lineinfo'],
      ['percent'],
      ['filetype', 'fileencoding', 'fileformat']
    ],
  },
  inactive: {
    left: [
      ['filename']
    ],
    right: [
      ['lineinfo'],
      ['percent']
    ],
  },
  component: {
    fugitive: {
      content: () => '[' .. g:FugitiveHead() .. ']'
    },
    signify: { content: () => sy#repo#get_stats_decorated() }

  }
}

