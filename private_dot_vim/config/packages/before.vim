scriptencoding utf-8

" Prevent several default plug-ins from being loaded, because we don't want
" them.
let g:loaded_2html_plugin = 1 " Disable the TOhtml command.
let g:loaded_getscriptPlugin = 1 " Disable GetLatestVimScripts
let g:loaded_logiPat = 1 " Disable LogiPat
let g:loaded_matchparen = 1 " Disable default matchparen
let g:loaded_netrwPlugin = 1 " Disable netrw and prefer NERD-tree.
let g:netrw_nogx = 1 " disable netrw's gx mapping.

let g:loaded_vimballPlugin = 1 " Disable vimballs.
let g:loaded_matchit = 1 " Disable matchit; using matchup instead

" Ensure that specific useful pre-bundled plug-ins are always enabled.

if !exists('g:loaded_matchit') | packadd matchit | endif
if exists(":Man") != 2 | runtime ftplugin/man.vim | endif

" Configurations that need to be set _before_ loading / autoloading plug-ins to prevent certain behaviours.

" vim-polyglot: Disable languages or add-ins.
" - <name> disables the plugin from Polyglot entirely.
" - <name>.plugin disables the plugin except for filetype detection.
" - autoindent disables vim-sleuth like heuristics
" - sensible disables a copy of vim-sensible
" - ftdetect disables filetype detection
let g:polyglot_disabled = [
      \   'sensible',
      \   'go',
      \ ]

" Is configuration
let g:is#do_default_mappings = 0

let g:swap_no_default_key_mappings = 1

" Disable vim-RSI meta behaviour
" let g:rsi_no_meta = 1

" Share tags cache between vim and gvim
let g:gutentags_cache_dir = hz#xdg_base('cache', 'tags')

runtime config/packages/install_packager.vim
