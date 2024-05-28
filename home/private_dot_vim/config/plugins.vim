scriptencoding utf-8

runtime config/plugins/before.vim

let s:fzf_bin = exepath('fzf')
let s:fzf_added = v:false

if s:fzf_bin == '/opt/local/bin/fzf' && isdirectory('/opt/local/share/fzf/vim')
  let s:fzf_added = v:true
  set rtp+=/opt/local/share/fzf/vim
elseif s:fzf_bin == '/opt/homebrew/bin/fzf' && isdirectory('/opt/homebrew/opt/fzf')
  let s:fzf_added = v:true
  set rtp+=/opt/homebrew/opt/fzf
elseif s:fzf_bin == '/usr/local/bin/fzf' && isdirectory('/usr/local/opt/fzf')
  let s:fzf_added = v:true
  set rtp+=/usr/local/opt/fzf
endif

packadd vim-jetpack

call jetpack#begin()

" Package Manager (self-manage the bootstrapped install)
" https://github.com/tani/vim-jetpack
Jetpack 'tani/vim-jetpack', { 'opt': v:true }

" Improved incremental search
" https://github.com/wincent/loupe
Jetpack 'wincent/loupe'

" Search multiple files
" TRY THIS: https://github.com/eugen0329/vim-esearch
Jetpack 'eugen0329/vim-esearch'
" TRY THIS: https://github.com/wincent/ferret
Jetpack 'wincent/ferret'

" Sudo support: https://github.com/lambdalisue/suda.vim
" Jetpack 'lambdalisue/suda.vim'

" Edit files with line and column
" https://github.com/wsdjeg/vim-fetch
Jetpack 'wsdjeg/vim-fetch'

" `mkdir -p` for file creation
" https://github.com/duggiefresh/vim-easydir
Jetpack 'duggiefresh/vim-easydir'

" Improved matchit/matchparen
" https://github.com/andymass/vim-matchup
Jetpack 'andymass/vim-matchup'

" Load .envrc for vim
" https://github.com/direnv/direnv.vim
Jetpack 'direnv/direnv.vim'

" Pipe output into a scratch / temporary buffer
" https://github.com/AndrewRadev/bufferize.vim
Jetpack 'AndrewRadev/bufferize.vim'

" Show the undo tree, pure vimscript
" https://github.com/mbbill/undotree
Jetpack 'mbbill/undotree'

" Tim Pope utilities.
" Repeat plugin maps
" https://github.com/tpope/vim-repeat
Jetpack 'tpope/vim-repeat'
" Readline-style support
" https://github.com/tpope/vim-rsi
Jetpack 'tpope/vim-rsi'
" Change surrounds easily
" https://github.com/tpope/vim-surround
Jetpack 'tpope/vim-surround'
" Paired mappings
" https://github.com/tpope/vim-unimpaired
Jetpack 'tpope/vim-unimpaired'
" Abbreviation, Subversion, and Coercion
" https://github.com/tpope/vim-abolish
Jetpack 'tpope/vim-abolish'
" Improved C-A / C-X, especially on dates
" https://github.com/tpope/vim-speeddating
Jetpack 'tpope/vim-speeddating'
" Unix command sugar
" https://github.com/tpope/vim-eunuch
Jetpack 'tpope/vim-eunuch'
" Comment management
" https://github.com/tpope/vim-commentary
Jetpack 'tpope/vim-commentary'
" End certain structures automatically
" https://github.com/tpope/vim-endwise
Jetpack 'tpope/vim-endwise'
" Better HTML/template tag mapping
" https://github.com/tpope/vim-ragtag
Jetpack 'tpope/vim-ragtag'

" Evaluate expression
" https://github.com/fvictorio/vim-eval-expression
Jetpack 'fvictorio/vim-eval-expression'

" Asynchronous compiler support
" https://github.com/tpope/vim-dispatch
Jetpack 'tpope/vim-dispatch'

" Preview the contents of registers
" https://github.com/junegunn/vim-peekaboo
Jetpack 'junegunn/vim-peekaboo'

" Only obey some modeline settings
" https://github.com/alexghergh/securemodelines
Jetpack 'alexghergh/securemodelines'

" Makes `gx` do the right thing with URLs
" https://github.com/tyru/open-browser.vim
Jetpack 'tyru/open-browser.vim'

" Sort lines with a motion
" https://github.com/christoomey/vim-sort-motion
Jetpack 'christoomey/vim-sort-motion'

" Change PWD to a project root
" https://github.com/airblade/vim-rooter
Jetpack 'airblade/vim-rooter'

" Add `emoji#for` function
" https://github.com/junegunn/vim-emoji
Jetpack 'junegunn/vim-emoji'

" Add fzf support
if ! s:fzf_added
  " https://github.com/junegunn/fzf
  Jetpack 'junegunn/fzf'
endif

" https://github.com/junegunn/fzf.vim
Jetpack 'junegunn/fzf.vim'

" Safely load local `.vimrc` and/or `.vimrc.lua` files:
" https://github.com/jenterkin/vim-autosource
Jetpack 'jenterkin/vim-autosource'

" Fern is a file tree / explorer
" https://github.com/lambdalisue/vim-fern
Jetpack 'lambdalisue/vim-fern'

" Shows git status in the fern tree
" https://github.com/lambdalisue/fern-git-status.vim
Jetpack 'lambdalisue/fern-git-status.vim'
" Hijacks directory edits with fern
" https://github.com/lambdalisue/fern-hijack.vim
Jetpack 'lambdalisue/fern-hijack.vim'
" Collapse a folder or leave it
" https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim
Jetpack 'hrsh7th/fern-mapping-collapse-or-leave.vim'
" Integrate fzf
" https://github.com/LumaKernel/fern-mapping-fzf.vim
Jetpack 'LumaKernel/fern-mapping-fzf.vim'
" Floating file preview for Fern
" https://github.com/yuki-yano/fern-preview.vim
Jetpack 'yuki-yano/fern-preview.vim'
" Highlight current Fern node for active file
" https://github.com/andykog/fern-highlight.vim
Jetpack 'andykog/fern-highlight.vim'

" File Picker:
" USING THIS: https://github.com/srstevenson/vim-picker
Jetpack 'srstevenson/vim-picker'
" TRY THIS: https://github.com/liuchengxu/vim-clap
Jetpack 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
" RE-TRY THIS: https://github.com/vim-ctrlspace/vim-ctrlspace
" Jetpack 'vim-ctrlspace/vim-ctrlspace'
" File group manager and more
" https://github.com/chimay/wheel
Jetpack 'chimay/wheel'

" Git so awesome, it should be illegal
" https://github.com/tpope/vim-fugitive
Jetpack 'tpope/vim-fugitive'

" Sign column support for almost any VCS
" https://github.com/mhinz/vim-signify
Jetpack 'mhinz/vim-signify'

" Launch screen
" https://github.com/mhinz/vim-startify
Jetpack 'mhinz/vim-startify'

" Ansible
" https://github.com/pearofducks/ansible-vim
Jetpack 'pearofducks/ansible-vim'
" AppleScript
" https://github.com/mityu/vim-applescript
Jetpack 'mityu/vim-applescript', { 'for': 'applescript' }
" Brewfile
" https://github.com/bfontaine/Brewfile.vim
Jetpack 'bfontaine/Brewfile.vim'
" Browserslist constraints
" https://github.com/browserslist/vim-browserslist
Jetpack 'browserslist/vim-browserslist', { 'for': 'browserslist' }
" C/C++ (Modern)
" https://github.com/bfrg/vim-cpp-modern
Jetpack 'bfrg/vim-cpp-modern', { 'for': 'cpp' }
" Crystal
" https://github.com/vim-crystal/vim-crystal
Jetpack 'vim-crystal/vim-crystal', { 'for': 'crystal' }
" CSV
" https://github.com/chrisbra/csv.vim
Jetpack 'chrisbra/csv.vim', { 'for': 'csv' }
" Cue language
" https://github.com/hofstadter-io/cue.vim
Jetpack 'hofstadter-io/cue.vim', { 'for': 'cue' }
" Dart
" https://github.com/dart-lang/dart-vim-plugin
Jetpack 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
" Dhall
" https://github.com/vmchale/dhall-vim
Jetpack 'vmchale/dhall-vim', { 'for': 'dhall' }
" D
" https://github.com/JesseKPhillips/d.vim
Jetpack 'JesseKPhillips/d.vim', { 'for': [ 'd', 'dcov', 'dd', 'ddoc', 'dsdl' ]}
" Elixir
" https://github.com/elixir-editors/vim-elixir
Jetpack 'elixir-editors/vim-elixir', { 'for': 'elixir' }
" Elvish shell
" https://github.com/dmix/elvish.vim
Jetpack 'dmix/elvish.vim', { 'for': 'elvish' }
" Erlang
" https://github.com/vim-erlang/vim-erlang-runtime
Jetpack 'vim-erlang/vim-erlang-runtime', { 'for': 'erlang' }
" Fennel (Lua Lisp)
" https://github.com/bakpakin/fennel.vim
Jetpack 'bakpakin/fennel.vim', { 'for': 'fennel' }
" Fish shell
" https://github.com/blankname/vim-fish
Jetpack 'blankname/vim-fish', { 'for': 'yaml' }
" Git
" https://github.com/tpope/vim-git
Jetpack 'tpope/vim-git', {
      \   'for': [ 'gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git' ]
      \ }
" Github Actions (YAML)
" https://github.com/yasuhiroki/github-actions-yaml.vim
Jetpack 'yasuhiroki/github-actions-yaml.vim', { 'for': 'yaml.gha' }
" Gleam
" https://github.com/gleam-lang/gleam.vim
Jetpack 'gleam-lang/gleam.vim', { 'for': 'gleam' }
" Go
" https://github.com/fatih/vim-go
Jetpack 'fatih/vim-go', {
      \   'for': [ 'go', 'asm', 'gohtmltmpl', 'gosum', 'gowork', 'gomod' ]
      \ }
" GraphQL
" https://github.com/jparise/vim-graphql
Jetpack 'jparise/vim-graphql', { 'for': 'graphql' }
" Haxe
" https://github.com/jdonaldson/vaxe
Jetpack 'jdonaldson/vaxe', {
      \   'for': [ 'flow.javascript', 'haxe', 'hss', 'hxml', 'lime.xml', 'nmml.xml' ]
      \ }
" Hjson
" https://github.com/hjson/vim-hjson
Jetpack 'hjson/vim-hjson', { 'for': 'hjson' }
" HTML
" https://github.com/othree/html5.vim
Jetpack 'othree/html5.vim', { 'for': 'html' }
" Idris2
" https://github.com/edwinb/idris2-vim
Jetpack 'edwinb/idris2-vim', { 'for': [ 'idris2', 'lidris2' ] }
" icalendar
" https://github.com/chutzpah/icalendar.vim
Jetpack 'chutzpah/icalendar.vim', { 'for': 'icalendar' }
" Janet lang
" https://github.com/janet-lang/janet.vim
Jetpack 'janet-lang/janet.vim', { 'for': 'janet' }
" JavaScript
" https://github.com/pangloss/vim-javascript
Jetpack 'pangloss/vim-javascript', { 'for': 'javascript' }
" jq
" https://github.com/vito-c/jq.vim
Jetpack 'vito-c/jq.vim', { 'for': 'jq' }
" JSON
" https://github.com/elzr/vim-json
Jetpack 'elzr/vim-json', { 'for': 'json' }
" Jsonnet
" https://github.com/google/vim-jsonnet
Jetpack 'google/vim-jsonnet', { 'for': 'jsonnet' }
" JSX, which can never be pretty
" https://github.com/MaxMEllon/vim-jsx-pretty
Jetpack 'MaxMEllon/vim-jsx-pretty'
" Julia
" https://github.com/JuliaEditorSupport/julia-vim
Jetpack 'JuliaEditorSupport/julia-vim'
" Just
" https://github.com/NoahTheDuke/vim-just
Jetpack 'NoahTheDuke/vim-just', { 'for': 'just' }
" Log highlighting (generic)
" https://github.com/MTDL9/vim-log-highlighting
Jetpack 'MTDL9/vim-log-highlighting', { 'for': 'log' }
" MJML
" https://github.com/amadeus/vim-mjml
Jetpack 'amadeus/vim-mjml', { 'for': 'mjml' }
" Nim
" https://github.com/zah/nim.vim
Jetpack 'zah/nim.vim', { 'for': 'nim' }
" Nix
" https://github.com/LnL7/vim-nix
Jetpack 'LnL7/vim-nix', { 'for': 'nix' }
" OCaml
" https://github.com/ocaml/vim-ocaml
Jetpack 'ocaml/vim-ocaml', {
      \   'for': [
      \     'dune', 'oasis', 'ocaml', 'ocamlbuild_tags', 'ocpbuild', 'ocpbuildroot',
      \     'omake', 'opam', 'sexplib'
      \   ]
      \ }
" Perl5
" https://github.com/vim-perl/vim-perl
Jetpack 'vim-perl/vim-perl', { 'for': [ 'perl', 'perl6', 'mason' ] }
" PgSQL
" https://github.com/lifepillar/pgsql.vim
Jetpack 'lifepillar/pgsql.vim', { 'for': 'sql' }
" PlantUML
" https://github.com/aklt/plantuml-syntax
Jetpack 'aklt/plantuml-syntax', { 'for': 'plantuml' }
" Prisma syntax highlighting
" https://github.com/prisma/vim-prisma
Jetpack 'prisma/vim-prisma', { 'for': 'prisma' }
" Ruby
" https://github.com/vim-ruby/vim-ruby
Jetpack 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" Ruby Signature
" https://github.com/jlcrochet/vim-rbs
Jetpack 'jlcrochet/vim-rbs', { 'for': 'rbs' }
" Rust
" https://github.com/rust-lang/rust.vim
Jetpack 'rust-lang/rust.vim', { 'for': 'rust' }
" Svelte
" https://github.com/leafOfTree/vim-svelte-plugin
Jetpack 'leafOfTree/vim-svelte-plugin', { 'for': 'svelte' }
" Swift
" https://github.com/keith/swift.vim
Jetpack 'keith/swift.vim', { 'for': 'swift' }
" Terraform
" https://github.com/hashivim/vim-terraform
Jetpack 'hashivim/vim-terraform', { 'for': 'terraform' }
" Typescript
" https://github.com/HerringtonDarkholme/yats.vim
Jetpack 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
" Vue
" https://github.com/posva/vim-vue
Jetpack 'posva/vim-vue', { 'for': 'vue' }


" Generalized Org Mode
" https://github.com/chimay/organ
Jetpack 'chimay/organ'

" Colour highlighter
" https://github.com/ap/vim-css-color
Jetpack 'ap/vim-css-color'

" Autoformat
" https://github.com/sbdchd/neoformat
Jetpack 'sbdchd/neoformat'
" Autoset path searching
" https://github.com/tpope/vim-apathy
Jetpack 'tpope/vim-apathy'
" Rails support
" https://github.com/tpope/vim-rails
Jetpack 'tpope/vim-rails', { 'opt': 1 }
" Rake support
" https://github.com/tpope/vim-rake
Jetpack 'tpope/vim-rake', { 'opt': 1 }
" Bundler support
" https://github.com/tpope/vim-bundler
Jetpack 'tpope/vim-bundler', { 'opt': 1 }
" Automatically insert continuation bacskslashes for vim files
" https://github.com/lambdalisue/vim-backslash
Jetpack 'lambdalisue/vim-backslash'

" Colorschemes
" https://github.com/tyrannicaltoucan/vim-quantum
Jetpack 'tyrannicaltoucan/vim-quantum'
" https://github.com/cocopon/iceberg.vim
Jetpack 'cocopon/iceberg.vim'
" https://github.com/habamax/vim-alchemist
Jetpack 'habamax/vim-alchemist'

" Display completion function signatures in the command-line
" https://github.com/Shougo/echodoc.vim
Jetpack 'Shougo/echodoc.vim'

" Autoclose parentheses
" https://github.com/mattn/vim-lexiv
Jetpack 'mattn/vim-lexiv'

" Split and join code blocks
" https://github.com/AndrewRadev/splitjoin.vim
Jetpack 'AndrewRadev/splitjoin.vim'

" LSP Options
" https://github.com/dense-analysis/ale
" Jetpack 'dense-analysis/ale'
" https://github.com/rhysd/vim-lsp-ale
" Jetpack 'rhysd/vim-lsp-ale'

" https://github.com/neoclide/coc.nvim
" Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }

" https://github.com/vn-ki/coc-clap
" Jetpack 'vn-ki/coc-clap'

" https://github.com/autozimu/LanguageClient-neovim
" Jetpack 'autozimu/LanguageClient-neovim'

" https://github.com/natebosch/vim-lsc
" Jetpack 'natebosch/vim-lsc'

" https://github.com/prabirshrestha/vim-lsp
Jetpack 'prabirshrestha/vim-lsp'
" https://github.com/mattn/vim-lsp-settings
Jetpack 'mattn/vim-lsp-settings'
" https://github.com/prabirshrestha/asyncomplete.vim
Jetpack 'prabirshrestha/asyncomplete.vim'
" https://github.com/prabirshrestha/asyncomplete-lsp.vim
Jetpack 'prabirshrestha/asyncomplete-lsp.vim'

" https://github.com/yegappan/lsp
" Jetpack 'yegappan/lsp'
" https://github.com/normen/vim-lsp-settings-adapter
" Jetpack 'normen/vim-lsp-settings-adapter'

" https://github.com/mattn/vim-lsp-settings
" Jetpack 'mattn/vim-lsp-settings'

" LSP and tag view display
" https://github.com/liuchengxu/vista.vim
Jetpack 'liuchengxu/vista.vim'

" Close HTML tags
" https://github.com/alvan/vim-closetag
Jetpack 'alvan/vim-closetag'

" Tag rename in pairs
" https://github.com/AndrewRadev/tagalong.vim
Jetpack 'AndrewRadev/tagalong.vim'

" Manage tag files automatically
" https://github.com/ludovicchabant/vim-gutentags
Jetpack 'ludovicchabant/vim-gutentags'

" Jump to definitions
" https://github.com/pechorin/any-jump.vim
Jetpack 'pechorin/any-jump.vim'

" Generate a TOC for Markdown
" https://github.com/mzlogin/vim-markdown-toc
Jetpack 'mzlogin/vim-markdown-toc'

" Add more targets
" https://github.com/wellle/targets.vim
Jetpack 'wellle/targets.vim'

" Extended fFtT behaviours
" https://github.com/rhysd/clever-f.vim
Jetpack 'rhysd/clever-f.vim'

" Aid with git merge / rebase conflict resolution
" https://github.com/christoomey/vim-conflicted
Jetpack 'christoomey/vim-conflicted'

" Highlight conflict markers
" https://github.com/rhysd/conflict-marker.vim
Jetpack 'rhysd/conflict-marker.vim'

" Asynchronous execution to quickfix
" https://github.com/hauleth/asyncdo.vim
Jetpack 'hauleth/asyncdo.vim'
" Tame quickfix
" https://github.com/romainl/vim-qf
Jetpack 'romainl/vim-qf'
" Make enhancements (configured like projectionist)
" https://github.com/igemnace/vim-makery
Jetpack 'igemnace/vim-makery'

" Choose a window by letter
" https://github.com/t9md/vim-choosewin
Jetpack 't9md/vim-choosewin'
" Zoom windows
" https://github.com/dhruvasagar/vim-zoom
Jetpack 'dhruvasagar/vim-zoom'

" Multi-language Debugger
" https://github.com/puremourning/vimspector
Jetpack 'puremourning/vimspector'

" Multi-language Test Runner
" https://github.com/vim-test/vim-test
Jetpack 'vim-test/vim-test'

" Gist commands
" https://github.com/mattn/gist-vim
Jetpack 'mattn/gist-vim', { 'opt': 1 }

" Terminal reuse
" https://github.com/kassio/neoterm
Jetpack 'kassio/neoterm'
" Floating terminal
" https://github.com/voldikss/vim-floaterm
Jetpack 'voldikss/vim-floaterm'

" https://github.com/liuchengxu/eleline.vim
Jetpack 'liuchengxu/eleline.vim'
" https://github.com/rbong/vim-crystalline
" https://github.com/vim-airline/vim-airline/
" https://github.com/itchyny/lightline.vim/
" https://github.com/tpope/vim-flagship

" Development utility to bundle useful modules
" https://github.com/vim-jp/vital.vim
Jetpack 'vim-jp/vital.vim', { 'opt': 1 }
" VimL lint
" https://github.com/Vimjas/vint
Jetpack 'Vimjas/vint', { 'opt': 1 }
" Vimscript Test
" https://github.com/junegunn/vader.vim
Jetpack 'junegunn/vader.vim', { 'opt': 1 }
" Vimscript Test
" https://github.com/thinca/vim-themis
Jetpack 'thinca/vim-themis', { 'opt': 1 }
" Vimscript Tricks
" https://github.com/chimay/vimscript-tricks
Jetpack 'chimay/vimscript-tricks'

" https://github.com/alker0/chezmoi.vim
Jetpack 'alker0/chezmoi.vim', { 'opt': 1 }

silent call jetpack#end()
