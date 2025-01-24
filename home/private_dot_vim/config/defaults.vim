vim9script

if get(g:, 'hz_config_defaults_loaded')
  finish
endif

g:hz_config_defaults_loaded = true

## 1. Set variables defined in tpope/vim-sensible or sheerun/vimrc:

# Correctly highlight $() and other modern affordances in filetype=sh.
if !exists('g:is_posix') && !exists('g:is_bash') && !exists('g:is_kornshell') && !exists('g:is_dash')
  g:is_posix = true
endif

# Set the mapleader to <Space>.
g:mapleader = "\<Space>"

## 2. Disable several default plugins.

g:loaded_getscriptPlugin = true # GetLatestVimScripts: Not needed with a plugin manager
g:loaded_logiPat = true         # LogiPat: Never used, not needed
g:loaded_matchparen = true      # matchparen: Replaced with andymass/vim-matchup
g:loaded_netrwPlugin = true     # netrw: Replaced with Fern
g:netrw_nogx = true             #        Ensure gx mapping is always disabled.
g:loaded_2html_plugin = true    # tohtml: This was useful a decade ago
g:loaded_vimballPlugin = true   # vimball: Not needed with a plugin manager
g:loaded_matchit = true         # matchit: andymass/vim-matchup is better

## 3. Set various syntax plugin configurations.
#     These options need to be set *before* the syntax loads.

# pearofducks/ansible-vim
g:ansible_unindent_after_newline = true
g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }
g:ansible_extra_keywords_highlight = true

# elixir-editors/vim-elixir
# Disable this if elixir is an embedded syntax type for Markdown
# as it will result in a circular load.
# g:elixir_use_markdown_for_docs = true

# tpope/vim-git
g:gitcommit_summary_length = 50

# leafOfTree/vim-svelte-plugin: Typescript and Sass. Typescript depends on
# leafgarland/typescript-vim or HerringtonDarkholme/yats.vim.
g:vim_svelte_plugin_use_typescript = true
g:vim_svelte_plugin_use_sass = true

# C++ syntax (builtin)
g:cpp_attributes_highlight = true
g:cpp_function_highlight = true
g:cpp_member_highlight = true
g:cpp_simple_highlight = true

# Vim syntax (builtin)
# Allow embedded Lua, mzscheme, Perl, Python, Ruby, and Tcl highlighting.
g:vimsyn_embed = 'lmpPrt'

## 4. Set various configurations before loading plug-ins to prevent or set certain
##    behaviours.

# Disable vim-RSI meta behaviour on macOS.
if hz#Is('mac')
  g:rsi_no_meta = 1
endif

# Put tags in an XDGish path instead of in each directory
g:gutentags_cache_dir = hz#MkXdgVimPath('cache', 'tags')

# Disable Neovim job checking and default ferret maps
g:FerretMap = false
g:FerretNvim = false

# Disable easyjump and fFtT plugins included in the girishji/vimbits suite.
g:vimbits_easyjump = false
g:vimbits_fFtT = false

# Enable tpope/vim-endwise abbreviations for certain languages
g:endwise_abbreviations = true

# Silence direnv/direnv.vim
g:direnv_silent_load = true

# Exclude Fugitive and Fern buffers
g:EditorConfig_exclude_patterns =
  g:->get('EditorConfig_exclude_patterns', [])
    ->extend(['fugitive://.*', 'fern://.*'])

# tpope/vim-ragtag: Enable insert maps C-x H, C-x /, C-x %, C-x &, C-v %, and C-v &
g:ragtag_global_maps = true

# Support a shared thesaurus location. Best used with reedes/vim-lexical (not currently
# used).
g:thesaurus_path = hz#MkXdgVimPath('data', 'thesaurus')

# alvan/vim-closetag
g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.html.eex,*.vue'
g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
g:closetag_filetypes = 'html,xhtml,phtml,vue,eex.html'
g:closetag_xhtml_filetypes = 'xhtml,jsx'
g:closetag_emptyTags_caseSensitive = 1
g:closetag_regions = {
  'typescript.tsx': 'jsxRegion,tsxRegion',
  'javascript.jsx': 'jsxRegion',
}
g:closetag_shortcut = '>'
g:closetag_close_shortcut = '<leader>>'

# AndrewRadev/tagalong.vim
g:tagalong_additional_filetypes = [ 'eex.html', 'vue', 'jsx' ]

# sbdchd/neoformat
g:neoformat_enabled_go = ['gofumpt', 'gofmt', 'gofumports', 'goimports']
g:neoformat_enabled_javascript = [
  'biome', 'standard', 'semistandard', 'prettierd', 'prettier', 'denofmt'
]
g:neoformat_enabled_javascriptreact = deepcopy(g:neoformat_enabled_javascript)
g:neoformat_enabled_json = ['prettierd', 'prettier', 'jq', 'denofmt']
g:neoformat_enabled_markdown = ['prettierd', 'prettier', 'denofmt', 'mdformat']
g:neoformat_enabled_ruby = ['standard', 'rufo', 'rubocop']
g:neoformat_enabled_typescript = ['biome', 'prettierd', 'prettier', 'denofmt']
g:neoformat_enabled_typescriptreact = deepcopy(g:neoformat_enabled_typescript)
g:neoformat_enabled_xhtml = ['prettydiff', 'tidy']
g:neoformat_enabled_xml = ['prettierd', 'prettier', 'prettydiff', 'tidy']

g:neoformat_try_node_exe = 1 # Try a formatter in `node_modules/.bin`
g:neoformat_only_msg_on_error = 1

# tpope/vim-dispatch
for strategy in ['tmux', 'screen', 'windows', 'iterm', 'x11']
  g:['dispatch_no_' .. strategy .. 'make'] = true
  g:['dispatch_no_' .. strategy .. 'start'] = true
endfor

# airblade/vim-rooter
g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn']
g:rooter_silent_chdir = true  # Quietly
g:rooter_cd_cmd = 'lcd'       # Ensure that rooter only changes the window path

# jenterkin/vim-autosource
g:autosource_hashdir = hz#MkXdgVimPath('data', 'site', 'autosource_hashes')

# Donaldttt/fuzzyy
g:enable_fuzzyy_keymaps = false

# # Enable Eliot00/git-lens.vim
# g:GIT_LENS_ENABLED = true

# Distraction-free writing with Pencil and junegunn/goyo-vim
g:pencil#textwidth = 80
g:goyo_width = 80

# Colour schemes

# tyrannical/toucan/vim-quantum
g:quantum_black = true
g:quantum_italics = true

# sjl/badwolf colour scheme options
g:badwolf_darkgutter = true           # Gutter is darker
g:badwolf_tabline = 3                 # Tabline is much lighter
g:badwolf_css_props_highlight = true  # Highlight CSS properties

# fenetikm/falcon colour scheme options
g:falcon_italic = true                # Enable italics
g:falcon_bold = true                  # Enable bold

# ayu-theme/ayu-vim colour scheme style
g:ayucolor = 'dark'                   # Values: 'dark', 'light', 'mirage'

# robertmeta/nofrils colour scheme options
g:nofrils_strbackgrounds = true       # Highlight string backgrounds
g:nofrils_heavycomments = true        # High-contrast comments
g:nofrils_heavylinenumbers = true     # Brighter line numbers
