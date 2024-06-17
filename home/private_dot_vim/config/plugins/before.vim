vim9script

# Prevent several default plug-ins from being loaded, because I don't want
# them.
g:loaded_2html_plugin = 1 # Disable the TOhtml command.
g:loaded_getscriptPlugin = 1 # Disable GetLatestVimScripts
g:loaded_logiPat = 1 # Disable LogiPat
g:loaded_matchit = 1 # Disable matchit; using matchup instead
g:loaded_matchparen = 1 # Disable default matchparen
g:loaded_netrwPlugin = 1 # Disable netrw and prefer NERD-tree.
g:loaded_vimballPlugin = 1 # Disable vimballs.
g:netrw_nogx = 1 # disable netrw's gx mapping.

# Ensure that specific useful pre-bundled plug-ins are always enabled.

packadd matchit
runtime ftplugin/man.vim

# Configurations that must be set _before_ loading / autoloading plug-ins to
# prevent certain behaviours.

# Incremental search configuration
g:is#do_default_mappings = 0

g:swap_no_default_key_mappings = 1

# Disable vim-RSI meta behaviour
# g:rsi_no_meta = 1

# Share tags cache between vim and gvim
g:gutentags_cache_dir = hz#xdg_base('cache', 'tags')

g:vim_svelte_plugin_use_typescript = 1
g:vim_svelte_plugin_use_sass = 1

g:svelte_indent_script = 0
g:svelte_indent_style = 0
g:svelte_preprocessors = ['typescript', 'scss']

g:splitjoin_split_mapping = "<Leader>S"
g:splitjoin_join_mapping = "<Leader>J"
g:splitjoin_quiet = v:true
g:splitjoin_ruby_do_block_split = v:false
g:splitjoin_python_brackets_on_separate_lines = v:true
g:splitjoin_html_attributes_bracket_on_new_line = v:true
g:splitjoin_java_argument_split_first_newline = v:true
g:splitjoin_java_argument_split_last_newline = v:true

g:lsc_auto_map = true

g:FerretNvim = false

runtime config/plugins/install_plugin_manager.vim
