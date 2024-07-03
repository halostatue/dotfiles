vim9script

if get(g:, 'hz_config_options_loaded')
  finish
endif

g:hz_config_options_loaded = true

## 1. Load $VIMRUNTIME/defaults.vim
source $VIMRUNTIME/defaults.vim

## 2. Apply settings changes from tpope/vim-sensible. Only options that are not
##    being later overridden are included.

# Disable completing keywords in included files.
set complete-=i

# Use 'shiftwidth' when using `<Tab>` in front of a line. By default it's used
# only for shift commands (`<`, `>`).
set smarttab

# Always show window statuses, even if there's only one.
set laststatus=2

# Show a single line and two columns of context around the cursor for vertical
# and horizaontal scrolling.
set scrolloff=1 sidescroll=1 sidescrolloff=2

# Use both lastline and truncate settings
set display& display+=lastline,truncate

# Set default whitespace characters when using `:set list`
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

# Delete comment character when joining commented lines.
set formatoptions+=j

# Replace the check for a tags file in the parent directory of the current file
# with a check in every ancestor directory.
setglobal tags-=./tags tags-=./tags; tags^=./tags; tags+=tags

# Autoread changed files from disk if they do not conflict with a loaded buffer.
set autoread

# Saving options in session and view files causes more problems than it solves,
# so disable it.
set sessionoptions-=options
set viewoptions-=options

# Allow color schemes to do bright colors without forcing bold.
if &t_Co->str2nr() == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

## 3. Apply changes from sheerun/vimrc not covered in defaults.vim or
##    tpope/vim-sensible. Only options that are not being later overridden are
##    included.

# Autoindent when starting new line, or using `o` or `O`.
set autoindent

# Force utf-8 encoding
set encoding=utf-8

# Improve displayed color if supported by terminal
if &t_Co->str2nr() >= 256
  set termguicolors
endif

# Indent using two spaces.
set tabstop=2 shiftwidth=2

# Enable undofile. Undodir, backupdir, etc. will be set and created later.
set undofile

# Default to 13 pt Monaco on MacVim
if has("gui_macvim")
  set guifont=Monaco:h13
endif

# Highlight line under cursor. It helps with navigation.
set cursorline

# Hide buffers instead of asking if to save them.
set hidden

# Wrap lines by default
set wrap linebreak

# Disable any annoying beeps on errors.
set noerrorbells visualbell

# Don't parse modelines (google "vim modeline vulnerability"). We have a plugin for
# reading modelines safely.
set nomodeline

# Do not fold by default. But if, do it up to 3 levels.
set foldmethod=indent foldnestmax=3 nofoldenable

# Enable mouse for scrolling and window resizing.
set mouse=a

# Enable search highlighting.
set hlsearch

# Ignore case when searching.
set ignorecase

# Don't ignore case when search has any capital letter.
set smartcase

# Add gems.tags to files searched for tags.
setglobal tags+=gems.tags

# Set window title by default.
set title

# Merge signcolumn with number line (if supported)
set signcolumn=number

## 4. Everything else. Some of these are variations on what is in defaults.vim,
##    tpope/vim-sensible and sheerun/vimrc. Others are just my preferences.

# Add the spell checking dictionary, files in 'dictionary' and 'thesarus' for
# completion.
set complete+=kspell,k,s

# Set the complete popup to show a menu, even if there is one item. Extra
# information should be shown in a popup, not a preview. Insert only on
# selection and do not automatically select an entry.
set completeopt=menu,menuone,popup,noinsert,noselect

# Show the tag name and the search pattern for possible matches.
set showfulltag
# Use smartcase/ignorecase settings for tag file searches.
set tagcase=followscs

# Persist g:UPPERCASE variables, used by some plugins, in .viminfo. Save up to
# 100 marks, enable capital marks.
set viminfo=!,'100,<50,s10,h

# When saving session and view files, always use LF line endings and store files
# with '/' directory separators.
set sessionoptions+=unix,slash viewoptions+=unix,slash

# Use 2 spaces for soft tabstops.
set softtabstop=2

# Ensure that swapfiles, view files, undo files, and backup files, are created
# in a common path.
&directory = hz#MkXdgVimPath('cache', 'swap//')
&viewdir = hz#MkXdgVimPath('cache', 'view/')
&undodir = hz#MkXdgVimPath('cache', 'undo//')
&backupdir = hz#MkXdgVimPath('cache', 'backup//')

# Disable `fsync()` after writing a file.
set nofsync

# Allow windows to be collapsed completely in either direction.
set winminheight=0 winminwidth=0
# Set the helpheight to ten lines.
set helpheight=10

# Turn off all GUI options and toolbar options (we disable the toolbar).
set guioptions= toolbar=

# Wrap lines by default, using '↪ ' and indent broken lines.
&showbreak = '↪ '
set breakindent
# Allow movement to wrap around lines using <BS>, <Space>, <Left>, <Right>, or
# ~.
set whichwrap=b,s,<,>,~,[,]

# Default to showing relative line numbers with the absolute line number on the current
# line. Look at autoload/autonumber.vim.
set number relativenumber

# Do not ring the bell for error messages (`noerrorbells`), turn on visual bell
# (`visualbell`), but really turn it off (`t_vb=`).
set belloff=all t_vb=

# Set the short messages. We want all of the shortened messages. Instead of stacking
# messages, they should be overwritten. Suppress search wrap messages. Truncate file
# messsages at the start and other messages in the middle. Suppress swap file warnings.
# Suppress the intro message and ins-completion-menu messages. Suppress file info when
# editing a file.
set shortmess=aoOstTAIcF

# Override ignorecase if the search pattern contains upper case characters.
set smartcase

# Spell checking treats CamelCasedWords as separate words (camel cased words).
set spelloptions=camel
# Limit the number of spelling suggestions to ten using the `best` method.
set spellsuggest=best,10

# Give the title length more space.
set titlelen=95

# Set the title to FILE FLAGS (CWD) - SERVER
#
# - FILE: The minimum path to the file relative to the CWD.
# - FLAGS: Modified and/or preview state of the file (may be empty)
# - CWD: The (possibly) truncated current directory, relative to $HOME.
# - SERVER: The current Vim server name (or VIM)
&titlestring =
  '%{expand("%:p:~:.")} %(%m%w%) %<'
  .. '(%{printf("%.*S", &columns - len(expand("%:p:~:."))'
  .. ', fnamemodify(getcwd(), ":~"))}) - %{v:servername}'

# Split to the right and above.
set splitright nosplitbelow

# Crash recovery write every second, and CursorHold event timeout. This should be 300 or
# less to avoid issues with coc.nvim.
set updatetime=1000

# Turn off autochdir.
set noautochdir

# Autowrite changed files to disk before executing certain commands.
set autowrite noautowriteall

# Make things safer on Windows
if exists('+shellslash')
  set shellslash
endif

# Expand tabs to whitespace.
set expandtab
# Do not round indent to shiftwidth.
set noshiftround
# Do smart autoindenting when starting a new line.
set smartindent
# Enable automatic C program indenting.
set cindent

# Reasonable match settings.
set showmatch matchpairs+=<:> matchtime=3 cpoptions-=m

# One space after punctuation on line joins.
set nojoinspaces

# Start and stop selection using shift-cursor.
set keymodel=startsel,stopsel

# Keymapping timeout.
set timeout timeoutlen=600

# Enable virtualedit in visual block mode
set virtualedit+=block

# Do not automatically resize the window.
set noequalalways nolazyredraw

# Highlight one and five columns past textwidth.
set colorcolumn=+1,+5

# The file browser starts from the directory of the current directory, not the current
# buffer.
set browsedir=current

# Only show the tabline when there are at least two tab pages.
set showtabline=1

# Reset diffopt and add algorithm:histogram and use indent-heuristics.
set diffopt& diffopt+=algorithm:histogram,indent-heuristic

# Ignore case on filename completion and use <Tab> for completion.
set wildignorecase wildcharm=<Tab>
# Wildchar completion shows a list of longest, then full.
set wildmode=list:longest,list:full

# Extend `suffixes` to support python and Java compiled files
&suffixes =
  &suffixes
    ->split(',')
    ->extendnew(['.pyc', '.pyo', '.egg-info', '.class'])
    ->uniq()
    ->join(',')

# Extend 'wildignore' file patterns.
&wildignore =
  &wildignore
    ->split(',')
    ->extendnew([
      '*.078', '*.7z', '*.a', '*.android', '*.apk', '*.app', '*.aux', '*.avi', '*.beam',
      '*.bin', '*.bmp', '*.bz2', '*.chm', '*.class', '*.crx', '*.darwin', '*.deb',
      '*.dex', '*.dll', '*.dmg', '*.docx', '*.dylib', '*.egg', '*.epub', '*.exe', '*.flv',
      '*.freebsd', '*.gba', '*.gem', '*.gif', '*.git', '*.gz', '*.gzip', '*.img', '*.ipa',
      '*.ipch', '*.iso', '*.jar', '*.jnlp', '*.jpeg', '*.jpg', '*.lib', '*.linux',
      '*.linux2', '*.luac', '*.manifest', '*.mht', '*.mkv', '*.mobi', '*.mov', '*.mp3',
      '*.mp4', '*.msi', '*.msu', '*.nds', '*.o', '*.obj', '*.odt', '*.ogg', '*.out',
      '*.pcm', '*.pcx', '*.pdb', '*.pdf', '*.png', '*.ppm', '*.ppt', '*.pptx', '*.pyc',
      '*.pyo', '*.rar', '*.rbc', '*.rbo', '*.sdf', '*.sfc', '*.smc', '*.smd', '*.so',
      '*.spl', '*.suo', '*.sw?', '*.swc', '*.swf', '*.swp', '*.tar', '*.tar.bz2',
      '*.tar.gz', '*.tar.xz', '*.tga', '*.tgz', '*.toc', '*.ttf', '*.vfd', '*.wav',
      '*.win32', '*.wps', '*.xls', '*.xlsx', '*.xlt', '*.xz', '*.zip', '*/.bundle/**',
      '*/.nx/**', '*/.rbenv/**', '*/.sass-cache/**', '*/.Trash/**', '*/_build/**',
      '*/node_modules/**', '*/vendor/cache/**', '*/vendor/gems/**', '*DS_Store*', '*~',
      '._*', '.DS_Store', '.git', '.hg', '.o', '.svn',
    ])
    ->uniq()
    ->join(',')

# Set grepprg to ripgrep, ag, or use better defaults for grep
&grepprg =
  executable('rg')
  ? 'rg --line-number --color never --no-heading $*'
  : executable('ag')
  ? 'ag --nogroup --nocolor $*'
  : 'grep -inH $*'

# Override fill characters
set fillchars+=vert:\│,fold:\·,foldsep:\│

# Scroll at least three lines when going off the screen.
set scrolljump=3

# Keep 10,000 commands in history.
set history=10000
# Allow for up to 1 opened tab on Vim start. I would prefer to disable vim tabs entirely.
set tabpagemax=1
# Configure the 'cursorline' to highlight the both text line and the line number.
set cursorlineopt=line,number
# If opening buffer, search first in opened windows. Ignore open tabs.
set switchbuf=useopen,split,uselast

# Load platform-specific configuration.
execute printf('runtime config/options/%s.vim', hz#Platform())

filetype plugin indent on
syntax on
syntax enable
