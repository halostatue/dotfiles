vim9script

# Set a bunch of sensible defaults. This is a combination of several sources:
#
# - $VIMRUNTIME/defaults.vim (Vim 8+, not neovim);
# - neovim defaults;
# - tpope/vim-sensible;
# - sheerun/vimrc; and
# - my own preferences.

# Make things safer on Windows
if exists('+shellslash') 
  set shellslash 
endif

# Do not ring the bell for error messages (`noerrorbells`), turn on visual
# bell (`visualbell`), but really turn it off (`t_vb=`).
set belloff=all noerrorbells novisualbell t_vb=

# Note that when the GUI starts, `t_vb` gets reset to `<Esc>|f`, so we use
# this auto command group that does this when the GUI is entered.
augroup reset-bells-no-really
  autocmd!

  autocmd GUIEnter * set t_vb=
augroup END

# Reasonably modern tab and indentation settings suitable for most languages
set autoindent expandtab shiftround smarttab
set shiftwidth=2 softtabstop=2 tabstop=2

# Reasonable match settings.
set showmatch matchpairs+=<:> matchtime=3 cpoptions-=m

# Autoread changed files from disk if they do not conflict with a loaded
# buffer; autowrite changed files to disk before executing certain commands.
set autoread autowrite

# Turn off modeline detection.
set nomodeline

# One space after punctuation on line joins.
set nojoinspaces

# Start and stop selection using shift-cursor.
set keymodel=startsel,stopsel

# Sensible scrolling behaviours:
set scrolljump=3 scrolloff=1 sidescroll=1 sidescrolloff=5

# Display another buffer when current buffer isn't saved.
set hidden

# Ignore case on search completion by default
set hlsearch ignorecase incsearch infercase noshowmode smartcase

# Keymapping timeout.
set timeout timeoutlen=600

# Crash recovery write every second, and CursorHold event timeout.
set updatetime=1000

&directory = hz#xdg_path('cache', 'swap//')
hz#mkpath(&directory, true)

&undodir = hz#xdg_path('cache', 'undo//')
hz#mkpath(&undodir, true)

&backupdir = hz#xdg_path('cache', 'backup//')
hz#mkpath(&backupdir, true)

&viewdir = hz#xdg_path('cache', 'view/')
hz#mkpath(&viewdir, true)

set nobackup nowritebackup undofile nofsync
set sessionoptions+=unix,slash sessionoptions-=options
set viewoptions+=unix,slash viewoptions-=options

# Enable virtualedit in visual block mode
set virtualedit+=block
set conceallevel=0

# = Keyword completion options
# == ins-completion search order: current buffer; other window buffers;
# unloaded buffers; tags; current and included files; spell checking
# dictionary; files in 'dictionary'; files in 'thesaurus'
set complete+=kspell,k,s complete-=w,b,u,i
set completeopt-=preview pumheight=20

set noequalalways nolazyredraw

# Let windows be squeezed just their status bar (horizontal splits) or the
# separator (vertical splits). Also make the help window a minimum of 10 rows
# instead of 20.
set helpheight=10 winminheight=0 winminwidth=0 laststatus=2

set colorcolumn=+1,+10,+20 cursorline

# The file browser starts from the directory of the current directory, not the
# current buffer.
set browsedir=current
set nocscopeverbose

set display=lastline formatoptions=tcqr1nj showtabline=1 tabpagemax=5
set splitright history=10000
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ shortmess=aoOTIcFA
set noshowcmd nostartofline
set number relativenumber ruler
set nofoldenable

set diffopt& diffopt-=iwhite diffopt+=algorithm:histogram,indent-heuristic

# Handle wildmenu matching
set wildcharm=<Tab> wildmode=list:longest,list:full wildoptions+=tagfile

# Ignore the following file patterns when completing files.
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc,*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.so,*.dylib
set wildignore+=*.class,*.beam,*.spl,*.sw?,*~,._*,.DS_Store
set wildignore+=*.luac,*.pyc,*.rbc,*.rbo,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/**,*/vendor/cache/**,*/.bundle/**,*/.sass-cache/**
set wildignore+=*/_build/**,*/node_modules/**

# Turn on the window title and make it a little more useful.
set title titlelen=95

# The the title to FILE FLAGS (CWD) - SERVER
#
# - FILE: The minimum path to the file relative to the CWD.
# - FLAGS: Modified and/or preview state of the file (may be empty)
# - CWD: The (possibly) truncated current directory, relative to $HOME.
# - SERVER: The current Vim server name (or VIM)
&titlestring =
  '%{expand("%:p:~:.")} %(%m%w%) %<'
  .. '(%{printf("%.*S", &columns - len(expand("%:p:~:."))'
  .. ', fnamemodify(getcwd(), ":~"))}) - %{v:servername}'

set mouse=a

# Prefer ripgrep or ag over grep for :grep.
if executable('rg')
  &grepprg = 'rg --line-number --color never --no-heading $*'
elseif executable('ag')
  &grepprg = 'ag --nogroup --nocolor $*'
else
  &grepprg = 'grep -inH $*'
endif

set encoding=utf-8

# Add gems.tags to files searched for tags.
set showfulltag tags-=./tags tags-=./tags tags^=./tags; tags+=gems.tags

g:mapleader = "\<Space>"

# Set linebreaking and wrapping rules.
set wrap linebreak showbreak=↪ whichwrap=b,s,h,l,<,>,~,[,] breakindent

set termguicolors background=dark

filetype plugin indent on
syntax enable

set viminfo^=! fillchars+=vert:\│,fold:\·,foldsep:\│

execute printf('runtime config/defaults/%s.vim', hz#platform())

# Prevent several default plug-ins from being loaded, because I don't want
# them.
g:loaded_2html_plugin = 1 # Disable the TOhtml command.
g:loaded_getscriptPlugin = 1 # Disable GetLatestVimScripts
g:loaded_logiPat = 1 # Disable LogiPat
g:loaded_matchit = 1 # Disable matchit; using matchup instead
g:loaded_matchparen = 1 # Disable default matchparen
g:loaded_netrwPlugin = 1 # Disable netrw and prefer NERD-tree.
g:loaded_vimballPlugin = 1 # Disable vimballs.
g:netrw_nogx = 1 # disable netrw's gx mapping.
