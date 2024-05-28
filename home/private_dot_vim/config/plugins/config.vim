scriptencoding utf-8

let g:vimsyn_embed = 'lmpPrt'
let g:endwise_abbreviations = 1

" Load on demand. Yanked from junegunn/vim-plug.
function! s:on_demand(cmd, names) abort
  execute printf(
        \ 'command! -nargs=* -range -bang -complete=file %s call s:demand_run(%s, "<bang>", <line1>, <line2>, <q-args>, %s)',
        \ a:cmd, string(a:cmd), string(a:names)
        \ )
endfunction

function! s:demand_run(cmd, bang, l1, l2, args, names) abort
  for l:name in a:names | packadd l:name | endfor
  execute printf('%s%s%s %s', (a:l1 == a:l2 ? '' : (a:l1.','.a:l2)), a:cmd, a:bang, a:args)
endfunction

" This is general configuration of plugins. Some configuration is present in config/plugins/before.vim; these
" configurations are required to prevent certain defaults from being set.

noremap n nzz
noremap N Nzz

" Utility
let g:direnv_silent_load = 1
let g:EditorConfig_exclude_patterns = [
      \ 'fugitive://.*',
      \ 'fern://.*'
      \ ]
      \

" let g:dadbod_manage_dbext = 1

if !has('nvim')
  call s:on_demand('CheckHealth', ['vim-healthcheck'])
else
  command! CheckHealth :checkhealth <args>
endif

call s:on_demand('Vitalize', ['vital.vim'])

" call s:on_demand('RainbowParentheses')

" Project navigation

" https://github.com/tpope/vim-projectionist

" Colorscheme options
let g:deepspace_italics = 1

let g:quantum_italics = 1
let g:quantum_black = 1

" let g:badwolf_darkgutter = 1
" let g:badwolf_css_props_highlight = 1
"
let g:neotrix_italicize_comments = 1
let g:neotrix_italicize_strings = 1
let g:neotrax_dark_contrast = "galaxy" " galaxy_hard, retro, retro_hard

" let g:spacegray_underline_search = 1
let g:spacegray_use_italics = 1
" let g:spacegray_low_contrast = 0

let g:falcon_italic = 1
let g:falcon_bold = 1

let g:ayucolor = "dark"

" https://github.com/prabirshrestha/vim-lsp
" https://github.com/mattn/vim-lsp-settings

let g:lsp_settings_filetype_ruby = [
      \ 'standardrb', 'ruby-lsp', 'solargraph', 'ruby_language_server', 'steep'
      \ ]

" https://github.com/prabirshrestha/asyncomplete.vim
" https://github.com/prabirshrestha/asyncomplete-lsp.vim
" https://github.com/hrsh7th/vim-vsnip-integ
" https://github.com/mattn/vim-lexiv - cohama/lexima.vim?

if exists(':TagbarToggle') == 2 && mapcheck('<F8>', 'n') ==# ''
  let g:tagbar_compact = 1
  nnoremap <silent> <F8> :TagbarToggle<CR>
endif

let g:ragtag_global_maps = 1

" let g:thesaurus_path =
call hz#mkpath(hz#xdg_base('data', 'thesaurus'), v:true)

 " https://github.com/reedes/vim-pencil
 " https://github.com/reedes/vim-lexical
 " opt - https://github.com/junegunn/goyo.vim
 " opt - https://github.com/junegunn/limelight.vim
 " opt - https://github.com/vimwiki/vimwiki

 " opt - https://github.com/wellle/targets.vim
 " https://github.com/rhysd/clever-f.vim
 " https://github.com/edkolev/erlang-motions.vim
 " opt - https://github.com/mg979/vim-visual-multi
 " https://github.com/christoomey/vim-conflicted
 " https://github.com/rhysd/conflict-marker.vim

 " https://github.com/tpope/vim-dispatch
 " https://github.com/hauleth/asyncdo.vim
 " https://github.com/romainl/vim-qf
 " https://github.com/romainl/vim-qlist
 " https://github.com/Olical/vim-enmasse
 " https://github.com/igemnace/vim-makery
 " off - https://github.com/AndrewRadev/qftools.vim
 " off- https://github.com/AndrewRadev/linediff.vim

 " https://github.com/t9md/vim-choosewin
 " https://github.com/dhruvasagar/vim-zoom

  " Optional debug / test stuff {{{
 " opt - https://github.com/Vimjas/vint
 " opt - https://github.com/puremourning/vimspector
 " https://github.com/vim-test/vim-test
 " opt - https://github.com/junegunn/vader.vim
 " opt - https://github.com/tpope/vim-scriptease
 " opt - https://github.com/tweekmonster/exception.vim
 " opt - https://github.com/tweekmonster/helpful.vim
 " opt - https://github.com/mhinz/vim-lookup
 " opt - https://github.com/thinca/vim-themis

 " opt - https://github.com/mattn/gist-vim
 " opt - https://github.com/mbbill/undotree

 " Loaded only for specific filetypes on demand. Requires autocommands below.
 " opt - for js - https://github.com/kristijanhusak/vim-js-file-import
 " opt - for go - https://github.com/fatih/vim-go

" ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
let g:markdown_fenced_languages = [
      \ 'bash=sh',
      \ 'c++=cpp',
      \ 'css',
      \ 'diff',
      \ 'elixir',
      \ 'erlang',
      \ 'fish',
      \ 'html',
      \ 'js=javascript',
      \ 'python',
      \ 'ruby',
      \ 'rust',
      \ 'scss',
      \ 'sql',
      \ 'viml=vim',
      \ 'xml',
      \ ]
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = [
      \ 'bash=sh',
      \ 'c++=cpp',
      \ 'css',
      \ 'diff',
      \ 'elixir',
      \ 'erlang',
      \ 'fish',
      \ 'html',
      \ 'js=javascript',
      \ 'python',
      \ 'ruby',
      \ 'rust',
      \ 'scss',
      \ 'sql',
      \ 'viml=vim',
      \ 'xml',
      \ ]
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_toml_frontmatter = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.html.eex,*.vue'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml,vue,eex.html'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

let g:tagalong_additional_filetypes = [
      \ 'eex.html', 'vue', 'jsx'
      \ ]

let g:pencil_neutral_headings = 1
let g:pencil_gutter_color = 1
let g:pencil_terminal_italics = 1
let g:pencil#conceallevel = 0

" Neoformat configuration

let g:neoformat_enabled_go = ['gofumpt', 'gofmt', 'gofumports', 'goimports']
let g:neoformat_enabled_javascript = [
      \ 'biome', 'standard', 'semistandard', 'prettierd', 'prettier', 'denofmt'
      \ ]
let g:neoformat_enabled_javascriptreact = deepcopy(g:neoformat_enabled_javascript)
let g:neoformat_enabled_json = ['prettierd', 'prettier', 'jq', 'denofmt']
let g:neoformat_enabled_markdown = ['prettierd', 'prettier', 'denofmt', 'mdformat']
let g:neoformat_enabled_ruby = ['standard', 'rufo', 'rubocop']
let g:neoformat_enabled_typescript = ['biome', 'prettierd', 'prettier', 'denofmt']
let g:neoformat_enabled_typescriptreact = deepcopy(g:neoformat_enabled_typescript)
let g:neoformat_enabled_xhtml = ['prettydiff', 'tidy']
let g:neoformat_enabled_xml = ['prettierd', 'prettier', 'prettydiff', 'tidy']

let g:neoformat_try_node_exe = 1 " Try a formatter in `node_modules/.bin`
let g:neoformat_only_msg_on_error = 1

nmap <C-W><S-C> <Plug>(choosewin)

" if ! exists("g:organ_loaded")
"   " ---- DONT FORGET TO INITIALIZE DICTS BEFORE USING THEM
"   let g:organ_config = {}
"   let g:organ_config.prefixless_plugs = {}
"   let g:organ_config.list = {}
"   let g:organ_config.links = {}
"   let g:organ_config.templates = {}
"   " ---- enable for every file if > 0
"   let g:organ_config.everywhere = 0
"   " ---- enable speed keys on first char of headlines and list items
"   let g:organ_config.speedkeys = 1
"   " ---- key to trigger <plug>(organ-previous)
"   " ---- and go where speedkeys are available
"   " ---- examples : <m-p> (default), [z
"   let g:organ_config.previous = '<m-p>'
"   " ---- choose your mappings prefix
"   let g:organ_config.prefix = '<m-o>'
"   " ---- enable prefixless maps
"   let g:organ_config.prefixless = 1
"   " ---- prefixless maps in these modes (default)
"   " ---- possible values : normal, visual, insert
"   " ---- visual maps are defined only when significant
"   let g:organ_config.prefixless_modes = ['normal', 'visual', 'insert']
"   " ---- enable only the prefixless maps you want
"   " ---- leave a list empty to enable all plugs in the mode
"   " ---- see the output of :map <plug>(organ- to see available plugs
"   " let g:organ_config.prefixless_plugs.normal = ['organ-backward', 'organ-forward']
"   " let g:organ_config.prefixless_plugs.visual = []
"   " let g:organ_config.prefixless_plugs.insert = []
"   " ---- number of spaces to indent lists (default)
"   let g:organ_config.list.indent_length = 2
"   " ---- items chars in unordered list (default)
"   let g:organ_config.list.unordered = #{ org : ['-', '+', '*'], markdown : ['-', '+']}
"   " ---- items chars in ordered list (default)
"   let g:organ_config.list.ordered = #{ org : ['.', ')'], markdown : ['.']}
"   " ---- first item counter in an ordered list
"   " ---- must be >= 0, default 1
"   let g:organ_config.list.counter_start = 1
"   " ---- number of stored links to keep (default)
"   let g:organ_config.links.keep = 5
"   " ---- shortcuts to expand templates
"   " ---- examples from default settings
"   " ---- run :echo g:organ_config.templates to see all
"   " -- #+begin_center bloc
"   let g:organ_config.templates['<c'] = 'center'
"   " -- #+include: line
"   let g:organ_config.templates['+i'] = 'include'
"   " ---- todo keywoard cycle
"   " ---- default : todo : TODO - DONE - none
"   " ---- no need to add none to the list
"   let g:organ_config.todo_cycle = ['TODO', 'IN PROGRESS', 'ALMOST DONE', 'DONE']
"   " ---- timestamp format
"   let g:organ_config.timestamp_format = '<%Y-%m-%d %a %H:%M>'
"   " ---- custom maps
"   nmap <c-cr> <plug>(organ-meta-return)
"   imap <c-cr> <plug>(organ-meta-return)
"   nnoremap <backspace> :Organ<space>
" endif
