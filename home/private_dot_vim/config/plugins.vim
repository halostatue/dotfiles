vim9script

runtime config/plugins/before.vim

const fzf_bin = exepath('fzf')
var fzf_added = false

if fzf_bin == '/opt/local/bin/fzf' && isdirectory('/opt/local/share/fzf/vim')
  fzf_added = true
  set rtp+=/opt/local/share/fzf/vim
elseif fzf_bin == '/opt/homebrew/bin/fzf' && isdirectory('/opt/homebrew/opt/fzf')
  fzf_added = true
  set rtp+=/opt/homebrew/opt/fzf
elseif fzf_bin == '/usr/local/bin/fzf' && isdirectory('/usr/local/opt/fzf')
  fzf_added = true
  set rtp+=/usr/local/opt/fzf
endif

packadd vim-packix

import 'packix.vim'

packix.Setup((px: packix.Manager) => {
  # Packix package manager (self-manage the bootstrapped install)
  # https://github.com/halostatue/vim-packix
  px.Local('~/dev/oss/forks/vim-packix', { type: 'opt' })

  # Improved incremental search
  # https://github.com/wincent/loupe
  px.Add('wincent/loupe')

  # Search multiple files.
  # TRY THIS: https://github.com/eugen0329/vim-esearch
  px.Add('eugen0329/vim-esearch')
  # TRY THIS: https://github.com/wincent/ferret
  # px.Add('wincent/ferret')

  if hz#is('unix') && !hz#is('mac')
    # Sudo support
    # https://github.com/lambdalisue/suda.vim
    px.Add('lambdalisue/suda.vim')
  endif

  # Edit files with line and column
  # https://github.com/wsdjeg/vim-fetch
  px.Add('wsdjeg/vim-fetch')

  # `mkdir -p` for file creation
  # https://github.com/duggiefresh/vim-easydir
  px.Add('duggiefresh/vim-easydir')

  # Improved matchit/matchparen
  # https://github.com/andymass/vim-matchup
  px.Add('andymass/vim-matchup')

  # Load .envrc for vim
  # https://github.com/direnv/direnv.vim
  px.Add('direnv/direnv.vim')

  # Pipe output into a scratch / temporary buffer
  # https://github.com/AndrewRadev/bufferize.vim
  px.Add('AndrewRadev/bufferize.vim')

  # Show the undo tree, pure vimscript
  # https://github.com/mbbill/undotree
  px.Add('mbbill/undotree')

  # Tim Pope utilities.
  # Repeat plugin maps
  # https://github.com/tpope/vim-repeat
  px.Add('tpope/vim-repeat')
  # Readline-style support
  # https://github.com/tpope/vim-rsi
  px.Add('tpope/vim-rsi')
  # Change surrounds easily
  # https://github.com/tpope/vim-surround
  px.Add('tpope/vim-surround')
  # Paired mappings
  # https://github.com/tpope/vim-unimpaired
  px.Add('tpope/vim-unimpaired')
  # Abbreviation, Subversion, and Coercion
  # https://github.com/tpope/vim-abolish
  px.Add('tpope/vim-abolish')
  # Improved C-A / C-X, especially on dates
  # https://github.com/tpope/vim-speeddating
  px.Add('tpope/vim-speeddating')
  # Unix command sugar
  # https://github.com/tpope/vim-eunuch
  px.Add('tpope/vim-eunuch')
  # Comment management
  # https://github.com/tpope/vim-commentary
  px.Add('tpope/vim-commentary')
  # End certain structures automatically
  # https://github.com/tpope/vim-endwise
  px.Add('tpope/vim-endwise')
  # Better HTML/template tag mapping
  # https://github.com/tpope/vim-ragtag
  px.Add('tpope/vim-ragtag')

  # Evaluate expression
  # https://github.com/fvictorio/vim-eval-expression
  px.Add('fvictorio/vim-eval-expression')

  # Asynchronous compiler support
  # https://github.com/tpope/vim-dispatch
  px.Add('tpope/vim-dispatch')

  # Preview the contents of registers
  # https://github.com/junegunn/vim-peekaboo
  px.Add('junegunn/vim-peekaboo')

  # Only obey some modeline settings
  # https://github.com/alexghergh/securemodelines
  px.Add('alexghergh/securemodelines')

  # Makes `gx` do the right thing with URLs
  # https://github.com/tyru/open-browser.vim
  px.Add('tyru/open-browser.vim')

  # Sort lines with a motion
  # https://github.com/christoomey/vim-sort-motion
  px.Add('christoomey/vim-sort-motion')

  # Change PWD to a project root
  # https://github.com/airblade/vim-rooter
  px.Add('airblade/vim-rooter')

  # Add `emoji#for` function
  # https://github.com/junegunn/vim-emoji
  px.Add('junegunn/vim-emoji')

  # Add fzf support
  if !fzf_added
    # https://github.com/junegunn/fzf
    px.Add('junegunn/fzf')
  endif

  # https://github.com/junegunn/fzf.vim
  px.Add('junegunn/fzf.vim')

  # Safely load local `.vimrc` and/or `.vimrc.lua` files:
  # https://github.com/jenterkin/vim-autosource
  px.Add('jenterkin/vim-autosource')

  # Fern is a file tree / explorer
  # https://github.com/lambdalisue/vim-fern
  px.Add('lambdalisue/vim-fern')
  # Shows git status in the fern tree
  # https://github.com/lambdalisue/fern-git-status.vim
  px.Add('lambdalisue/fern-git-status.vim')
  # Hijacks directory edits with fern
  # https://github.com/lambdalisue/fern-hijack.vim
  px.Add('lambdalisue/fern-hijack.vim')
  # Collapse a folder or leave it
  # https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim
  px.Add('hrsh7th/fern-mapping-collapse-or-leave.vim')
  # Integrate fzf
  # https://github.com/LumaKernel/fern-mapping-fzf.vim
  px.Add('LumaKernel/fern-mapping-fzf.vim')
  # Floating file preview for Fern
  # https://github.com/yuki-yano/fern-preview.vim
  px.Add('yuki-yano/fern-preview.vim')
  # Highlight current Fern node for active file
  # https://github.com/andykog/fern-highlight.vim
  px.Add('andykog/fern-highlight.vim')
  # Add fern mappings for staging/unstaging
  # https://github.com/lambdalisue/vim-fern-mapping-git
  px.Add('lambdalisue/vim-fern-mapping-git')

  # File Picker:
  # USING THIS: https://github.com/srstevenson/vim-picker
  px.Add('srstevenson/vim-picker')
  # TRY THIS: https://github.com/liuchengxu/vim-clap
  px.Add('liuchengxu/vim-clap', { do: (_) => clap#installer#force_download() })
  # RE-TRY THIS: https://github.com/vim-ctrlspace/vim-ctrlspace
  # px.Add('vim-ctrlspace/vim-ctrlspace')

  # Git so awesome, it should be illegal
  # https://github.com/tpope/vim-fugitive
  px.Add('tpope/vim-fugitive')

  # Sign column support for almost any VCS
  # https://github.com/mhinz/vim-signify
  px.Add('mhinz/vim-signify')

  # Launch screen
  # https://github.com/mhinz/vim-startify
  px.Add('mhinz/vim-startify')

  # Ansible
  # https://github.com/pearofducks/ansible-vim
  px.Add('pearofducks/ansible-vim')
  # AppleScript
  # https://github.com/mityu/vim-applescript
  px.Add('mityu/vim-applescript')
  # Brewfile
  # https://github.com/bfontaine/Brewfile.vim
  px.Add('bfontaine/Brewfile.vim')
  # Browserslist constraints
  # https://github.com/browserslist/vim-browserslist
  px.Add('browserslist/vim-browserslist')
  # C/C++ (Modern)
  # https://github.com/bfrg/vim-cpp-modern
  px.Add('bfrg/vim-cpp-modern')
  # Crystal
  # https://github.com/vim-crystal/vim-crystal
  px.Add('vim-crystal/vim-crystal')
  # CSV
  # https://github.com/chrisbra/csv.vim
  px.Add('chrisbra/csv.vim')
  # Cue language
  # https://github.com/hofstadter-io/cue.vim
  px.Add('hofstadter-io/cue.vim')
  # Dart
  # https://github.com/dart-lang/dart-vim-plugin
  px.Add('dart-lang/dart-vim-plugin')
  # Dhall
  # https://github.com/vmchale/dhall-vim
  px.Add('vmchale/dhall-vim')
  # D
  # https://github.com/JesseKPhillips/d.vim
  px.Add('JesseKPhillips/d.vim')
  # Elixir
  # https://github.com/elixir-editors/vim-elixir
  px.Add('elixir-editors/vim-elixir')
  # Elvish shell
  # https://github.com/dmix/elvish.vim
  px.Add('dmix/elvish.vim')
  # Erlang
  # https://github.com/vim-erlang/vim-erlang-runtime
  px.Add('vim-erlang/vim-erlang-runtime')
  # Fennel (Lua Lisp)
  # https://github.com/bakpakin/fennel.vim
  px.Add('bakpakin/fennel.vim')
  # Fish shell
  # https://github.com/blankname/vim-fish
  px.Add('blankname/vim-fish')
  # Git
  # https://github.com/tpope/vim-git
  px.Add( 'tpope/vim-git')
  # Github Actions (YAML)
  # https://github.com/yasuhiroki/github-actions-yaml.vim
  px.Add('yasuhiroki/github-actions-yaml.vim')
  # Gleam
  # https://github.com/gleam-lang/gleam.vim
  px.Add('gleam-lang/gleam.vim')
  # Go
  # https://github.com/fatih/vim-go
  px.Add('fatih/vim-go', { do: ':GoInstallBinaries' })
  # GraphQL
  # https://github.com/jparise/vim-graphql
  px.Add('jparise/vim-graphql')
  # Haxe
  # https://github.com/jdonaldson/vaxe
  px.Add('jdonaldson/vaxe')
  # Hjson
  # https://github.com/hjson/vim-hjson
  px.Add('hjson/vim-hjson')
  # HTML
  # https://github.com/othree/html5.vim
  px.Add('othree/html5.vim')
  # Idris2
  # https://github.com/edwinb/idris2-vim
  px.Add('edwinb/idris2-vim')
  # icalendar
  # https://github.com/chutzpah/icalendar.vim
  px.Add('chutzpah/icalendar.vim')
  # Janet lang
  # https://github.com/janet-lang/janet.vim
  px.Add('janet-lang/janet.vim')
  # JavaScript
  # https://github.com/pangloss/vim-javascript
  px.Add('pangloss/vim-javascript')
  # jq
  # https://github.com/vito-c/jq.vim
  px.Add('vito-c/jq.vim')
  # JSON
  # https://github.com/elzr/vim-json
  px.Add('elzr/vim-json')
  # Jsonnet
  # https://github.com/google/vim-jsonnet
  px.Add('google/vim-jsonnet')
  # JSX, which can never be pretty
  # https://github.com/MaxMEllon/vim-jsx-pretty
  px.Add('MaxMEllon/vim-jsx-pretty')
  # Julia
  # https://github.com/JuliaEditorSupport/julia-vim
  px.Add('JuliaEditorSupport/julia-vim')
  # Just
  # https://github.com/NoahTheDuke/vim-just
  px.Add('NoahTheDuke/vim-just')
  # Log highlighting (generic)
  # https://github.com/MTDL9/vim-log-highlighting
  px.Add('MTDL9/vim-log-highlighting')
  # MJML
  # https://github.com/amadeus/vim-mjml
  px.Add('amadeus/vim-mjml')
  # Nim
  # https://github.com/zah/nim.vim
  px.Add('zah/nim.vim')
  # Nix
  # https://github.com/LnL7/vim-nix
  px.Add('LnL7/vim-nix')
  # OCaml
  # https://github.com/ocaml/vim-ocaml
  px.Add('ocaml/vim-ocaml')
  # Perl5
  # https://github.com/vim-perl/vim-perl
  px.Add('vim-perl/vim-perl')
  # PgSQL
  # https://github.com/lifepillar/pgsql.vim
  px.Add('lifepillar/pgsql.vim')
  # PlantUML
  # https://github.com/aklt/plantuml-syntax
  px.Add('aklt/plantuml-syntax')
  # Prisma syntax highlighting
  # https://github.com/prisma/vim-prisma
  px.Add('prisma/vim-prisma')
  # Ruby
  # https://github.com/vim-ruby/vim-ruby
  px.Add('vim-ruby/vim-ruby')
  # Ruby Signature
  # https://github.com/jlcrochet/vim-rbs
  px.Add('jlcrochet/vim-rbs')
  # Rust
  # https://github.com/rust-lang/rust.vim
  px.Add('rust-lang/rust.vim')
  # Svelte
  # https://github.com/leafOfTree/vim-svelte-plugin
  px.Add('leafOfTree/vim-svelte-plugin')
  # Swift
  # https://github.com/keith/swift.vim
  px.Add('keith/swift.vim')
  # Terraform
  # https://github.com/hashivim/vim-terraform
  px.Add('hashivim/vim-terraform')
  # Typescript
  # https://github.com/HerringtonDarkholme/yats.vim
  px.Add('HerringtonDarkholme/yats.vim')
  # Vue
  # https://github.com/posva/vim-vue
  px.Add('posva/vim-vue')

  # Generalized Org Mode
  # https://github.com/chimay/organ
  px.Add('chimay/organ')

  # Colour highlighter
  # https://github.com/ap/vim-css-color
  px.Add('ap/vim-css-color')

  # Autoformat
  # https://github.com/sbdchd/neoformat
  px.Add('sbdchd/neoformat')
  # Autoset path searching
  # https://github.com/tpope/vim-apathy
  px.Add('tpope/vim-apathy')
  # Rails support
  # https://github.com/tpope/vim-rails
  px.Add('tpope/vim-rails', { type: 'opt' })
  # Rake support
  # https://github.com/tpope/vim-rake
  px.Add('tpope/vim-rake', { type: 'opt' })
  # Bundler support
  # https://github.com/tpope/vim-bundler
  px.Add('tpope/vim-bundler', { type: 'opt' })
  # Automatically insert continuation bacskslashes for vim files
  # https://github.com/lambdalisue/vim-backslash
  px.Add('lambdalisue/vim-backslash')

  # Colorschemes
  # https://github.com/tyrannicaltoucan/vim-quantum
  px.Add('tyrannicaltoucan/vim-quantum')
  # https://github.com/cocopon/iceberg.vim
  px.Add('cocopon/iceberg.vim')
  # https://github.com/habamax/vim-alchemist
  px.Add('habamax/vim-alchemist')
  # https://github.com/jsit/toast.vim
  px.Add('jsit/toast.vim')
  # https://github.com/pineapplegiant/spaceduck
  px.Add('pineapplegiant/spaceduck')
  # https://github.com/ayu-theme/ayu-vim
  px.Add('ayu-theme/ayu-vim')
  # https://github.com/spencer-p/vim-bwhcc
  px.Add('spencer-p/vim-bwhcc')
  # https://github.com/robertmeta/nofrils
  px.Add('robertmeta/nofrils')

  # Display completion function signatures in the command-line
  # https://github.com/Shougo/echodoc.vim
  px.Add('Shougo/echodoc.vim')

  # Autoclose parentheses
  # https://github.com/mattn/vim-lexiv
  px.Add('mattn/vim-lexiv')

  # Split and join code blocks
  # https://github.com/AndrewRadev/splitjoin.vim
  px.Add('AndrewRadev/splitjoin.vim')

  # LSP Options
  # https://github.com/dense-analysis/ale
  # px.Add('dense-analysis/ale')
  # https://github.com/rhysd/vim-lsp-ale
  # px.Add('rhysd/vim-lsp-ale')

  # https://github.com/neoclide/coc.nvim
  # px.Add('neoclide/coc.nvim', { branch: 'release' })

  # https://github.com/vn-ki/coc-clap
  # px.Add('vn-ki/coc-clap')

  # https://github.com/autozimu/LanguageClient-neovim
  # px.Add('autozimu/LanguageClient-neovim')

  # https://github.com/natebosch/vim-lsc
  # px.Add('natebosch/vim-lsc')

  # https://github.com/prabirshrestha/vim-lsp
  px.Add('prabirshrestha/vim-lsp')
  # https://github.com/mattn/vim-lsp-settings
  px.Add('mattn/vim-lsp-settings')
  # https://github.com/prabirshrestha/asyncomplete.vim
  px.Add('prabirshrestha/asyncomplete.vim')
  # https://github.com/prabirshrestha/asyncomplete-lsp.vim
  px.Add('prabirshrestha/asyncomplete-lsp.vim')
  # https://github.com/prabirshrestha/asyncomplete-file.vim
  px.Add('prabirshrestha/asyncomplete-file.vim')
  # https://github.com/tsuyoshicho/asyncomplete-anylist
  px.Add('tsuyoshicho/asyncomplete-anylist')

  # https://github.com/yegappan/lsp
  # px.Add('yegappan/lsp')
  # https://github.com/normen/vim-lsp-settings-adapter
  # px.Add('normen/vim-lsp-settings-adapter')

  # https://github.com/mattn/vim-lsp-settings
  # px.Add('mattn/vim-lsp-settings')

  # LSP and tag view display
  # https://github.com/liuchengxu/vista.vim
  px.Add('liuchengxu/vista.vim')

  # Close HTML tags
  # https://github.com/alvan/vim-closetag
  px.Add('alvan/vim-closetag')

  # Tag rename in pairs
  # https://github.com/AndrewRadev/tagalong.vim
  px.Add('AndrewRadev/tagalong.vim')

  # Manage tag files automatically
  # https://github.com/ludovicchabant/vim-gutentags
  px.Add('ludovicchabant/vim-gutentags')

  # Jump to definitions
  # https://github.com/pechorin/any-jump.vim
  px.Add('pechorin/any-jump.vim')

  # Generate a TOC for Markdown
  # https://github.com/mzlogin/vim-markdown-toc
  px.Add('mzlogin/vim-markdown-toc')

  # Add more targets
  # https://github.com/wellle/targets.vim
  px.Add('wellle/targets.vim')

  # Extended fFtT behaviours
  # https://github.com/rhysd/clever-f.vim
  px.Add('rhysd/clever-f.vim')

  # Aid with git merge / rebase conflict resolution
  # https://github.com/christoomey/vim-conflicted
  px.Add('christoomey/vim-conflicted')

  # Highlight conflict markers
  # https://github.com/rhysd/conflict-marker.vim
  px.Add('rhysd/conflict-marker.vim')

  # Asynchronous execution to quickfix
  # https://github.com/hauleth/asyncdo.vim
  px.Add('hauleth/asyncdo.vim')
  # Tame quickfix
  # https://github.com/romainl/vim-qf
  px.Add('romainl/vim-qf')
  # Make enhancements (configured like projectionist)
  # https://github.com/igemnace/vim-makery
  px.Add('igemnace/vim-makery')

  # Choose a window by letter
  # https://github.com/t9md/vim-choosewin
  px.Add('t9md/vim-choosewin')
  # Zoom windows
  # https://github.com/dhruvasagar/vim-zoom
  px.Add('dhruvasagar/vim-zoom')

  # Multi-language Debugger
  # https://github.com/puremourning/vimspector
  px.Add('puremourning/vimspector')

  # Multi-language Test Runner
  # https://github.com/vim-test/vim-test
  px.Add('vim-test/vim-test')

  # Gist commands
  # https://github.com/mattn/gist-vim
  px.Add('mattn/gist-vim', { type: 'opt' })

  # Terminal reuse
  # https://github.com/kassio/neoterm
  px.Add('kassio/neoterm')
  # Floating terminal
  # https://github.com/voldikss/vim-floaterm
  px.Add('voldikss/vim-floaterm')

  # https://github.com/liuchengxu/eleline.vim
  px.Add('liuchengxu/eleline.vim')
  # https://github.com/rbong/vim-crystalline
  # https://github.com/vim-airline/vim-airline/
  # https://github.com/itchyny/lightline.vim/
  # https://github.com/tpope/vim-flagship
  
  # Most Recently (used, written, repositories)
  # https://lambdalisue/vim-mr
  px.Add('lambdalisue/vim-mr')

  # Development utility to bundle useful modules
  # https://github.com/vim-jp/vital.vim
  px.Add('vim-jp/vital.vim', { type: 'opt' })
  # VimL lint
  # https://github.com/Vimjas/vint
  px.Add('Vimjas/vint', { type: 'opt' })
  # Vimscript Test
  # https://github.com/junegunn/vader.vim
  px.Add('junegunn/vader.vim', { type: 'opt' })
  # Vimscript Test
  # https://github.com/thinca/vim-themis
  px.Add('thinca/vim-themis', { type: 'opt' })
  # Vimscript Tricks
  # https://github.com/chimay/vimscript-tricks
  px.Add('chimay/vimscript-tricks')

  # https://github.com/alker0/chezmoi.vim
  px.Add('alker0/chezmoi.vim', { type: 'opt' })
})
