scriptencoding utf-8

runtime config/packages/before.vim

function! s:packager_init() abort
  packadd vim-packager

  call packager#init()

  " Package manager {{{
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' }) " https://github.com/kristijanhusak/vim-packager
  " }}}

  " Search {{{
  call packager#add('haya14busa/is.vim') " https://github.com/haya14busa/is.vim
  call packager#add('haya14busa/vim-asterisk') " https://github.com/haya14busa/vim-asterisk
  call packager#add('osyo-manga/vim-anzu') " https://github.com/osyo-manga/vim-anzu
  call packager#add('RRethy/vim-illuminate') " https://github.com/RRethy/vim-illuminate
  call packager#add('dyng/ctrlsf.vim') " https://github.com/dyng/ctrlsf.vim
  call packager#add('mhinz/vim-grepper') " https://github.com/mhinz/vim-grepper
  " }}}

  " Utils {{{
  call packager#add('chrisbra/unicode.vim') " https://github.com/chrisbra/unicode.vim
  call packager#add('wsdjeg/vim-fetch') " https://github.com/wsdjeg/vim-fetch
  call packager#add('duggiefresh/vim-easydir') " https://github.com/duggiefresh/vim-easydir
  call packager#add('prabirshrestha/async.vim') " https://github.com/prabirshrestha/async.vim
  call packager#add('andymass/vim-matchup') " https://github.com/andymass/vim-matchup
  call packager#add('direnv/direnv.vim') " https://github.com/direnv/direnv.vim
  call packager#add('hauleth/vim-backscratch') " https://github.com/hauleth/vim-backscratch
  call packager#add('https://gitlab.com/hauleth/qfx.vim.git') " https://gitlab.com/hauleth/qfx.vim.git
  call packager#add('editorconfig/editorconfig-vim') " https://github.com/editorconfig/vim-editorconfig
  call packager#add('simnalamburt/vim-mundo') " https://github.com/simnalamburt/vim-mundo
  call packager#add('tpope/vim-dadbod') " https://github.com/tpope/vim-dadbod
  call packager#add('kristijanhusak/vim-dadbod-completion') " https://github.com/kristijanhusak/vim-dadbod-completion
  call packager#add('kristijanhusak/vim-dadbod-ui') " https://github.com/kristijanhusak/vim-dadbod-ui
  call packager#add('tpope/vim-repeat') " https://github.com/tpope/vim-repeat
  call packager#add('tpope/vim-rsi') " https://github.com/tpope/vim-rsi
  call packager#add('tpope/vim-surround') " https://github.com/tpope/vim-surround
  call packager#add('tpope/vim-unimpaired') " https://github.com/tpope/vim-unimpaired
  call packager#add('tpope/vim-haystack') " https://github.com/tpope/vim-haystack
  call packager#add('tpope/vim-abolish') " https://github.com/tpope/vim-abolish
  call packager#add('tpope/vim-capslock') " https://github.com/tpope/vim-capslock
  call packager#add('tpope/vim-speeddating') " https://github.com/tpope/vim-speeddating
  call packager#add('junegunn/vim-peekaboo') " https://github.com/junegunn/vim-peekaboo
  call packager#add('alexghergh/securemodelines') " https://github.com/alexghergh/securemodelines
  call packager#add('tyru/open-browser.vim') " https://github.com/tyru/open-browser.vim
  call packager#add('christoomey/vim-sort-motion') " https://github.com/christoomey/vim-sort-motion
  call packager#add('airblade/vim-rooter') " https://github.com/airblade/vim-rooter
  call packager#add('AndrewRadev/bufferize.vim') " https://github.com/AndrewRadev/bufferize.vim
  call packager#add('AndrewRadev/quickpeek.vim') " https://github.com/AndrewRadev/quickpeek.vim
  call packager#add('chrisbra/Recover.vim') " https://github.com/chrisbra/Recover.vim
  call packager#add('junegunn/vim-emoji') " https://github.com/junegunn/vim-emoji
  call packager#add('thinca/vim-localrc') " https://github.com/thinca/vim-localrc
  if !has('nvim')
    call packager#add('rhysd/vim-healthcheck', { 'type': 'opt' }) " https://github.com/rhysd/vim-healthcheck
  endif
  call packager#add('vim-jp/vital.vim', { 'type': 'opt' }) " https://github.com/vim-jp/vital.vim
  " }}}

  " Project navigation {{{
  call packager#add('tpope/vim-projectionist') " https://github.com/tpope/vim-projectionist
  call packager#add('tpope/vim-eunuch') " https://github.com/tpope/vim-eunuch

  " Fern: NERDtree Replacement {{{
  call packager#add('lambdalisue/fern.vim') " https://github.com/lambdalisue/fern.vim
  if has('nvim')
    call packager#add('antoinemadec/FixCursorHold.nvim') " https://github.com/antoinemadec/FixCursorHold.nvim
  endif
  call packager#add('lambdalisue/fern-renderer-nerdfont.vim', { 'requires': [
        \ 'lambdalisue/nerdfont.vim',
        \ 'lambdalisue/glyph-palette.vim'
        \ ]}) " https://github.com/lambdalisue/fern-renderer-nerdfont.vim
  call packager#add('hrsh7th/fern-mapping-collapse-or-leave.vim') " https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim
  call packager#add('lambdalisue/fern-git-status.vim') " https://github.com/lambdalisue/fern-git-status.vim
  call packager#add('lambdalisue/fern-hijack.vim') " https://github.com/lambdalisue/fern-hijack.vim
  call packager#add('lambdalisue/fern-bookmark.vim') " https://github.com/lambdalisue/fern-bookmark.vim
  call packager#add('lambdalisue/fern-mapping-git.vim') " https://github.com/lambdalisue/fern-mapping-git.vim
  call packager#add('lambdalisue/fern-mapping-mark-children.vim') " https://github.com/lambdalisue/fern-mapping-mark-children.vim
  call packager#add('lambdalisue/fern-mapping-project-top.vim') " https://github.com/lambdalisue/fern-mapping-project-top.vim
  call packager#add('lambdalisue/fern-mapping-quickfix.vim') " https://github.com/lambdalisue/fern-mapping-quickfix.vim
  call packager#add('yuki-yano/fern-preview.vim') " https://github.com/yuki-yano/fern-preview.vim
  " }}}

  " File Picker: CtrlP, CommandT, what? {{{
  call packager#add('srstevenson/vim-picker') " https://github.com/srstevenson/vim-picker
  call packager#add('liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }) " https://github.com/liuchengxu/vim-clap
  " }}}
  " }}}

  " Git {{{
  call packager#add('tpope/vim-fugitive') " https://github.com/tpope/vim-fugitive
  call packager#add('tpope/vim-rhubarb') " https://github.com/tpope/vim-rhubarb
  call packager#add('sodapopcan/vim-twiggy') " https://github.com/sodapopcan/vim-twiggy
  call packager#add('int3/vim-extradite') " https://github.com/int3/vim-extradite
  call packager#add('tommcdo/vim-fugitive-blame-ext') " https://github.com/tommcdo/vim-fugitive-blame-ext
  call packager#add('kristijanhusak/vim-create-pr') " https://github.com/kristijanhusak/vim-create-pr
  call packager#add('junegunn/gv.vim') " https://github.com/junegunn/gv.vim
  call packager#add('mhinz/vim-signify') " https://github.com/mhinz/vim-signify
  call packager#add('rhysd/git-messenger.vim') " https://github.com/rhysd/git-messenger.vim
  call packager#add('jreybert/vimagit') " https://github.com/jreybert/vimagit
  " call packager#add('jaxbot/github-issues.vim') " https://github.com/jaxbot/github-issues.vim
  " }}}

  " Launch screen {{{
  call packager#add('mhinz/vim-startify') " https://github.com/mhinz/vim-startify
  " }}}

  " Languages {{{
  " Polyglot provides syntax and indentation for the following syntaxes I
  " care about: ansible, applescript, C/C++, Crystal, CSV, Cucumber/Gherkin,
  " Dart, D, Dockerfile / Docker-Compose, Elixir, Elm, Erlang, Fish, Git,
  " Gleam, GraphQL, HTML, JavaScript, jq, JSON, Julia, Kotlin, Lua, Markdown,
  " Nim, Objective-C, Perl, PLpgSQL, PlantUML, Pony, Python, Raku, RAML,
  " Reason, Ruby, Rust, SCSS, Shell, Svelte, SVG, Swift, Terraform, TOML,
  " Vue, XML, and Zig.
  "
  " It may be recommended to add the following languages as needed for
  " additional features:
  call packager#add('sheerun/vim-polyglot') " https://github.com/sheerun/vim-polyglot
  call packager#add('amadeus/vim-mjml') " https://github.com/amadeus/vim-mjml
  call packager#add('dmix/elvish.vim') " https://github.com/dmix/elvish.vim
  call packager#add('fatih/vim-go', { 'do': ':GoInstallBinaries', 'type': 'opt' }) " https://github.com/fatih/vim-go
  call packager#add('luizribeiro/vim-cooklang') " https://github.com/luizribeiro/vim-cooklang
  call packager#add('browserslist/vim-browserslist') " https://github.com/browserslist/vim-browserslist
  call packager#add('janet-lang/janet.vim') " https://github.com/janet-lang/janet.vim
  call packager#add('evanleck/vim-svelte') " https://github.com/evanleck/vim-svelte
  " call packager#add('jjo/vim-cue') " https://github.com/jjo/vim-cue
  call packager#add('hofstadter-io/cue.vim') " https://github.com/hofstadter-io/cue.vim

  " Stupid SF and SFCC garbage
  call packager#add('clavery/vim-dwre') " https://github.com/clavery/vim-dwre
  call packager#add('ejholmes/vim-forcedotcom') " https://github.com/ejholmes/vim-forcedotcom

  " if has('nvim-0.5')
  "   call packager#add('nvim-treesitter/nvim-treesitter') " https://github.com/nvim-treesitter/nvim-treesitter
  " end

  " call packager#add('gko/vim-coloresque') " https://github.com/gko/vim-coloresque
  call packager#add('ap/vim-css-color') " https://github.com/ap/vim-css-color

  " Language Utilities {{{
  call packager#add('sbdchd/neoformat') " https://github.com/sbdchd/neoformat
  call packager#add('tpope/vim-apathy') " https://github.com/tpope/vim-apathy
  call packager#add('junegunn/rainbow_parentheses.vim') " https://github.com/junegunn/rainbow_parentheses.vim
  call packager#add('tpope/vim-rails', { 'type': 'opt' }) " https://github.com/tpope/vim-rails
  call packager#add('tpope/vim-rake', { 'type': 'opt' }) " https://github.com/tpope/vim-rake
  call packager#add('tpope/vim-bundler', { 'type': 'opt' }) " https://github.com/tpope/vim-bundler
  call packager#add('lambdalisue/vim-backslash') " https://github.com/lambdalisue/vim-backslash
  call packager#add('eliba2/vim-node-inspect') " https://github.com/eliba2/vim-node-inspect'
  " }}}
  " }}}

  " Colorscheme {{{
  call packager#add('franbach/miramare') " https://github.com/franbach/miramare
  call packager#add('KeitaNakamura/neodark.vim') " https://github.com/KeitaNakamura/neodark.vim
  call packager#add('tyrannicaltoucan/vim-deep-space') " https://github.com/tyrannicaltoucan/vim-deep-space
  call packager#add('tyrannicaltoucan/vim-quantum') " https://github.com/tyrannicaltoucan/vim-quantum
  call packager#add('sjl/badwolf') " https://github.com/sjl/badwolf
  call packager#add('morhetz/gruvbox') " https://github.com/morhetz/gruvbox
  call packager#add('nlknguyen/papercolor-theme') " https://github.com/nlknguyen/papercolor-theme
  call packager#add('cocopon/iceberg.vim') " https://github.com/cocopon/iceberg.vim
  call packager#add('natanscalvence/Gitdark') " https://github.com/natanscalvence/Gitdark
  call packager#add('softmotions/vim-dark-frost-theme') " https://github.com/softmotions/vim-dark-frost-theme
  call packager#add('savq/melange') " https://github.com/savq/melange
  call packager#add('senran101604/neotrix.vim') " https://github.com/senran101604/neotrix.vim
  call packager#add('habamax/vim-alchemist') " https://github.com/habamax/vim-alchemist
  call packager#add('ajh17/spacegray.vim') " https://github.com/ajh17/spacegray.vim
  call packager#add('hiroakis/cyberspace.vim') " https://github.com/hiroakis/cyberspace.vim
  call packager#add('marcelbeumer/spacedust.vim') " https://github.com/marcelbeumer/spacedust.vim
  call packager#add('gavinok/spaceway.vim') " https://github.com/gavinok/spaceway.vim
  call packager#add('novasenco/nokto') " https://github.com/novasenco/nokto
  call packager#add('fenetikm/falcon') " https://github.com/fenetikm/falcon
  call packager#add('yuttie/hydrangea-vim') " https://github.com/yuttie/hydrangea-vim
  call packager#add('yggdroot/duoduo') " https://github.com/yggdroot/duoduo
  call packager#add('reedes/vim-colors-pencil') " https://github.com/reedes/vim-colors-pencil
  " }}}

  " Completion Support {{{
  call packager#add('Shougo/echodoc.vim') " https://github.com/Shougo/echodoc.vim

  " if has('nvim-0.5')
  "   call packager#add('neovim/nvim-lspconfig') " https://github.com/neovim/nvim-lspconfig
  " end

  call packager#add('prabirshrestha/vim-lsp') " https://github.com/prabirshrestha/vim-lsp
  call packager#add('mattn/vim-lsp-settings') " https://github.com/mattn/vim-lsp-settings
  call packager#add('prabirshrestha/asyncomplete.vim') " https://github.com/prabirshrestha/asyncomplete.vim
  call packager#add('prabirshrestha/asyncomplete-lsp.vim') " https://github.com/prabirshrestha/asyncomplete-lsp.vim

  call packager#add('hrsh7th/vim-vsnip-integ', {'requires': ['hrsh7th/vim-vsnip'] }) " https://github.com/hrsh7th/vim-vsnip-integ
  call packager#add('mattn/vim-lexiv') " https://github.com/mattn/vim-lexiv
  " }}}

  " Code manipulation {{{
  " call packager#add('preservim/tagbar') " https://github.com/preservim/tagbar
  call packager#add('liuchengxu/vista.vim') " https://github.com/liuchengxu/vista.vim
  call packager#add('tommcdo/vim-exchange') " https://github.com/tommcdo/vim-exchange
  call packager#add('tpope/vim-commentary') " https://github.com/tpope/vim-commentary
  call packager#add('tpope/vim-endwise') " https://github.com/tpope/vim-endwise
  call packager#add('tpope/vim-ragtag') " https://github.com/tpope/vim-ragtag
  call packager#add('alvan/vim-closetag') " https://github.com/alvan/vim-closetag
  call packager#add('AndrewRadev/tagalong.vim') " https://github.com/AndrewRadev/tagalong.vim
  call packager#add('ludovicchabant/vim-gutentags') " https://github.com/ludovicchabant/vim-gutentags
  call packager#add('pechorin/any-jump.vim') " https://github.com/pechorin/any-jump.vim
  call packager#add('AndrewRadev/inline_edit.vim') " https://github.com/AndrewRadev/inline_edit.vim
  call packager#add('AndrewRadev/multichange.vim') " https://github.com/AndrewRadev/multichange.vim
  call packager#add('machakann/vim-swap') " https://github.com/machakann/vim-swap
  " }}}

  " Text Editing {{{
  call packager#add('mzlogin/vim-markdown-toc') " https://github.com/mzlogin/vim-markdown-toc
  call packager#add('reedes/vim-pencil') " https://github.com/reedes/vim-pencil
  call packager#add('junegunn/goyo.vim', { 'type': 'opt' }) " https://github.com/junegunn/goyo.vim
  call packager#add('junegunn/limelight.vim', { 'type': 'opt' }) " https://github.com/junegunn/limelight.vim
  call packager#add('vimwiki/vimwiki', { 'type': 'opt' }) " https://github.com/vimwiki/vimwiki
  call packager#add('reedes/vim-lexical') " https://github.com/reedes/vim-lexical
  " }}}

  " Movements {{{
  call packager#add('wellle/targets.vim', { 'type': 'opt' }) " https://github.com/wellle/targets.vim
  call packager#add('rhysd/clever-f.vim') " https://github.com/rhysd/clever-f.vim
  call packager#add('edkolev/erlang-motions.vim') " https://github.com/edkolev/erlang-motions.vim
  call packager#add('mg979/vim-visual-multi', { 'type': 'opt' }) " https://github.com/mg979/vim-visual-multi
  call packager#add('christoomey/vim-conflicted') " https://github.com/christoomey/vim-conflicted
  call packager#add('rhysd/conflict-marker.vim') " https://github.com/rhysd/conflict-marker.vim
  " }}}

  " Task running & quickfix {{{
  call packager#add('tpope/vim-dispatch') " https://github.com/tpope/vim-dispatch
  " This is only required until vim-dispatch v 1.3 or later. See https://github.com/tpope/vim-dadbod/pull/64
  call packager#add('radenling/vim-dispatch-neovim') " https://github.com/radenling/vim-dispatch-neovim
  call packager#add('hauleth/asyncdo.vim') " https://github.com/hauleth/asyncdo.vim
  call packager#add('romainl/vim-qf') " https://github.com/romainl/vim-qf
  call packager#add('romainl/vim-qlist') " https://github.com/romainl/vim-qlist
  call packager#add('Olical/vim-enmasse') " https://github.com/Olical/vim-enmasse
  call packager#add('igemnace/vim-makery') " https://github.com/igemnace/vim-makery
  " call packager#add('AndrewRadev/qftools.vim') " https://github.com/AndrewRadev/qftools.vim
  " call packager#add('AndrewRadev/linediff.vim') " https://github.com/AndrewRadev/linediff.vim
  " }}}

  " Splits management {{{
  call packager#add('t9md/vim-choosewin') " https://github.com/t9md/vim-choosewin
  call packager#add('dhruvasagar/vim-zoom') " https://github.com/dhruvasagar/vim-zoom
  " }}}

  " Optional debug / test stuff {{{
  call packager#add('Vimjas/vint', { 'type': 'opt' }) " https://github.com/Vimjas/vint
  call packager#add('puremourning/vimspector', { 'type': 'opt' }) " https://github.com/puremourning/vimspector
  call packager#add('vim-test/vim-test') " https://github.com/vim-test/vim-test
  call packager#add('junegunn/vader.vim', { 'type': 'opt' }) " https://github.com/junegunn/vader.vim
  call packager#add('tpope/vim-scriptease', { 'type': 'opt' }) " https://github.com/tpope/vim-scriptease
  call packager#add('tweekmonster/exception.vim', { 'type': 'opt' }) " https://github.com/tweekmonster/exception.vim
  call packager#add('tweekmonster/helpful.vim', { 'type': 'opt' }) " https://github.com/tweekmonster/helpful.vim
  call packager#add('mhinz/vim-lookup', { 'type': 'opt' }) " https://github.com/mhinz/vim-lookup
  call packager#add('thinca/vim-themis', { 'type': 'opt' }) " https://github.com/thinca/vim-themis
  " }}}

  call packager#add('mattn/gist-vim', { 'type': 'opt' }) " https://github.com/mattn/gist-vim
  call packager#add('mbbill/undotree', { 'type': 'opt' }) " https://github.com/mbbill/undotree

  " Loaded only for specific filetypes on demand. Requires autocommands below.
  call packager#add('kristijanhusak/vim-js-file-import', { 'do': 'npm install', 'type': 'opt' }) " https://github.com/kristijanhusak/vim-js-file-import

  call packager#add('voldikss/vim-floaterm') " https://github.com/voldikss/vim-floaterm
  call packager#add('skywind3000/vim-quickui') " https://github.com/skywind3000/vim-quickui

  " Status bar {{{
  call packager#add('liuchengxu/eleline.vim') " https://github.com/liuchengxu/eleline.vim
  " }}}
endfunction

command! -nargs=* -bar PackagerRefresh call s:packager_init() | call packager#install(<args>)
command! -nargs=* -bar PackagerInstall call s:packager_init() | call packager#install(<args>)
command! -nargs=* -bar PackagerUpdate call s:packager_init() | call packager#update(<args>)
command! -bar PackagerClean call s:packager_init() | call packager#clean()
command! -bar PackagerStatus call s:packager_init() | call packager#status()
