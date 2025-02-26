vim9script

## 1. Add specific useful pre-bundled plugins.

# Edit Existing tries to reuse an open Vim instance
packadd! editexisting

# Editorconfig support is bundled now
packadd! editorconfig

# Vim 9.1.369 or later includes a comment plugin that may replace tpope/vim-commentary
if v:versionlong >= 9010369
  packadd! comment
endif

if exists(':Man') != 2 && !exists('g:loaded_man') && &filetype !=? 'man'
  runtime ftplugin/man.vim
endif

## 2. Try to install vim-packix

const vim_site = hz#MkXdgVimPath('data', 'site')

if &packpath !~# vim_site
    &packpath = vim_site .. ',' .. &packpath
endif

const pack_root = vim_site .. '/pack/packix/opt'
mkdir(pack_root, 'p')

const packix_path = pack_root .. '/vim-packix'
const packix_url = "https://github.com/halostatue/vim-packix.git"

if has('vim_starting') && !isdirectory(packix_path .. '/.git')
  const command = printf('silent !git clone %s %s', packix_url, packix_path)

  silent execute command

  augroup install-vim-packix
    autocmd!
    autocmd VimEnter * if exists(':PackixInstall') == 2 | PackixInstall | endif
  augroup END
endif

## 3. Use fzf vim integration if present.

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

## 4. Add Ghostty vim integration if present

if isdirectory('/Applications/Ghostty.app/Contents/Resources/vim/vimfiles')
  set rtp+=/Applications/Ghostty.app/Contents/Resources/vim/vimfiles
endif

## 5. Use vim-packix to define

packadd vim-packix

import autoload 'packix.vim'

packix.Setup((px: packix.Packix) => {
  # Packix package manager (self-manage the bootstrapped install)
  # https://github.com/halostatue/vim-packix
  if isdirectory(expand('~/oss/vim/vim-packix'))
    px.Local('~/oss/vim/vim-packix', { type: 'opt' })
  else
    px.Add('halostatue/vim-packix', { type: 'opt' })
  endif

  # Improved incremental search
  # https://github.com/wincent/loupe
  px.Add('wincent/loupe')

  # Search across multiple files
  # https://github.com/wincent/ferret
  px.Add('wincent/ferret')

  if hz#Is('unix') && !hz#Is('mac')
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

  if executable('direnv')
    # Load .envrc for vim
    # https://github.com/direnv/direnv.vim
    px.Add('direnv/direnv.vim')
  endif

  # Pipe output into a scratch / temporary buffer
  # https://github.com/AndrewRadev/bufferize.vim
  px.Add('AndrewRadev/bufferize.vim')

  # Show the undo tree, pure vimscript
  # https://github.com/mbbill/undotree
  px.Add('mbbill/undotree')

  # Highlight and normalize unicode homoglyphs in Vim.
  # https://github.com/Konfekt/vim-unicode-homoglyphs
  px.Add('Konfekt/vim-unicode-homoglyphs')

  # Tim Pope utilities.
  # Repeat plugin maps
  # https://github.com/tpope/vim-repeat
  px.Add('tpope/vim-repeat')
  # Readline-style support
  # https://github.com/tpope/vim-rsi
  px.Add('tpope/vim-rsi')
  # Change surrounds easily
  # https://github.com/tpope/vim-surround
  # px.Add('tpope/vim-surround')
  # My port. There are definitely bugs, especially around visual use.
  # px.Local('~/oss/vim/vim-surround')
  # Alternative: https://github.com/machakann/vim-sandwich
  px.Add('machakann/vim-sandwich')

  # Paired mappings
  # # https://github.com/tpope/vim-unimpaired
  # px.Add('tpope/vim-unimpaired', { type: 'opt' })
  if isdirectory(expand('~/oss/vim/vim-pairs'))
    px.Local('~/oss/vim/vim-pairs')
  else
    px.Add('halostatue/vim-pairs')
  endif
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

  # Pro vim session handling
  # https://github.com/dhruvasagar/vim-prosession
  px.Add('dhruvasagar/vim-prosession',
    { type: 'opt', requires: [
      # Continuously updated session files
      # https://github.com/tpope/vim-obsession
      { url: 'tpope/vim-obsession', opts: { type: 'opt' } }
    ] }
  )

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

  # Granular project configuration with "projections"
  # https://github.com/tpope/vim-projectionist
  px.Add('tpope/vim-projectionist')
  # Rails support
  # https://github.com/tpope/vim-rails
  px.Add('tpope/vim-rails', { type: 'opt', on: ['Rails', 'Generate', 'Runner'] })
  # Rake support
  # https://github.com/tpope/vim-rake
  px.Add('tpope/vim-rake', { type: 'opt', on: 'Rake' })
  # Bundler support
  # https://github.com/tpope/vim-bundler
  px.Add('tpope/vim-bundler', { type: 'opt', on: 'Bundle' })

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
  # # https://github.com/srstevenson/vim-picker
  # px.Add('srstevenson/vim-picker')
  # https://github.com/girishji/scope.vim # REVISIT
  # px.Add('girishji/scope.vim')
  # https://github.com/Donaldttt/fuzzyy
  px.Add('Donaldttt/fuzzyy')

  # Git so awesome, it should be illegal
  # https://github.com/tpope/vim-fugitive
  px.Add('tpope/vim-fugitive')
  # Fugitive-based Git branch viewer
  # https://github.com/rbong/vim-flog
  px.Add('rbong/vim-flog', {
    type: 'opt',
    on: ['Flog', 'Flogsplit', 'Floggit'],
    requires: 'tpope/vim-fugitive' })

  # # https://github.com/Eliot00/git-lens.vim
  # px.Add('Eliot00/git-lens.vim')

  # https://github.com/rizzatti/dash.vim
  px.Add('rizzatti/dash.vim')

  # https://github.com/girishji/devdocs.vim
  px.Add('girishji/devdocs.vim')

  # Sign column support for almost any VCS
  # https://github.com/mhinz/vim-signify
  px.Add('mhinz/vim-signify')

  # Launch screen
  # https://github.com/mhinz/vim-startify
  px.Add('mhinz/vim-startify')

  # Ansible
  # https://github.com/pearofducks/ansible-vim
  px.Add('pearofducks/ansible-vim')
  # Brewfile
  # https://github.com/bfontaine/Brewfile.vim
  px.Add('bfontaine/Brewfile.vim')
  # Browserslist constraints
  # https://github.com/browserslist/vim-browserslist
  px.Add('browserslist/vim-browserslist')
  # CSV
  # https://github.com/chrisbra/csv.vim
  px.Add('chrisbra/csv.vim')
  # Elixir
  # https://github.com/elixir-editors/vim-elixir
  # https://github.com/sodapopcan/vim-mixer
  px.Add('elixir-editors/vim-elixir', { requires: 'sodapopcan/vim-mixer' })
  # Erlang
  # https://github.com/vim-erlang/vim-erlang-runtime
  px.Add('vim-erlang/vim-erlang-runtime')
  # Fish shell
  # https://github.com/blankname/vim-fish
  px.Add('blankname/vim-fish')
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
  # HTML
  # https://github.com/othree/html5.vim
  px.Add('othree/html5.vim')
  # Janet lang
  # https://github.com/janet-lang/janet.vim
  px.Add('janet-lang/janet.vim')
  # Julia
  # https://github.com/JuliaEditorSupport/julia-vim
  px.Add('JuliaEditorSupport/julia-vim')
  # Just
  # https://github.com/NoahTheDuke/vim-just
  px.Add('NoahTheDuke/vim-just')
  # Log highlighting (generic)
  # https://github.com/MTDL9/vim-log-highlighting
  px.Add('MTDL9/vim-log-highlighting')
  # Markdown
  # https://github.com/tpope/vim-markdown
  px.Add('tpope/vim-markdown')
  # MJML
  # https://github.com/amadeus/vim-mjml
  px.Add('amadeus/vim-mjml')
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
  # Terraform
  # https://github.com/hashivim/vim-terraform
  px.Add('hashivim/vim-terraform')
  # Toml
  # https://github.com/cespare/vim-toml
  px.Add('cespare/vim-toml')
  # Typescript
  # https://github.com/HerringtonDarkholme/yats.vim
  px.Add('HerringtonDarkholme/yats.vim')
  # Vue
  # https://github.com/posva/vim-vue
  px.Add('posva/vim-vue')

  ## Disabled Syntax support
  # # AppleScript
  # # https://github.com/mityu/vim-applescript
  # px.Add('mityu/vim-applescript')
  # # C/C++ (Modern)
  # # https://github.com/bfrg/vim-cpp-modern
  # px.Add('bfrg/vim-cpp-modern')
  # # Crystal
  # # https://github.com/vim-crystal/vim-crystal
  # px.Add('vim-crystal/vim-crystal')
  # # Cucumber
  # # https://github.com/tpope/vim-cucumber
  # px.Add('tpope/vim-cucumber')
  # # Dart
  # # https://github.com/dart-lang/dart-vim-plugin
  # px.Add('dart-lang/dart-vim-plugin')
  # # Dhall
  # # https://github.com/vmchale/dhall-vim
  # px.Add('vmchale/dhall-vim')
  # # D
  # # https://github.com/JesseKPhillips/d.vim
  # px.Add('JesseKPhillips/d.vim')
  # # Elvish shell
  # # https://github.com/dmix/elvish.vim
  # px.Add('dmix/elvish.vim')
  # # Fennel (Lua Lisp)
  # # https://github.com/bakpakin/fennel.vim
  # px.Add('bakpakin/fennel.vim')
  # # Haskell
  # # https://github.com/neovimhaskell/haskell-vim
  # px.Add('neovimhaskell/haskell-vim')
  # # Haxe
  # # https://github.com/jdonaldson/vaxe
  # px.Add('jdonaldson/vaxe')
  # # icalendar
  # # https://github.com/chutzpah/icalendar.vim
  # px.Add('chutzpah/icalendar.vim')
  # # Idris2
  # # https://github.com/edwinb/idris2-vim
  # px.Add('edwinb/idris2-vim')
  # # Jsonnet
  # # https://github.com/google/vim-jsonnet
  # px.Add('google/vim-jsonnet')
  # # JSX, which can never be pretty
  # # https://github.com/MaxMEllon/vim-jsx-pretty
  # px.Add('MaxMEllon/vim-jsx-pretty')
  # # Nim
  # # https://github.com/zah/nim.vim
  # px.Add('zah/nim.vim')
  # # Nix
  # # https://github.com/LnL7/vim-nix
  # px.Add('LnL7/vim-nix')
  # # OCaml
  # # https://github.com/ocaml/vim-ocaml
  # px.Add('ocaml/vim-ocaml')
  # # Swift
  # # https://github.com/keith/swift.vim
  # px.Add('keith/swift.vim')

  # Colour highlighter
  # https://github.com/ap/vim-css-color
  px.Add('ap/vim-css-color')

  # Autoformat
  # https://github.com/sbdchd/neoformat
  px.Add('sbdchd/neoformat')

  # Colorschemes
  # https://github.com/tyrannicaltoucan/vim-quantum
  px.Add('tyrannicaltoucan/vim-quantum')
  # https://github.com/cocopon/iceberg.vim
  px.Add('cocopon/iceberg.vim')
  # https://github.com/habamax/vim-alchemist
  px.Add('habamax/vim-alchemist')
  # https://github.com/habamax/vim-habanight
  px.Add('habamax/vim-habanight')
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
  # https://github.com/sjl/badwolf
  px.Add('sjl/badwolf')
  # https://github.com/fenetikm/falcon
  px.Add('fenetikm/falcon')
  # https://github.com/dreyks/ir_black
  px.Add('dreyks/ir_black')
  # https://github.com/vim-scripts/mayansmoke
  px.Add('vim-scripts/mayansmoke')
  # https://github.com/lunacookies/vim-mayanfog
  px.Add('lunacookies/vim-mayanfog')

  # Autoclose paired markers (parens, etc.)
  # https://github.com/LunarWatcher/auto-pairs
  px.Add('LunarWatcher/auto-pairs')

  # LSP, Autocomplete, & Snippets
  # With Vim, LSP clients and autocomplete plugins tend to be relatively tightly tied
  # together.

  # tied to vim-lsp, not yegappan/lsp
  # https://github.com/basyura/vim-lsp-popup-diagnostics

  # https://github.com/neoclide/coc.nvim
  # This requires substantial work to use. See `coc.vim`. See also
  # https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
  # https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
  # https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
  # https://github.com/neoclide/coc.nvim/wiki/Language-servers
  # https://github.com/neoclide/coc.nvim/wiki/F.A.Q
  # https://github.com/neoclide/coc.nvim/wiki/Multiple-cursors-support
  # https://github.com/neoclide/coc.nvim/wiki/Statusline-integration
  # https://github.com/neoclide/coc.nvim/wiki/Using-coc-list
  # https://github.com/neoclide/coc.nvim/wiki/Using-snippets
  # https://github.com/neoclide/coc.nvim/wiki/Using-workspaceFolders
  #
  # px.Add('neoclide/coc.nvim', { branch: 'release' })

  # https://github.com/dense-analysis/ale
  # https://github.com/dense-analysis/ale/blob/master/supported-tools.md
  #
  # px.Add('dense-analysis/ale')

  if g:->get('hz_lsp_client', 'yegappan/lsp') == 'yegappan/lsp'
    # https://github.com/yegappan/lsp
    px.Add('yegappan/lsp', { requires: [
      # https://github.com/halostatue/vim-lsp-settings
      { url: 'halostatue/vim-lsp-settings',
        opts: { branch: 'add-standard-ruby-lsp-mode' } },
      # https://github.com/normen/vim-lsp-settings-adapter
      'normen/vim-lsp-settings-adapter',
      # https://github.com/girishji/vimcomplete
      'girishji/vimcomplete',
      # https://github.com/hrsh7th/vim-vsnip
      'hrsh7th/vim-vsnip',
      # https://github.com/hrsh7th/vim-vsnip-integ
      'hrsh7th/vim-vsnip-integ',
      # https://github.com/rafamadriz/friendly-snippets
      'rafamadriz/friendly-snippets',
    ] })
  else
    # https://github.com/prabirshrestha/vim-lsp
    px.Add('prabirshrestha/vim-lsp', { requires: [
      # https://github.com/halostatue/vim-lsp-settings
      { url: 'halostatue/vim-lsp-settings',
        opts: { branch: 'add-standard-ruby-lsp-mode' } },
      # https://github.com/prabirshrestha/asyncomplete.vim
      'prabirshrestha/asyncomplete.vim',
      # https://github.com/prabirshrestha/asyncomplete-lsp.vim
      'prabirshrestha/asyncomplete-lsp.vim',
      # https://github.com/prabirshrestha/asyncomplete-file.vim
      'prabirshrestha/asyncomplete-file.vim',
      # https://github.com/tsuyoshicho/asyncomplete-anylist
      'tsuyoshicho/asyncomplete-anylist',
    ] })
  endif

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

  # Add distraction-free writing tools
  # https://github.com/junegunn/goyo.vim
  px.Add('junegunn/goyo.vim', { type: 'opt' })

  # Add more targets
  # https://github.com/wellle/targets.vim
  px.Add('wellle/targets.vim')

  # Extended fFtT behaviours
  # https://github.com/rhysd/clever-f.vim
  px.Add('rhysd/clever-f.vim')

  # Aid with git merge / rebase conflict resolution
  # https://github.com/christoomey/vim-conflicted
  px.Add('christoomey/vim-conflicted')

  # https://github.com/errael/splice9
  if v:versionlong >= 9010369 # Vim 9.1 patch 369
    px.Add('errael/splice9', { requires: ['errael/vim-lib-raelity'] })
  endif

  # https://github.com/zeminzhou/diffview.vim
  px.Add('zeminzhou/diffview.vim')

  # Highlight conflict markers
  # https://github.com/rhysd/conflict-marker.vim
  px.Add('rhysd/conflict-marker.vim')

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
  px.Add('mattn/gist-vim', { type: 'opt', on: 'Gist', requires: 'mattn/webapi-vim' })

  # # https://github.com/liuchengxu/eleline.vim
  # px.Add('liuchengxu/eleline.vim')

  # https://github.com/rbong/vim-crystalline
  # https://github.com/vim-airline/vim-airline/
  # https://github.com/itchyny/lightline.vim/
  # https://github.com/tpope/vim-flagship

  # Most Recently (used, written, repositories)
  # Used with asyncomplete-anylist
  # https://lambdalisue/vim-mr
  px.Add('lambdalisue/vim-mr')

  # Development utility to bundle useful modules
  # https://github.com/vim-jp/vital.vim
  px.Add('vim-jp/vital.vim', { type: 'opt', on: 'Vitalize' })
  # Vim Script Ease
  # https://github.com/tpope/vim-scriptease
  px.Add('tpope/vim-scriptease',
    { type: 'opt', on: [
      'Breakadd', 'Breakdel', 'Disarm', 'Messages', 'PP', 'Runtime', 'Scriptnames',
      'Time', 'Verbose'
    ] }
  )
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
  # Adds editable pop-ups by hacking Vim's terminal popup window
  # https://github.com/Bakudankun/popupe.vim
  px.Add('Bakudankun/popupe.vim')

  # https://github.com/alker0/chezmoi.vim
  px.Add('alker0/chezmoi.vim', { type: 'opt' })

  # https://github.com/girishji/vimbits
  # We use configuration to disable parts of this.
  px.Add('girishji/vimbits')

  # https://github.com/rhysd/vim-healthcheck
  # px.Add('rhysd/vim-healthcheck')
  if isdirectory(expand('~/oss/vim/vim-healthcheck'))
    px.Local('~/oss/vim/vim-healthcheck')
  else
    px.Add('halostatue/vim-healthcheck')
  endif

  # Currently imaps C-l and C-f without checking over overrides
  # https://github.com/greeschenko/vim9-ollama
  # px.Add('greeschenko/vim9-ollama')

  # Buffer History
  # https://github.com/dhruvasagar/vim-buffer-history
  px.Add('dhruvasagar/vim-buffer-history')

  # Exchange two {motion}s
  # https://github.com/tommcdo/vim-exchange
  px.Add('tommcdo/vim-exchange')

  # Vim Text Objects
  # https://github.com/kana/vim-textobj-user
  px.Add('kana/vim-textobj-user', {
    requires: [
      'glts/vim-textobj-comment', # https://github.com/glts/vim-textobj-comment
      'kana/vim-textobj-datetime', # https://github.com/kana/vim-textobj-datetime
      'kana/vim-textobj-line', # https://github.com/kana/vim-textobj-line
      'jceb/vim-textobj-uri', # https://github.com/jceb/vim-textobj-uri
  ] })

  if executable('dict')
    # Look up a word with the dictionary protocol
    # https://github.com/wolandark/vimdict (requires `dict` command)
    px.Add('wolandark/vimdict')
  endif

  # https://github.com/lifepillar/vim-colortemplate
  px.Add('lifepillar/vim-colortemplate', { type: 'opt', branch: 'v3',
      requires: [ 'lifepillar/vim-devel' ] })
  # Completion for command mode
  # https://github.com/mityu/vim-cmdhistory
  px.Add('mityu/vim-cmdhistory')

  # Check what is causing slow vim startup time
  # https://github.com/dstein64/vim-startuptime
  px.Add('dstein64/vim-startuptime')

  # Switch between single-line and multi-line code forms
  # https://github.com/AndrewRadev/splitjoin.vim
  px.Add('AndrewRadev/splitjoin.vim')

  # https://github.com/jessepav/vim-boxdraw
  # https://github.com/reedes/vim-pencil
  # https://github.com/reedes/vim-lexical
  # opt - https://github.com/junegunn/goyo.vim
  # opt - https://github.com/junegunn/limelight.vim
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
  # opt - https://github.com/mbbill/undotree
  #
  # Loaded only for specific filetypes on demand.
  # Requires autocommands below.
  # opt - for go - https://github.com/fatih/vim-go
  #
  # https://github.com/farmergreg/vim-lastplace
  # https://github.com/chaoren/vim-wordmotion
  # https://github.com/suy/vim-context-commentstring
  #
  # https://github.com/thinca/vim-quickrun
  # https://github.com/liuchengxu/vim-which-key
  # https://github.com/girishji/bufline.vim
  # https://github.com/girishji/vimsuggest
  # https://github.com/girishji/devdocs.vim
})
