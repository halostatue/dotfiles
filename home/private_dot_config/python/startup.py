# vim: filetype=python syntax=python

# see PYTHONSTARTUP

import atexit
import os
import readline
import rlcompleter

# <Tab> twice to autocomplete
readline.parse_and_bind("tab: complete")

###
# Save history
historyPath = os.path.expanduser("~/.pyhistory")

def save_history(historyPath=historyPath):
    import readline
    readline.write_history_file(historyPath)

if os.path.exists(historyPath):
    readline.read_history_file(historyPath)

atexit.register(save_history)
del os, atexit, readline, rlcompleter, save_history, historyPath
