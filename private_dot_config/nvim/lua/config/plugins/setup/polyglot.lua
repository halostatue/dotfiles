local g = vim.g

-- vim-polyglot: Disable languages or add-ins.
-- - <name> disables the plugin from Polyglot entirely.
-- - <name>.plugin disables the plugin except for filetype detection.
-- - autoindent disables vim-sleuth like heuristics
-- - sensible disables a copy of vim-sensible
-- - ftdetect disables filetype detection
g.polyglot_disabled = { 'sensible', 'go', 'bzl' }
