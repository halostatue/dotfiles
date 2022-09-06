scriptencoding utf-8

runtime config/packages/before.vim

function! s:packager_init() abort
  packadd vim-packager

  call packager#init()

  " `config/packages/install_packager.vim` will install this automatically, adding it here
  " makes it self-managing: https://github.com/kristijanhusak/vim-packager
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

  " Improved incremental search: https://github.com/wincent/loupe
  call packager#add('wincent/loupe')

  " Cross-File Search:
  " https://github.com/dyng/ctrlsf.vim
  call packager#add('dyng/ctrlsf.vim')
  " https://github.com/yegappan/grep
  call packager#add('yegappan/grep')

  " Edit files as `file.txt:24:15` and move to the correct spot:
  " https://github.com/wsdjeg/vim-fetch
  call packager#add('wsdjeg/vim-fetch')

  " `mkdir -p` for file creation: https://github.com/duggiefresh/vim-easydir
  call packager#add('duggiefresh/vim-easydir')

  " Improved matchit: https://github.com/andymass/vim-matchup
  call packager#add('andymass/vim-matchup')

  " Load .envrc for vim: https://github.com/direnv/direnv.vim
  call packager#add('direnv/direnv.vim')

  " Load editor configuration for vim: https://github.com/editorconfig/vim-editorconfig
  call packager#add('editorconfig/editorconfig-vim')

  " Pipe output into a scratch / temporary buffer:
  " https://github.com/AndrewRadev/bufferize.vim
  call packager#add('AndrewRadev/bufferize.vim')

  " Show the undo tree, pure vimscript. (vim-mundo requires Python.)
  " https://github.com/mbbill/undotree
  call packager#add('mbbill/undotree')

  " Database queries in vim.
  " https://github.com/tpope/vim-dadbod
  call packager#add('tpope/vim-dadbod')
  " https://github.com/kristijanhusak/vim-dadbod-completion
  call packager#add('kristijanhusak/vim-dadbod-completion')
  " https://github.com/kristijanhusak/vim-dadbod-ui
  call packager#add('kristijanhusak/vim-dadbod-ui')

  " Tim Pope utilities.
  " Repeat plugin maps: https://github.com/tpope/vim-repeat
  call packager#add('tpope/vim-repeat')
  " Readline-style support: https://github.com/tpope/vim-rsi
  call packager#add('tpope/vim-rsi')
  " Change surrounds easily: https://github.com/tpope/vim-surround
  call packager#add('tpope/vim-surround')
  " Paired mappings: https://github.com/tpope/vim-unimpaired
  call packager#add('tpope/vim-unimpaired')
  " Abbreviation, Subversion, and Coercion: https://github.com/tpope/vim-abolish
  call packager#add('tpope/vim-abolish')
  " Improved C-A / C-X, especially on dates: https://github.com/tpope/vim-speeddating
  call packager#add('tpope/vim-speeddating')
  " Project configuration with projections: https://github.com/tpope/vim-projectionist
  call packager#add('tpope/vim-projectionist')
  " Unix command sugar: https://github.com/tpope/vim-eunuch
  call packager#add('tpope/vim-eunuch')
  " Asynchronous compiler support: https://github.com/tpope/vim-dispatch
  call packager#add('tpope/vim-dispatch')
  " Comment management: https://github.com/tpope/vim-commentary
  call packager#add('tpope/vim-commentary')
  " End certain structures automatically: https://github.com/tpope/vim-endwise
  call packager#add('tpope/vim-endwise')
  " Better HTML/template tag mapping: https://github.com/tpope/vim-ragtag
  call packager#add('tpope/vim-ragtag')

  " Session Management
  " Handle Vim sessions like a pro: https://github.com/dhruvasagar/vim-prosession
  " Continuously updated session files: https://github.com/tpope/vim-obsession
  call packager#add('dhruvasagar/vim-prosession', {
        \   'type': 'opt',
        \   'requires': [['tpope/vim-obsession', { 'type': 'opt' }]]
        \ })

  " Preview the contents of registers: https://github.com/junegunn/vim-peekaboo
  call packager#add('junegunn/vim-peekaboo')

  " Only obey some modeline settings: https://github.com/alexghergh/securemodelines
  call packager#add('alexghergh/securemodelines')

  " Makes `gx` do the right thing with URLs: https://github.com/tyru/open-browser.vim
  call packager#add('tyru/open-browser.vim')

  " Sort lines with a motion: https://github.com/christoomey/vim-sort-motion
  call packager#add('christoomey/vim-sort-motion')

  " Change PWD to a project root. https://github.com/airblade/vim-rooter
  call packager#add('airblade/vim-rooter')

  " Add `emoji#for` function: https://github.com/junegunn/vim-emoji
  call packager#add('junegunn/vim-emoji')

  " Add fzf support: https://github.com/junegunn/fzf
  call packager#add('junegunn/fzf')

  " Safely load local `.vimrc` and/or `.vimrc.lua` files:
  " https://github.com/jenterkin/vim-autosource
  call packager#add('jenterkin/vim-autosource')

  " Fern is a file tree / explorer: https://github.com/lambdalisue/fern.vim
  call packager#add('lambdalisue/fern.vim')
  " Shows git status in the fern tree: https://github.com/lambdalisue/fern-git-status.vim
  call packager#add('lambdalisue/fern-git-status.vim')
  " Hijacks directory edits with fern: https://github.com/lambdalisue/fern-hijack.vim
  call packager#add('lambdalisue/fern-hijack.vim')
  " Collapse a folder or leave it:
  " https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim
  call packager#add('hrsh7th/fern-mapping-collapse-or-leave.vim')
  " Integrate fzf: https://github.com/LumaKernel/fern-mapping-fzf.vim
  call packager#add('LumaKernel/fern-mapping-fzf.vim')
  " Add bookmarks to fern: https://github.com/lambdalisue/fern-bookmark.vim
  call packager#add('lambdalisue/fern-bookmark.vim')
  " Git stage << / unstage >>: https://github.com/lambdalisue/fern-mapping-git.vim
  call packager#add('lambdalisue/fern-mapping-git.vim')
  " Mark children: https://github.com/lambdalisue/fern-mapping-mark-children.vim
  call packager#add('lambdalisue/fern-mapping-mark-children.vim')
  " Jump to the project top: https://github.com/lambdalisue/fern-mapping-project-top.vim
  call packager#add('lambdalisue/fern-mapping-project-top.vim')
  " Send selections to quickfix: https://github.com/lambdalisue/fern-mapping-quickfix.vim
  call packager#add('lambdalisue/fern-mapping-quickfix.vim')
  " Floating file preview for Fern: https://github.com/yuki-yano/fern-preview.vim
  call packager#add('yuki-yano/fern-preview.vim')

  " File Picker:
  " USING THIS: https://github.com/srstevenson/vim-picker
  call packager#add('srstevenson/vim-picker')
  " TRY THIS: https://github.com/liuchengxu/vim-clap
  call packager#add('liuchengxu/vim-clap', { 'do': ':Clap install-binary!' })

  " Git so awesome, it should be illegal: https://github.com/tpope/vim-fugitive
  call packager#add('tpope/vim-fugitive')
  " Hub to the Git: https://github.com/tpope/vim-rhubarb
  call packager#add('tpope/vim-rhubarb')
  " Git commit browser: https://github.com/junegunn/gv.vim
  call packager#add('junegunn/gv.vim')
  " Shows git commit messages for the current line: https://github.com/rhysd/git-messenger.vim
  call packager#add('rhysd/git-messenger.vim')

  " Sign column support for almost any VCS: https://github.com/mhinz/vim-signify
  call packager#add('mhinz/vim-signify')

  " Launch screen: https://github.com/mhinz/vim-startify
  call packager#add('mhinz/vim-startify')

  " Polyglot: https://github.com/sheerun/vim-polyglot
  " Provides syntax and indentation for the following syntaxes I
  " care about: ansible, applescript, C/C++, Crystal, CSV, Cucumber/Gherkin,
  " Dart, D, Dockerfile / Docker-Compose, Elixir, Elm, Erlang, Fish, Git,
  " Gleam, GraphQL, HTML, JavaScript, jq, JSON, Julia, Kotlin, Lua, Markdown,
  " Nim, Objective-C, Perl, PLpgSQL, PlantUML, Pony, Python, Raku, RAML,
  " Reason, Ruby, Rust, SCSS, Shell, Svelte, SVG, Swift, Terraform, TOML,
  " Vue, XML, and Zig.
  call packager#add('sheerun/vim-polyglot')
  " MJML: https://github.com/amadeus/vim-mjml
  call packager#add('amadeus/vim-mjml')
  " Elvish shell: https://github.com/dmix/elvish.vim
  call packager#add('dmix/elvish.vim')
  " Go: https://github.com/fatih/vim-go
  call packager#add('fatih/vim-go', { 'do': ':GoInstallBinaries', 'type': 'opt' })
  " Browserslist constraints: https://github.com/browserslist/vim-browserslist
  call packager#add('browserslist/vim-browserslist')
  " Janet lang: https://github.com/janet-lang/janet.vim
  call packager#add('janet-lang/janet.vim')
  " Svelte 3: https://github.com/evanleck/vim-svelte
  call packager#add('evanleck/vim-svelte')
  " Ruby Signature: https://github.com/jlcrochet/vim-rbs
  call packager#add('jlcrochet/vim-rbs')
  " Cue language: https://github.com/hofstadter-io/cue.vim
  call packager#add('hofstadter-io/cue.vim')

  " Colour highlighter: https://github.com/ap/vim-css-color
  call packager#add('ap/vim-css-color')

  " Autoformat: https://github.com/sbdchd/neoformat
  call packager#add('sbdchd/neoformat')
  " Autoset path searching: https://github.com/tpope/vim-apathy
  call packager#add('tpope/vim-apathy')
  " Rails support: https://github.com/tpope/vim-rails
  call packager#add('tpope/vim-rails', { 'type': 'opt' })
  " Rake support: https://github.com/tpope/vim-rake
  call packager#add('tpope/vim-rake', { 'type': 'opt' })
  " Bundler support: https://github.com/tpope/vim-bundler
  call packager#add('tpope/vim-bundler', { 'type': 'opt' })
  " Automatically insert continuation bacskslashes for vim files:
  " https://github.com/lambdalisue/vim-backslash
  call packager#add('lambdalisue/vim-backslash')

  " Colorschemes
  " https://github.com/tyrannicaltoucan/vim-quantum
  call packager#add('tyrannicaltoucan/vim-quantum')
  " https://github.com/cocopon/iceberg.vim
  call packager#add('cocopon/iceberg.vim')
  " https://github.com/habamax/vim-alchemist
  call packager#add('habamax/vim-alchemist')
  " https://github.com/ajh17/spacegray.vim
  call packager#add('ajh17/spacegray.vim')

  " Display completion function signatures in the command-line:
  " https://github.com/Shougo/echodoc.vim
  call packager#add('Shougo/echodoc.vim')

  " Autoclose parentheses: https://github.com/mattn/vim-lexiv
  call packager#add('mattn/vim-lexiv')

  " LSP Options
  " " https://github.com/dense-analysis/ale
  " call packager#add('dense-analysis/ale')
  " https://github.com/neoclide/coc.nvim
  call packager#add('neoclide/coc.nvim', { 'branch': 'release' })
  " https://github.com/autozimu/LanguageClient-neovim
  " call packager#add('autozimu/LanguageClient-neovim')
  " https://github.com/natebosch/vim-lsc
  " call packager#add('natebosch/vim-lsc')
  " https://github.com/prabirshrestha/vim-lsp
  " call packager#add('prabirshrestha/vim-lsp')
  " https://github.com/rhysd/vim-lsp-ale

  " https://github.com/vn-ki/coc-clap
  call packager#add('vn-ki/coc-clap')

  " LSP and tag view display: https://github.com/liuchengxu/vista.vim
  call packager#add('liuchengxu/vista.vim')

  " Close HTML tags: https://github.com/alvan/vim-closetag
  call packager#add('alvan/vim-closetag')

  " Tag rename in pairs: https://github.com/AndrewRadev/tagalong.vim
  call packager#add('AndrewRadev/tagalong.vim')

  " Manage tag files automatically: https://github.com/ludovicchabant/vim-gutentags
  call packager#add('ludovicchabant/vim-gutentags')

  " Jump to definitions: https://github.com/pechorin/any-jump.vim
  call packager#add('pechorin/any-jump.vim')

  " Generate a TOC for Markdown: https://github.com/mzlogin/vim-markdown-toc
  call packager#add('mzlogin/vim-markdown-toc')

  " Add more targets: https://github.com/wellle/targets.vim
  call packager#add('wellle/targets.vim')

  " Extended fFtT behaviours: https://github.com/rhysd/clever-f.vim
  call packager#add('rhysd/clever-f.vim')

  " Aid with git merge / rebase conflict resolution: https://github.com/christoomey/vim-conflicted
  call packager#add('christoomey/vim-conflicted')

  " Highlight conflict markers: https://github.com/rhysd/conflict-marker.vim
  call packager#add('rhysd/conflict-marker.vim')

  " Asynchronous execution to quickfix: https://github.com/hauleth/asyncdo.vim
  call packager#add('hauleth/asyncdo.vim')
  " Tame quickfix: https://github.com/romainl/vim-qf
  call packager#add('romainl/vim-qf')
  " Make enhancements (configured like projectionist): https://github.com/igemnace/vim-makery
  call packager#add('igemnace/vim-makery')

  " Choose a window by letter: https://github.com/t9md/vim-choosewin
  call packager#add('t9md/vim-choosewin')
  " Zoom windows: https://github.com/dhruvasagar/vim-zoom
  call packager#add('dhruvasagar/vim-zoom')

  " Multi-language Debugger: https://github.com/puremourning/vimspector
  call packager#add('puremourning/vimspector')

  " Multi-language Test Runner: https://github.com/vim-test/vim-test
  call packager#add('vim-test/vim-test')

  " Gist commands: https://github.com/mattn/gist-vim
  call packager#add('mattn/gist-vim', { 'type': 'opt' })

  " Loaded only for specific filetypes on demand. Requires autocommands below.
  " https://github.com/kristijanhusak/vim-js-file-import
  call packager#add('kristijanhusak/vim-js-file-import', { 'do': 'npm install' })

  " Terminal reuse: https://github.com/kassio/neoterm
  call packager#add('kassio/neoterm')
  " Floating terminal: https://github.com/voldikss/vim-floaterm
  call packager#add('voldikss/vim-floaterm')

  " https://github.com/liuchengxu/eleline.vim
  call packager#add('liuchengxu/eleline.vim')
  " https://github.com/rbong/vim-crystalline
  " https://github.com/vim-airline/vim-airline/
  " https://github.com/itchyny/lightline.vim/
  " https://github.com/tpope/vim-flagship

  " Development utility to bundle useful modules: https://github.com/vim-jp/vital.vim
  call packager#add('vim-jp/vital.vim', { 'type': 'opt' })
  " VimL lint: https://github.com/Vimjas/vint
  call packager#add('Vimjas/vint', { 'type': 'opt' })
  " Vimscript Test: https://github.com/junegunn/vader.vim
  call packager#add('junegunn/vader.vim', { 'type': 'opt' })
  " Vimscript Test: https://github.com/thinca/vim-themis
  call packager#add('thinca/vim-themis', { 'type': 'opt' })

  " https://github.com/alker0/chezmoi.vim
  call packager#add('alker0/chezmoi.vim', { 'type': 'opt' })
endfunction

command! -nargs=* -bar PackagerRefresh call s:packager_init() | call packager#install(<args>)
command! -nargs=* -bar PackagerInstall call s:packager_init() | call packager#install(<args>)
command! -nargs=* -bar PackagerUpdate call s:packager_init() | call packager#update(<args>)
command! -bar PackagerClean call s:packager_init() | call packager#clean()
command! -bar PackagerStatus call s:packager_init() | call packager#status()
