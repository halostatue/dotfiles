vim9script

runtime config/plugins/before.vim

const fzf_bin = exepath('fzf')
var fzf_added = v:false

if fzf_bin == '/opt/local/bin/fzf' && isdirectory('/opt/local/share/fzf/vim')
  fzf_added = v:true
  set rtp+=/opt/local/share/fzf/vim
elseif fzf_bin == '/opt/homebrew/bin/fzf' && isdirectory('/opt/homebrew/opt/fzf')
  fzf_added = v:true
  set rtp+=/opt/homebrew/opt/fzf
elseif fzf_bin == '/usr/local/bin/fzf' && isdirectory('/usr/local/opt/fzf')
  fzf_added = v:true
  set rtp+=/usr/local/opt/fzf
endif

def PackagerInit()
  packadd vim-packager

  packager#init()

  # Package Manager (self-manage the bootstrapped install)
  # https://github.com/tani/vim-jetpack
  packager#add('tani/vim-jetpack', { 'type': 'opt' })

  # Improved incremental search
  # https://github.com/wincent/loupe
  packager#add('wincent/loupe')

  # Search multiple files.
  # TRY THIS: https://github.com/eugen0329/vim-esearch
  packager#add('eugen0329/vim-esearch')
  # TRY THIS: https://github.com/wincent/ferret
  packager#add('wincent/ferret')
  # Replacing: https://github.com/dyng/ctrlsf.vim
  # packager#add('dyng/ctrlsf.vim')
  # Replacing: https://github.com/yegappan/grep
  # packager#add('yegappan/grep')

  # Sudo support: https://github.com/lambdalisue/suda.vim
  # packager#add('lambdalisue/suda.vim')

  # Edit files with line and column
  # https://github.com/wsdjeg/vim-fetch
  packager#add('wsdjeg/vim-fetch')

  # `mkdir -p` for file creation
  # https://github.com/duggiefresh/vim-easydir
  packager#add('duggiefresh/vim-easydir')

  # Improved matchit/matchparen
  # https://github.com/andymass/vim-matchup
  packager#add('andymass/vim-matchup')

  # Load .envrc for vim
  # https://github.com/direnv/direnv.vim
  packager#add('direnv/direnv.vim')

  # Pipe output into a scratch / temporary buffer
  # https://github.com/AndrewRadev/bufferize.vim
  packager#add('AndrewRadev/bufferize.vim')

  # Show the undo tree, pure vimscript
  # https://github.com/mbbill/undotree
  packager#add('mbbill/undotree')

  # Tim Pope utilities.
  # Repeat plugin maps
  # https://github.com/tpope/vim-repeat
  packager#add('tpope/vim-repeat')
  # Readline-style support
  # https://github.com/tpope/vim-rsi
  packager#add('tpope/vim-rsi')
  # Change surrounds easily
  # https://github.com/tpope/vim-surround
  packager#add('tpope/vim-surround')
  # Paired mappings
  # https://github.com/tpope/vim-unimpaired
  packager#add('tpope/vim-unimpaired')
  # Abbreviation, Subversion, and Coercion
  # https://github.com/tpope/vim-abolish
  packager#add('tpope/vim-abolish')
  # Improved C-A / C-X, especially on dates
  # https://github.com/tpope/vim-speeddating
  packager#add('tpope/vim-speeddating')
  # Unix command sugar
  # https://github.com/tpope/vim-eunuch
  packager#add('tpope/vim-eunuch')
  # Comment management
  # https://github.com/tpope/vim-commentary
  packager#add('tpope/vim-commentary')
  # End certain structures automatically
  # https://github.com/tpope/vim-endwise
  packager#add('tpope/vim-endwise')
  # Better HTML/template tag mapping
  # https://github.com/tpope/vim-ragtag
  packager#add('tpope/vim-ragtag')

  # Evaluate expression
  # https://github.com/fvictorio/vim-eval-expression
  packager#add('fvictorio/vim-eval-expression')

  # Asynchronous compiler support
  # https://github.com/tpope/vim-dispatch
  packager#add('tpope/vim-dispatch')

  # Preview the contents of registers
  # https://github.com/junegunn/vim-peekaboo
  packager#add('junegunn/vim-peekaboo')

  # Only obey some modeline settings
  # https://github.com/alexghergh/securemodelines
  packager#add('alexghergh/securemodelines')

  # Makes `gx` do the right thing with URLs
  # https://github.com/tyru/open-browser.vim
  packager#add('tyru/open-browser.vim')

  # Sort lines with a motion
  # https://github.com/christoomey/vim-sort-motion
  packager#add('christoomey/vim-sort-motion')

  # Change PWD to a project root
  # https://github.com/airblade/vim-rooter
  packager#add('airblade/vim-rooter')

  # Add `emoji#for` function
  # https://github.com/junegunn/vim-emoji
  packager#add('junegunn/vim-emoji')

  # Add fzf support
  if !fzf_added
    # https://github.com/junegunn/fzf
    packager#add('junegunn/fzf')
  endif

  # https://github.com/junegunn/fzf.vim
  packager#add('junegunn/fzf.vim')

  # Safely load local `.vimrc` and/or `.vimrc.lua` files:
  # https://github.com/jenterkin/vim-autosource
  packager#add('jenterkin/vim-autosource')

  # Fern is a file tree / explorer
  # https://github.com/lambdalisue/vim-fern
  packager#add('lambdalisue/vim-fern')

  # Shows git status in the fern tree
  # https://github.com/lambdalisue/fern-git-status.vim
  packager#add('lambdalisue/fern-git-status.vim')
  # Hijacks directory edits with fern
  # https://github.com/lambdalisue/fern-hijack.vim
  packager#add('lambdalisue/fern-hijack.vim')
  # Collapse a folder or leave it
  # https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim
  packager#add('hrsh7th/fern-mapping-collapse-or-leave.vim')
  # Integrate fzf
  # https://github.com/LumaKernel/fern-mapping-fzf.vim
  packager#add('LumaKernel/fern-mapping-fzf.vim')
  # Floating file preview for Fern
  # https://github.com/yuki-yano/fern-preview.vim
  packager#add('yuki-yano/fern-preview.vim')
  # Highlight current Fern node for active file
  # https://github.com/andykog/fern-highlight.vim
  packager#add('andykog/fern-highlight.vim')

  # File Picker:
  # USING THIS: https://github.com/srstevenson/vim-picker
  packager#add('srstevenson/vim-picker')
  # TRY THIS: https://github.com/liuchengxu/vim-clap
  packager#add('liuchengxu/vim-clap', { 'do': (_) => clap#installer#force_download() })
  # RE-TRY THIS: https://github.com/vim-ctrlspace/vim-ctrlspace
  # packager#add('vim-ctrlspace/vim-ctrlspace')

  # Git so awesome, it should be illegal
  # https://github.com/tpope/vim-fugitive
  packager#add('tpope/vim-fugitive')

  # Sign column support for almost any VCS
  # https://github.com/mhinz/vim-signify
  packager#add('mhinz/vim-signify')

  # Launch screen
  # https://github.com/mhinz/vim-startify
  packager#add('mhinz/vim-startify')

  # Ansible
  # https://github.com/pearofducks/ansible-vim
  packager#add('pearofducks/ansible-vim')
  # AppleScript
  # https://github.com/mityu/vim-applescript
  packager#add('mityu/vim-applescript', { 'for': 'applescript' })
  # Brewfile
  # https://github.com/bfontaine/Brewfile.vim
  packager#add('bfontaine/Brewfile.vim')
  # Browserslist constraints
  # https://github.com/browserslist/vim-browserslist
  packager#add('browserslist/vim-browserslist', { 'for': 'browserslist' })
  # C/C++ (Modern)
  # https://github.com/bfrg/vim-cpp-modern
  packager#add('bfrg/vim-cpp-modern', { 'for': 'cpp' })
  # Crystal
  # https://github.com/vim-crystal/vim-crystal
  packager#add('vim-crystal/vim-crystal', { 'for': 'crystal' })
  # CSV
  # https://github.com/chrisbra/csv.vim
  packager#add('chrisbra/csv.vim', { 'for': 'csv' })
  # Cue language
  # https://github.com/hofstadter-io/cue.vim
  packager#add('hofstadter-io/cue.vim', { 'for': 'cue' })
  # Dart
  # https://github.com/dart-lang/dart-vim-plugin
  packager#add('dart-lang/dart-vim-plugin', { 'for': 'dart' })
  # Dhall
  # https://github.com/vmchale/dhall-vim
  packager#add('vmchale/dhall-vim', { 'for': 'dhall' })
  # D
  # https://github.com/JesseKPhillips/d.vim
  packager#add('JesseKPhillips/d.vim', { 'for': [ 'd', 'dcov', 'dd', 'ddoc', 'dsdl' ]})
  # Elixir
  # https://github.com/elixir-editors/vim-elixir
  packager#add('elixir-editors/vim-elixir')
  # Elvish shell
  # https://github.com/dmix/elvish.vim
  packager#add('dmix/elvish.vim', { 'for': 'elvish' })
  # Erlang
  # https://github.com/vim-erlang/vim-erlang-runtime
  packager#add('vim-erlang/vim-erlang-runtime', { 'for': 'erlang' })
  # Fennel (Lua Lisp)
  # https://github.com/bakpakin/fennel.vim
  packager#add('bakpakin/fennel.vim', { 'for': 'fennel' })
  # Fish shell
  # https://github.com/blankname/vim-fish
  packager#add('blankname/vim-fish', { 'for': 'yaml' })
  # Git
  # https://github.com/tpope/vim-git
  packager#add(
    'tpope/vim-git',
    { 'for': [ 'gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git' ] }
  )
  # Github Actions (YAML)
  # https://github.com/yasuhiroki/github-actions-yaml.vim
  packager#add('yasuhiroki/github-actions-yaml.vim', { 'for': 'yaml.gha' })
  # Gleam
  # https://github.com/gleam-lang/gleam.vim
  packager#add('gleam-lang/gleam.vim', { 'for': 'gleam' })
  # Go
  # https://github.com/fatih/vim-go
  packager#add(
    'fatih/vim-go',
    { 'for': [ 'go', 'asm', 'gohtmltmpl', 'gosum', 'gowork', 'gomod' ], 'do': ':GoInstallBinaries' }
  )
  # GraphQL
  # https://github.com/jparise/vim-graphql
  packager#add('jparise/vim-graphql', { 'for': 'graphql' })
  # Haxe
  # https://github.com/jdonaldson/vaxe
  packager#add(
    'jdonaldson/vaxe',
    { 'for': [ 'flow.javascript', 'haxe', 'hss', 'hxml', 'lime.xml', 'nmml.xml' ] }
  )
  # Hjson
  # https://github.com/hjson/vim-hjson
  packager#add('hjson/vim-hjson', { 'for': 'hjson' })
  # HTML
  # https://github.com/othree/html5.vim
  packager#add('othree/html5.vim', { 'for': 'html' })
  # Idris2
  # https://github.com/edwinb/idris2-vim
  packager#add('edwinb/idris2-vim', { 'for': [ 'idris2', 'lidris2' ] })
  # icalendar
  # https://github.com/chutzpah/icalendar.vim
  packager#add('chutzpah/icalendar.vim', { 'for': 'icalendar' })
  # Janet lang
  # https://github.com/janet-lang/janet.vim
  packager#add('janet-lang/janet.vim', { 'for': 'janet' })
  # JavaScript
  # https://github.com/pangloss/vim-javascript
  packager#add('pangloss/vim-javascript', { 'for': 'javascript' })
  # jq
  # https://github.com/vito-c/jq.vim
  packager#add('vito-c/jq.vim', { 'for': 'jq' })
  # JSON
  # https://github.com/elzr/vim-json
  packager#add('elzr/vim-json', { 'for': 'json' })
  # Jsonnet
  # https://github.com/google/vim-jsonnet
  packager#add('google/vim-jsonnet', { 'for': 'jsonnet' })
  # JSX, which can never be pretty
  # https://github.com/MaxMEllon/vim-jsx-pretty
  packager#add('MaxMEllon/vim-jsx-pretty')
  # Julia
  # https://github.com/JuliaEditorSupport/julia-vim
  packager#add('JuliaEditorSupport/julia-vim')
  # Just
  # https://github.com/NoahTheDuke/vim-just
  packager#add('NoahTheDuke/vim-just', { 'for': 'just' })
  # Log highlighting (generic)
  # https://github.com/MTDL9/vim-log-highlighting
  packager#add('MTDL9/vim-log-highlighting', { 'for': 'log' })
  # MJML
  # https://github.com/amadeus/vim-mjml
  packager#add('amadeus/vim-mjml', { 'for': 'mjml' })
  # Nim
  # https://github.com/zah/nim.vim
  packager#add('zah/nim.vim', { 'for': 'nim' })
  # Nix
  # https://github.com/LnL7/vim-nix
  packager#add('LnL7/vim-nix', { 'for': 'nix' })
  # OCaml
  # https://github.com/ocaml/vim-ocaml
  packager#add(
    'ocaml/vim-ocaml',
    { 'for': [
        'dune', 'oasis', 'ocaml', 'ocamlbuild_tags', 'ocpbuild', 'ocpbuildroot',
        'omake', 'opam', 'sexplib'
      ] }
  )
  # Perl5
  # https://github.com/vim-perl/vim-perl
  packager#add('vim-perl/vim-perl', { 'for': [ 'perl', 'perl6', 'mason' ] })
  # PgSQL
  # https://github.com/lifepillar/pgsql.vim
  packager#add('lifepillar/pgsql.vim', { 'for': 'sql' })
  # PlantUML
  # https://github.com/aklt/plantuml-syntax
  packager#add('aklt/plantuml-syntax', { 'for': 'plantuml' })
  # Prisma syntax highlighting
  # https://github.com/prisma/vim-prisma
  packager#add('prisma/vim-prisma', { 'for': 'prisma' })
  # Ruby
  # https://github.com/vim-ruby/vim-ruby
  packager#add('vim-ruby/vim-ruby', { 'for': 'ruby' })
  # Ruby Signature
  # https://github.com/jlcrochet/vim-rbs
  packager#add('jlcrochet/vim-rbs', { 'for': 'rbs' })
  # Rust
  # https://github.com/rust-lang/rust.vim
  packager#add('rust-lang/rust.vim', { 'for': 'rust' })
  # Svelte
  # https://github.com/leafOfTree/vim-svelte-plugin
  packager#add('leafOfTree/vim-svelte-plugin', { 'for': 'svelte' })
  # Swift
  # https://github.com/keith/swift.vim
  packager#add('keith/swift.vim', { 'for': 'swift' })
  # Terraform
  # https://github.com/hashivim/vim-terraform
  packager#add('hashivim/vim-terraform', { 'for': 'terraform' })
  # Typescript
  # https://github.com/HerringtonDarkholme/yats.vim
  packager#add('HerringtonDarkholme/yats.vim', { 'for': 'typescript' })
  # Vue
  # https://github.com/posva/vim-vue
  packager#add('posva/vim-vue', { 'for': 'vue' })


  # Generalized Org Mode
  # https://github.com/chimay/organ
  packager#add('chimay/organ')

  # Colour highlighter
  # https://github.com/ap/vim-css-color
  packager#add('ap/vim-css-color')

  # Autoformat
  # https://github.com/sbdchd/neoformat
  packager#add('sbdchd/neoformat')
  # Autoset path searching
  # https://github.com/tpope/vim-apathy
  packager#add('tpope/vim-apathy')
  # Rails support
  # https://github.com/tpope/vim-rails
  packager#add('tpope/vim-rails', { 'type': 'opt' })
  # Rake support
  # https://github.com/tpope/vim-rake
  packager#add('tpope/vim-rake', { 'type': 'opt' })
  # Bundler support
  # https://github.com/tpope/vim-bundler
  packager#add('tpope/vim-bundler', { 'type': 'opt' })
  # Automatically insert continuation bacskslashes for vim files
  # https://github.com/lambdalisue/vim-backslash
  packager#add('lambdalisue/vim-backslash')

  # Colorschemes
  # https://github.com/tyrannicaltoucan/vim-quantum
  packager#add('tyrannicaltoucan/vim-quantum')
  # https://github.com/cocopon/iceberg.vim
  packager#add('cocopon/iceberg.vim')
  # https://github.com/habamax/vim-alchemist
  packager#add('habamax/vim-alchemist')

  # Display completion function signatures in the command-line
  # https://github.com/Shougo/echodoc.vim
  packager#add('Shougo/echodoc.vim')

  # Autoclose parentheses
  # https://github.com/mattn/vim-lexiv
  packager#add('mattn/vim-lexiv')

  # Split and join code blocks
  # https://github.com/AndrewRadev/splitjoin.vim
  packager#add('AndrewRadev/splitjoin.vim')

  # LSP Options
  # https://github.com/dense-analysis/ale
  # packager#add('dense-analysis/ale')
  # https://github.com/rhysd/vim-lsp-ale
  # packager#add('rhysd/vim-lsp-ale')

  # https://github.com/neoclide/coc.nvim
  # packager#add('neoclide/coc.nvim', { 'branch': 'release' })

  # https://github.com/vn-ki/coc-clap
  # packager#add('vn-ki/coc-clap')

  # https://github.com/autozimu/LanguageClient-neovim
  # packager#add('autozimu/LanguageClient-neovim')

  # https://github.com/natebosch/vim-lsc
  # packager#add('natebosch/vim-lsc')

  # https://github.com/prabirshrestha/vim-lsp
  packager#add('prabirshrestha/vim-lsp')
  # https://github.com/mattn/vim-lsp-settings
  packager#add('mattn/vim-lsp-settings')
  # https://github.com/prabirshrestha/asyncomplete.vim
  packager#add('prabirshrestha/asyncomplete.vim')
  # https://github.com/prabirshrestha/asyncomplete-lsp.vim
  packager#add('prabirshrestha/asyncomplete-lsp.vim')

  # https://github.com/yegappan/lsp
  # packager#add('yegappan/lsp')
  # https://github.com/normen/vim-lsp-settings-adapter
  # packager#add('normen/vim-lsp-settings-adapter')

  # https://github.com/mattn/vim-lsp-settings
  # packager#add('mattn/vim-lsp-settings')

  # LSP and tag view display
  # https://github.com/liuchengxu/vista.vim
  packager#add('liuchengxu/vista.vim')

  # Close HTML tags
  # https://github.com/alvan/vim-closetag
  packager#add('alvan/vim-closetag')

  # Tag rename in pairs
  # https://github.com/AndrewRadev/tagalong.vim
  packager#add('AndrewRadev/tagalong.vim')

  # Manage tag files automatically
  # https://github.com/ludovicchabant/vim-gutentags
  packager#add('ludovicchabant/vim-gutentags')

  # Jump to definitions
  # https://github.com/pechorin/any-jump.vim
  packager#add('pechorin/any-jump.vim')

  # Generate a TOC for Markdown
  # https://github.com/mzlogin/vim-markdown-toc
  packager#add('mzlogin/vim-markdown-toc')

  # Add more targets
  # https://github.com/wellle/targets.vim
  packager#add('wellle/targets.vim')

  # Extended fFtT behaviours
  # https://github.com/rhysd/clever-f.vim
  packager#add('rhysd/clever-f.vim')

  # Aid with git merge / rebase conflict resolution
  # https://github.com/christoomey/vim-conflicted
  packager#add('christoomey/vim-conflicted')

  # Highlight conflict markers
  # https://github.com/rhysd/conflict-marker.vim
  packager#add('rhysd/conflict-marker.vim')

  # Asynchronous execution to quickfix
  # https://github.com/hauleth/asyncdo.vim
  packager#add('hauleth/asyncdo.vim')
  # Tame quickfix
  # https://github.com/romainl/vim-qf
  packager#add('romainl/vim-qf')
  # Make enhancements (configured like projectionist)
  # https://github.com/igemnace/vim-makery
  packager#add('igemnace/vim-makery')

  # Choose a window by letter
  # https://github.com/t9md/vim-choosewin
  packager#add('t9md/vim-choosewin')
  # Zoom windows
  # https://github.com/dhruvasagar/vim-zoom
  packager#add('dhruvasagar/vim-zoom')

  # Multi-language Debugger
  # https://github.com/puremourning/vimspector
  packager#add('puremourning/vimspector')

  # Multi-language Test Runner
  # https://github.com/vim-test/vim-test
  packager#add('vim-test/vim-test')

  # Gist commands
  # https://github.com/mattn/gist-vim
  packager#add('mattn/gist-vim', { 'type': 'opt' })

  # Terminal reuse
  # https://github.com/kassio/neoterm
  packager#add('kassio/neoterm')
  # Floating terminal
  # https://github.com/voldikss/vim-floaterm
  packager#add('voldikss/vim-floaterm')

  # https://github.com/liuchengxu/eleline.vim
  packager#add('liuchengxu/eleline.vim')
  # https://github.com/rbong/vim-crystalline
  # https://github.com/vim-airline/vim-airline/
  # https://github.com/itchyny/lightline.vim/
  # https://github.com/tpope/vim-flagship

  # Development utility to bundle useful modules
  # https://github.com/vim-jp/vital.vim
  packager#add('vim-jp/vital.vim', { 'type': 'opt' })
  # VimL lint
  # https://github.com/Vimjas/vint
  packager#add('Vimjas/vint', { 'type': 'opt' })
  # Vimscript Test
  # https://github.com/junegunn/vader.vim
  packager#add('junegunn/vader.vim', { 'type': 'opt' })
  # Vimscript Test
  # https://github.com/thinca/vim-themis
  packager#add('thinca/vim-themis', { 'type': 'opt' })
  # Vimscript Tricks
  # https://github.com/chimay/vimscript-tricks
  packager#add('chimay/vimscript-tricks')

  # https://github.com/alker0/chezmoi.vim
  packager#add('alker0/chezmoi.vim', { 'type': 'opt' })
enddef

command! -nargs=* -bar PackagerRefresh call PackagerInit() | call packager#install(<args>)
command! -nargs=* -bar PackagerInstall call PackagerInit() | call packager#install(<args>)
command! -nargs=* -bar PackagerUpdate call PackagerInit() | call packager#update(<args>)
command! -bar PackagerClean call PackagerInit() | call packager#clean()
command! -bar PackagerStatus call PackagerInit() | call packager#status()
