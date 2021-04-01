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
set belloff=all noerrorbells novisualbell t_vb=

" Reasonably modern tab and indentation settings suitable for most languages
set tabstop=2 softtabstop=2 shiftwidth=2 shiftround expandtab autoindent smarttab

" Reasonable match settings.
set showmatch cpoptions-=m matchtime=3 matchpairs+=<:>

" Autoread changed files from disk if they do not conflict with a loaded
" buffer; autowrite changed files to disk before executing certain commands.
set autoread autowrite

set nomodeline " Turn off modeline detection.
set nojoinspaces " One space after punctuation on line joins.
set keymodel=startsel,stopsel " Start and stop selection using shift-cursor.

" Sensible scrolling behaviours:
set scrolljump=3 scrolloff=1 sidescroll=1 sidescrolloff=5

set hidden " Display another buffer when current buffer isn't saved.
set infercase " Ignore case on insert completion.
set hlsearch ignorecase noshowmode smartcase incsearch

set timeout timeoutlen=600 " Keymapping timeout.
set updatetime=1000 " Crash recovery write every second, and CursorHold event timeout.

let &directory = hz#xdg_path('cache', 'swap//')
call hz#mkpath(&directory, v:true)

let &undodir = hz#xdg_path('cache', 'undo//')
call hz#mkpath(&undodir, v:true)

let &backupdir = hz#xdg_path('cache', 'backup//')
call hz#mkpath(&backupdir, v:true)

let &viewdir = hz#xdg_path('cache', 'view/')
call hz#mkpath(&viewdir, v:true)

set undofile nobackup writebackup
set viewoptions+=unix,slash viewoptions-=options
set sessionoptions+=unix,slash sessionoptions-=options

set virtualedit+=block " Enable virtualedit in visual block mode

if has('conceal') | set conceallevel=2 concealcursor=nc | endif

" = Keyword completion options
" == ins-completion search order: current buffer; other window buffers;
" unloaded buffers; tags; current and included files; spell checking
" dictionary; files in 'dictionary'; files in 'thesaurus'
set complete+=kspell,k,s complete-=w,b,u,i
if has('insert_expand') | set completeopt-=preview pumheight=20 | endif

" Add gems.tags to files searched for tags.
set noequalalways nolazyredraw

" Let windows be squeezed just their status bar (horizontal splits) or the
" separator (vertical splits). Also make the help window a minimum of 10 rows
" instead of 20.
set winminheight=0 winminwidth=0 helpheight=10

" Use dash as word separator.
set iskeyword+=-

" The file browser starts from the directory of the current directory, not the
" current buffer.
set browsedir=current

set background=dark cscopeverbose cursorline colorcolumn=80,100,120
set display=lastline formatoptions=tcqr1nj
set history=10000 laststatus=2
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set nofsync nostartofline shortmess=aoOTIcFA tabpagemax=50 showtabline=1
set number relativenumber splitright noshowcmd ruler
set diffopt& diffopt-=iwhite diffopt+=algorithm:histogram,indent-heuristic

" Handle wildmenu matching
set wildcharm=<C-Z> wildmode=list:longest,list:full wildoptions+=tagfile
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
set title titlelen=95
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

set nofoldenable "foldmethod=marker foldcolumn=1 commentstring=#\ %s
set mouse=a

" Prefer ripgrep, pt or ag over grep for :grep.
if executable('rg')
  let &grepprg='rg --line-number --color never --no-heading $*'
elseif executable('pt')
  let &grepprg='pt --nogroup --nocolor $*'
elseif executable('ag')
  let &grepprg='ag --nogroup --nocolor $*'
else
  let &grepprg='grep -inH $*'
endif

setglobal encoding=utf-8
set tags-=./tags tags-=./tags; tags^=./tags; tags+=gems.tags showfulltag

let mapleader = "\<Space>"

" Set linebreaking and wrapping rules.
if has('linebreak')
  set wrap linebreak showbreak=↪ whichwrap=b,s,h,l,<,>,~,[,]
  if exists('+breakindent') | set breakindent | endif
else
  set nowrap
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
elseif &t_Co >= 256
  set termguicolors
endif

" These files prevent running on their opposite, so just include both.
runtime config/defaults/nvim.vim
runtime config/defaults/vim.vim

exe 'runtime config/defaults/' . hz#platform() . '.vim'
