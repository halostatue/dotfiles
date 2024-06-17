vim9script

g:vimsyn_embed = 'lmpPrt'

g:endwise_abbreviations = 1

import 'deferred.vim'

# This is general configuration of plugins. Some configuration is present in
# config/plugins/before.vim; these configurations are required to prevent
# certain defaults from being set.

noremap n nzz
noremap N Nzz

# Utility
g:direnv_silent_load = 1
g:EditorConfig_exclude_patterns = [
      \ 'fugitive://.*',
      \ 'fern://.*'
      \ ]
      \

# deferred.Define('CheckHealth', 'vim-healthcheck')
deferred.Define('Vitalize', 'vital.vim')

# Colorscheme options
g:deepspace_italics = 1
g:quantum_italics = 1
g:quantum_black = 1

g:badwolf_darkgutter = 1
g:badwolf_css_props_highlight = 1

g:neotrix_italicize_comments = 1
g:neotrix_italicize_strings = 1
g:neotrax_dark_contrast = "galaxy" # galaxy_hard, retro, retro_hard

g:spacegray_underline_search = 1
g:spacegray_use_italics = 1
g:spacegray_low_contrast = 0

g:falcon_italic = 1
g:falcon_bold = 1

g:ayucolor = "dark"

g:nofrils_strbackgrounds = true
g:nofrils_heavycomments = true
g:nofrils_heavylinenumbers = true

# https://github.com/prabirshrestha/vim-lsp
# https://github.com/mattn/vim-lsp-settings

g:lsp_settings_filetype_ruby = [
  'standardrb', 'ruby-lsp', 'solargraph', 'ruby_language_server', 'steep'
]

# https://github.com/prabirshrestha/asyncomplete.vim
# https://github.com/prabirshrestha/asyncomplete-lsp.vim
# https://github.com/hrsh7th/vim-vsnip-integ
# https://github.com/mattn/vim-lexiv - cohama/lexima.vim?

if exists(':TagbarToggle') == 2 && mapcheck('<F8>', 'n') ==# ''
  g:tagbar_compact = 1
  nnoremap <silent> <F8> :TagbarToggle<CR>
endif

g:ragtag_global_maps = 1

# g:thesaurus_path =
hz#mkpath(hz#xdg_base('data', 'thesaurus'), true)

# https://github.com/reedes/vim-pencil
# https://github.com/reedes/vim-lexical
# opt - https://github.com/junegunn/goyo.vim
# opt - https://github.com/junegunn/limelight.vim
# opt - https://github.com/vimwiki/vimwiki

# opt - https://github.com/wellle/targets.vim
# https://github.com/rhysd/clever-f.vim
# https://github.com/edkolev/erlang-motions.vim
# opt - https://github.com/mg979/vim-visual-multi
# https://github.com/christoomey/vim-conflicted
# https://github.com/rhysd/conflict-marker.vim
#
# https://github.com/tpope/vim-dispatch
# https://github.com/hauleth/asyncdo.vim
# https://github.com/romainl/vim-qf
# https://github.com/romainl/vim-qlist
# https://github.com/Olical/vim-enmasse
# https://github.com/igemnace/vim-makery
# off - https://github.com/AndrewRadev/qftools.vim
# off- https://github.com/AndrewRadev/linediff.vim
#
# https://github.com/t9md/vim-choosewin
# https://github.com/dhruvasagar/vim-zoom
#
# Optional debug / test stuff {{{
# opt - https://github.com/Vimjas/vint
# opt - https://github.com/puremourning/vimspector
# https://github.com/vim-test/vim-test
# opt - https://github.com/junegunn/vader.vim
# opt - https://github.com/tpope/vim-scriptease
# opt - https://github.com/tweekmonster/exception.vim
# opt - https://github.com/tweekmonster/helpful.vim
# opt - https://github.com/mhinz/vim-lookup
# opt - https://github.com/thinca/vim-themis
#
# opt - https://github.com/mattn/gist-vim
# opt - https://github.com/mbbill/undotree
#
# Loaded only for specific filetypes on demand.
# Requires autocommands below.
# opt - for go - https://github.com/fatih/vim-go

g:markdown_fenced_languages = [
  'bash=sh', 'console=sh', 'c++=cpp', 'css', 'diff', 'elixir', 'erlang',
  'fish', 'go', 'html', 'javascript', 'js=javascript', 'python', 'ruby',
  'rust', 'scss', 'sql', 'vim', 'viml=vim', 'ts=typescript', 'typescript',
  'xml', 'zsh=sh',
]
g:markdown_syntax_conceal = false
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

g:tagalong_additional_filetypes = [ 'eex.html', 'vue', 'jsx' ]

g:pencil_neutral_headings = 1
g:pencil_gutter_color = 1
g:pencil_terminal_italics = 1
g:pencil#conceallevel = 0

# Neoformat configuration

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

nmap <C-W><S-C> <Plug>(choosewin)

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
