vim9script

if !hz#Is('mac')
  finish
endif

# Almost everything that applies to Unix configs applies here, too.
runtime config/options/unix.vim

# Free up ⌘-P (<D-P>)
if exists(':unmenu') > 0
  unmenu File.Print
endif
