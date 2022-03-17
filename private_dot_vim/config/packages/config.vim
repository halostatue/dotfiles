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

" This is general configuration of packages. Some configuration is present in config/packages/before.vim; these
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
      \ 'elixir',
      \ 'fish',
      \ 'js=javascript',
      \ 'python',
      \ 'ruby',
      \ 'viml=vim',
      \ 'xml',
      \ ]
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ['html', 'python', 'bash=sh']
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

let g:neoformat_enabled_c = ['clangformat'] " ['uncrustify', 'clangformat', 'astyle']
let g:neoformat_enabled_cpp = ['clangformat'] " ['uncrustify', 'clangformat', 'astyle']
let g:neoformat_enabled_cs = ['clangformat'] " ['uncrustify', 'astyle', 'clangformat']
let g:neoformat_enabled_d = ['dfmt'] " ['uncrustify', 'dfmt']
let g:neoformat_enabled_html = [
      \ 'htmlbeautify', 'prettierd', 'prettier', 'prettydiff'
      \ ] " ['htmlbeautify', 'prettierd', 'prettier', 'tidy', 'prettydiff']
let g:neoformat_enabled_java = [
      \ 'clangformat', 'prettierd', 'prettier'
      \ ] " ['uncrustify', 'astyle', 'clangformat', 'prettierd', 'prettier']
let g:neoformat_enabled_javascript = [
      \ 'standard', 'semistandard', 'prettierd', 'prettier', 'denofmt'
      \ ] " ['jsbeautify', 'standard', 'semistandard', 'prettierd', 'prettier', 'prettydiff', 'clangformat',
          " 'esformatter', 'prettiereslint', 'eslint_d', 'denofmt']
let g:neoformat_enabled_javascriptreact = [
      \ 'standard', 'semistandard', 'prettierd', 'prettier', 'denofmt'
      \ ] " ['jsbeautify', 'standard', 'semistandard', 'prettierd', 'prettier', 'prettydiff', 'esformatter',
          " 'prettiereslint', 'eslint_d', 'denofmt']
let g:neoformat_enabled_json = [
      \ 'prettierd', 'prettier', 'jq', 'denofmt'
      \ ] " ['jsbeautify', 'prettydiff', 'prettierd', 'prettier', 'jq', 'fixjson', 'denofmt']
let g:neoformat_enabled_markdown = [
      \ 'prettierd', 'prettier', 'denofmt'
      \ ] " ['remark', 'prettierd', 'prettier', 'denofmt']
let g:neoformat_enabled_objc = ['clangformat'] " ['uncrustify', 'clangformat', 'astyle']
let g:neoformat_enabled_ruby = ['rufo', 'rubybeautify', 'standard', 'rubocop'] " ['rufo', 'rubybeautify', 'rubocop']
let g:neoformat_enabled_typescript = [
      \ 'prettierd', 'prettier', 'denofmt'
      \ ] " ['tsfmt', 'prettierd', 'prettier', 'prettiereslint', 'tslint', 'eslint_d', 'clangformat', 'denofmt']
let g:neoformat_enabled_typescriptreact = [
      \ 'prettierd', 'prettier', 'denofmt'
      \ ] " ['tsfmt', 'prettierd', 'prettier', 'prettiereslint', 'tslint', 'eslint_d', 'clangformat', 'denofmt']
let g:neoformat_enabled_xhtml = ['prettydiff'] " ['tidy', 'prettydiff']
let g:neoformat_enabled_xml = ['prettierd', 'prettier'] " ['tidy', 'prettydiff', 'prettierd', 'prettier']

" let g:neoformat_basic_format_align = 1 " Enable alignment
" let g:neoformat_basic_format_retab = 1 " Enable tab to spaces conversion
" let g:neoformat_basic_format_trim = 1 " Enable trimmming of trailing whitespace
let g:neoformat_try_node_exe = 1 " Try a formatter in `node_modules/.bin`

" function! neoformat#formatters#ruby#standard() abort
"      return {
"         \ 'exe': 'standardrb',
"         \ 'args': ['--auto-correct', '--stdin', '"%:p"', '2>/dev/null', '|', 'sed "1,/^====================$/d"'],
"         \ 'stdin': 1,
"         \ 'stderr': 1
"         \ }
" endfunction
