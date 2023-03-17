scriptencoding utf-8

" Set a bunch of sensible defaults. This is a combination of several sources:
"
" - $VIMRUNTIME/defaults.vim (Vim 8+, not neovim);
" - neovim defaults;
" - tpope/vim-sensible;
" - sheerun/vimrc; and
" - my own preferences.

" Make things safer on Windows
if exists('+shellslash') | set shellslash | endif

" Do not ring the bell for error messages (`noerrorbells`), turn on visual
" bell (`visualbell`), but really turn it off (`t_vb=`). Note that when the
" GUI starts, `t_vb` gets reset to `<Esc>|f`, so config/autocmd.vim has an
" autogroup that does this when the GUI is entered.
set belloff=all
set noerrorbells
set novisualbell
set t_vb=

" Reasonably modern tab and indentation settings suitable for most languages
set autoindent
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2

" Reasonable match settings.
set cpoptions-=m
set matchpairs+=<:>
set matchtime=3
set showmatch

" Autoread changed files from disk if they do not conflict with a loaded
" buffer; autowrite changed files to disk before executing certain commands.
set autoread
set autowrite

" Turn off modeline detection.
set nomodeline
" One space after punctuation on line joins.
set nojoinspaces
" Start and stop selection using shift-cursor.
set keymodel=startsel,stopsel

" Sensible scrolling behaviours:
set scrolljump=3
set scrolloff=1
set sidescroll=1
set sidescrolloff=5

" Display another buffer when current buffer isn't saved.
set hidden
" Ignore case on insert completion.
set hlsearch
set ignorecase
set incsearch
set infercase
set noshowmode
set smartcase

" Keymapping timeout.
set timeout
set timeoutlen=600
" Crash recovery write every second, and CursorHold event timeout.
set updatetime=1000

let &directory = hz#xdg_path('cache', 'swap//')
call hz#mkpath(&directory, v:true)

let &undodir = hz#xdg_path('cache', 'undo//')
call hz#mkpath(&undodir, v:true)

let &backupdir = hz#xdg_path('cache', 'backup//')
call hz#mkpath(&backupdir, v:true)

let &viewdir = hz#xdg_path('cache', 'view/')
call hz#mkpath(&viewdir, v:true)

set nobackup
set sessionoptions+=unix,slash
set sessionoptions-=options
set undofile
set viewoptions+=unix,slash
set viewoptions-=options
set nowritebackup

" Enable virtualedit in visual block mode
set virtualedit+=block

if has('conceal')
  set conceallevel=2
  set concealcursor=nc
endif

" = Keyword completion options
" == ins-completion search order: current buffer; other window buffers;
" unloaded buffers; tags; current and included files; spell checking
" dictionary; files in 'dictionary'; files in 'thesaurus'
set complete+=kspell,k,s
set complete-=w,b,u,i
if has('insert_expand')
  set completeopt-=preview
  set pumheight=20
endif

set noequalalways
set nolazyredraw

" Let windows be squeezed just their status bar (horizontal splits) or the
" separator (vertical splits). Also make the help window a minimum of 10 rows
" instead of 20.
set helpheight=10
set winminheight=0
set winminwidth=0

" Use dash as word separator. -- this should be language-specific
" set iskeyword+=-

" The file browser starts from the directory of the current directory, not the
" current buffer.
set browsedir=current
set colorcolumn=+1,+10,+20
set cscopeverbose
set cursorline
set display=lastline
set formatoptions=tcqr1nj
set history=10000
set laststatus=2
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set nofsync
set noshowcmd
set nostartofline
set number
set relativenumber
set ruler
set shortmess=aoOTIcFA
set showtabline=1
set splitright
set tabpagemax=50

set diffopt&
set diffopt-=iwhite
set diffopt+=algorithm:histogram,indent-heuristic

" Handle wildmenu matching
set wildcharm=<Tab>
set wildmode=list:longest,list:full
set wildoptions+=tagfile

" Ignore the following file patterns when completing files.
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc,*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.so,*.dylib
set wildignore+=*.class,*.beam,*.spl,*.sw?,*~,._*,.DS_Store
set wildignore+=*.luac,*.pyc,*.rbc,*.rbo,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/**,*/vendor/cache/**,*/.bundle/**,*/.sass-cache/**
set wildignore+=*/_build/**,*/node_modules/**

" Turn on the window title and make it a little more useful.
set title
set titlelen=95

" The the title to FILE FLAGS (CWD) - SERVER
"
" - FILE: The minimum path to the file relative to the CWD.
" - FLAGS: Modified and/or preview state of the file (may be empty)
" - CWD: The (possibly) truncated current directory, relative to $HOME.
" - SERVER: The current Vim server name (or VIM)
let &titlestring =
      \  '%{expand("%:p:~:.")} %(%m%w%) %<'
      \. '(%{printf("%.*S", &columns - len(expand("%:p:~:."))'
      \. ', fnamemodify(getcwd(), ":~"))}) - %{v:servername}'

" Folding settings.

set nofoldenable
" set commentstring=#\ %s
" set foldcolumn=1
" set foldmethod=marker

set mouse=a

" Prefer ripgrep, pt or ag over grep for :grep.
if executable('rg')
  let &grepprg='rg --line-number --color never --no-heading $*'
elseif executable('ag')
  let &grepprg='ag --nogroup --nocolor $*'
else
  let &grepprg='grep -inH $*'
endif

setglobal encoding=utf-8

" Add gems.tags to files searched for tags.
set tags-=./tags tags-=./tags;
set tags^=./tags;
set tags+=gems.tags
set showfulltag

let mapleader = "\<Space>"

" Set linebreaking and wrapping rules.
if has('linebreak')
  set wrap
  set linebreak
  set showbreak=↪
  set whichwrap=b,s,h,l,<,>,~,[,]

  if exists('+breakindent')
    set breakindent
  endif
else
  set nowrap
endif

set termguicolors
set background=dark

if has('autocmd') | filetype plugin indent on | endif
if has('syntax') && !exists('g:syntax_on') | syntax enable | endif

set viminfo^=!
set fillchars+=vert:\│,fold:\·,foldsep:\│

exe 'runtime config/defaults/' . hz#platform() . '.vim'

" Prevent several default plug-ins from being loaded, because we don't want
" them.
let g:loaded_2html_plugin = 1 " Disable the TOhtml command.
let g:loaded_getscriptPlugin = 1 " Disable GetLatestVimScripts
let g:loaded_logiPat = 1 " Disable LogiPat
let g:loaded_matchparen = 1 " Disable default matchparen
let g:loaded_netrwPlugin = 1 " Disable netrw and prefer NERD-tree.
let g:netrw_nogx = 1 " disable netrw's gx mapping.

let g:loaded_vimballPlugin = 1 " Disable vimballs.
let g:loaded_matchit = 1 " Disable matchit; using matchup instead
