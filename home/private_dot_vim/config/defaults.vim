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

## 3. Set various syntax plugin configurations.

# leafOfTree/vim-svelte-plugin: Typescript and Sass. Typescript depends on
# leafgarland/typescript-vim or HerringtonDarkholme/yats.vim.
g:vim_svelte_plugin_use_typescript = true
g:vim_svelte_plugin_use_sass = true

# Configure Vim's builtin markdown configuration.
g:markdown_fenced_languages = [
  'bash=sh', 'console=sh', 'c++=cpp', 'css', 'diff', 'elixir', 'erlang',
  'fish', 'go', 'html', 'javascript', 'js=javascript', 'python', 'ruby',
  'rust', 'scss', 'sql', 'vim', 'viml=vim', 'ts=typescript', 'typescript',
  'xml', 'zsh=sh',
]
g:markdown_syntax_conceal = 0
g:markdown_minlines = 100
g:markdown_yaml_head = true

g:vim_markdown_conceal = false
g:vim_markdown_conceal_code_blocks = false
g:vim_markdown_fenced_languages = deepcopy(g:markdown_fenced_languages)
g:vim_markdown_frontmatter = true
g:vim_markdown_folding_disabled = true
g:vim_markdown_json_frontmatter = true
g:vim_markdown_no_default_key_mappings = true
g:vim_markdown_no_extensions_in_markdown = true
g:vim_markdown_strikethrough = true
g:vim_markdown_toc_autofit = true
g:vim_markdown_toml_frontmatter = true

g:ansible_unindent_after_newline = true

g:cpp_attributes_highlight = true
g:cpp_function_highlight = true
g:cpp_member_highlight = true
g:cpp_simple_highlight = true

## 4. Set various configurations before loading plug-ins to prevent or set certain
##    behaviours.

# Disable vim-RSI meta behaviour on macOS.
if hz#Is('mac')
  g:rsi_no_meta = 1
endif

# Put tags in an XDGish path instead of in each directory
g:gutentags_cache_dir = hz#MkXdgVimPath('cache', 'tags')

# If we enable wincent/ferret, this disabled Neovim job checking.
g:FerretNvim = false

# Disable easyjump and fFtT plugins included in the girishji/vimbits suite.
g:vimbits_easyjump = false
g:vimbits_fFtT = false

# Configure kennypete/vim-tene mode characters.
g:tene_modes = {
  'n': 'ℕ', 'no': '𝕆', 'nov': '𝕆𝕧', 'noV': '𝕆𝕍', 'noCTRL-V': '𝕆^𝕍',
  'nil': '𝕀𝕟', 'niR': 'ℝ𝕟', 'niV': '𝕍ℝ', 'nt': '𝕋ℕ',
  'v': '𝕧', 'vs': 'v𝕤', 'V': '𝕍', 'Vs': '𝕍𝕤', 'CTRL-V': '^𝕍', 'CTRL-Vs': '^𝕍𝕤',
  's': '𝕤', 'S': '𝕊', 'CTRL-S': '^𝕊',
  'i': '𝕚', 'ic': '𝕚𝕔', 'ix': '𝕚𝕩',
  'R': 'ℝ', 'Rc': 'ℝ𝕔', 'Rx': 'ℝ𝕩', 'Rvc': '𝕍ℝ𝕔', 'Rvx': '𝕍ℝ𝕩',
  'c': 'ℂ', 'ct': 'ℂ𝕥', 'cr': 'ℂ𝕣', 'cv': 'ℂ𝕩', 'cvr': 'ℂ𝕩𝕣', 'ce': '𝕏', 't': '𝕋'
}

# Configure kennypete/vim-tene icon characters
g:tene_ga = {
  'buftypehelp': ['help', '⍰'],
  'paste': ['P', '🅿'],
  'mod': ['[+]', '⊕'],
  'noma': ['[-]', '⊖'],
  'pvw': ['[Preview]', '📺'],
  'key': ['E', '🔑'],
  'spell': ['S', '✓'],
  'recording': ['@', '⊙'],
  'ro': ['[RO]', '🚫'],
  'col()': ['c', '⩙']
}

# Vim syntax (builtin)
# Allow embedded Lua, mzscheme, Perl, Python, Ruby, and Tcl highlighting.
g:vimsyn_embed = 'lmpPrt'

# Enable tpope/vim-endwise abbreviations for certain languages
g:endwise_abbreviations = true

# Silence direnv/direnv.vim
g:direnv_silent_load = true

# Exclude Fugitive and Fern buffers
g:EditorConfig_exclude_patterns =
  g:->get('EditorConfig_exclude_patterns', [])
    ->extend(['fugitive://.*', 'fern://.*'])

# sjl/badwolf colour scheme options
g:badwolf_darkgutter = true           # Gutter is darker
g:badwolf_tabline = 3                 # Tabline is much ligher
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
g:enable_fuzzyykeymaps = false

# if ! exists('g:organ_loaded')
#   # ---- DONT FORGET TO INITIALIZE DICTS BEFORE USING THEM
#   g:organ_config = {}
#   g:organ_config.prefixless_plugs = {}
#   g:organ_config.list = {}
#   g:organ_config.links = {}
#   g:organ_config.templates = {}
#   # ---- enable for every file if > 0
#   g:organ_config.everywhere = 0
#   # ---- enable speed keys on first char of headlines and list items
#   g:organ_config.speedkeys = 1
#   # ---- key to trigger <plug>(organ-previous)
#   # ---- and go where speedkeys are available
#   # ---- examples : <m-p> (default), [z
#   g:organ_config.previous = '<m-p>'
#   # ---- choose your mappings prefix
#   g:organ_config.prefix = '<m-o>'
#   # ---- enable prefixless maps
#   g:organ_config.prefixless = 1
#   # ---- prefixless maps in these modes (default)
#   # ---- possible values : normal, visual, insert
#   # ---- visual maps are defined only when significant
#   g:organ_config.prefixless_modes = ['normal', 'visual', 'insert']
#   # ---- enable only the prefixless maps you want
#   # ---- leave a list empty to enable all plugs in the mode
#   # ---- see the output of :map <plug>(organ- to see available plugs
#   # g:organ_config.prefixless_plugs.normal = ['organ-backward', 'organ-forward']
#   # g:organ_config.prefixless_plugs.visual = []
#   # g:organ_config.prefixless_plugs.insert = []
#   # ---- number of spaces to indent lists (default)
#   g:organ_config.list.indent_length = 2
#   # ---- items chars in unordered list (default)
#   g:organ_config.list.unordered = #{ org : ['-', '+', '*'], markdown : ['-', '+']}
#   # ---- items chars in ordered list (default)
#   g:organ_config.list.ordered = #{ org : ['.', ')'], markdown : ['.']}
#   # ---- first item counter in an ordered list
#   # ---- must be >= 0, default 1
#   g:organ_config.list.counter_start = 1
#   # ---- number of stored links to keep (default)
#   g:organ_config.links.keep = 5
#   # ---- shortcuts to expand templates
#   # ---- examples from default settings
#   # ---- run :echo g:organ_config.templates to see all
#   # -- #+begin_center bloc
#   g:organ_config.templates['<c'] = 'center'
#   # -- #+include: line
#   g:organ_config.templates['+i'] = 'include'
#   # ---- todo keywoard cycle
#   # ---- default : todo : TODO - DONE - none
#   # ---- no need to add none to the list
#   g:organ_config.todo_cycle = ['TODO', 'IN PROGRESS', 'ALMOST DONE', 'DONE']
#   # ---- timestamp format
#   g:organ_config.timestamp_format = '<%Y-%m-%d %a %H:%M>'
#   # ---- custom maps
#   nmap <c-cr> <plug>(organ-meta-return)
#   imap <c-cr> <plug>(organ-meta-return)
#   nnoremap <backspace> :Organ<space>
# endif
