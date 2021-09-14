-- Set a bunch of sensible defaults. This is a combination of several sources:
--
-- - $VIMRUNTIME/defaults.vim (Vim 8+, not neovim);
-- - neovim defaults;
-- - tpope/vim-sensible;
-- - sheerun/vimrc; and
-- - my own preferences.

local termcode = require('config.utils').termcode

local cmd = vim.api.nvim_command
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local xdg_path = fn['hz#xdg_path']
local mkpath = fn['hz#mkpath']

-- Do not ring the bell for error messages (`noerrorbells`), turn on visual
-- bell (`visualbell`).
opt.belloff = 'all'
opt.errorbells = false
opt.visualbell = false

-- Reasonably modern tab and indentation settings suitable for most languages
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.shiftround = true
opt.autoindent = true
opt.smarttab = true

-- Reasonable match settings.
opt.showmatch = true
opt.cpoptions:remove('m')
opt.matchtime = 3
opt.matchpairs:append('<:>')

-- Autoread changed files from disk if they do not conflict with a loaded
-- buffer; autowrite changed files to disk before executing certain commands.
opt.autoread = true
opt.autowrite = true

opt.modeline = false -- Turn off modeline detection.
opt.joinspaces = false -- One space after punctuation on line joins.
-- Start and stop selection using shift-cursor.
opt.keymodel = { 'startsel', 'stopsel' }

-- Sensible scrolling behaviours:
opt.scrolljump = 3
opt.scrolloff = 1
opt.sidescroll = 1
opt.sidescrolloff = 5

opt.hidden = true -- Display another buffer when current buffer isn't saved.
opt.infercase = true -- Ignore case on insert completion.
opt.hlsearch = true
opt.ignorecase = true
opt.showmode = false
opt.smartcase = true
opt.incsearch = true

opt.timeout = true
opt.timeoutlen = 600 -- Keymapping timeout.
-- Crash recovery write every second, and CursorHold event timeout.
opt.updatetime = 1000

-- TODO
opt.directory = mkpath(xdg_path('cache', 'swap//'), true)
opt.undodir = mkpath(xdg_path('cache', 'undo//'), true)
opt.backupdir = mkpath(xdg_path('cache', 'backup//'), true)
opt.viewdir = mkpath(xdg_path('cache', 'view/'), true)

opt.undofile = true
opt.backup = false
opt.writebackup = false
opt.viewoptions:append { 'unix', 'slash' }
opt.viewoptions:remove { 'options' }
opt.sessionoptions:append { 'unix', 'slash' }
opt.sessionoptions:remove { 'options' }

-- Enable virtualedit in visual block mode
opt.virtualedit:append('block')

if fn.has('conceal') then
  opt.conceallevel = 2
  opt.concealcursor = 'nc'
end

-- = Keyword completion options
-- == ins-completion search order: current buffer; other window buffers;
-- unloaded buffers; tags; current and included files; spell checking
-- dictionary; files in 'dictionary'; files in 'thesaurus'
opt.complete:append { 'kspell', 'k', 's' }
opt.complete:remove { 'w', 'b', 'u', 'i' }
if fn.has('insert_expand') then
  opt.completeopt:remove('preview')
  opt.pumheight = 20
end

opt.equalalways = false
opt.lazyredraw = false

-- Let windows be squeezed just their status bar (horizontal splits) or the
-- separator (vertical splits). Also make the help window a minimum of 10 rows
-- instead of 20.
opt.winminheight = 0
opt.winminwidth = 0
opt.helpheight = 10

-- Use dash as word separator.
opt.iskeyword:append('-')

opt.cscopeverbose = true
opt.cursorline = true
opt.colorcolumn = { '+1', '+10', '+20' }
opt.display = 'lastline'
opt.formatoptions = 'tcqr1nj'
opt.history = 10000
opt.laststatus = 2
opt.listchars  =  { tab = '> ', trail = '-', extends = '>', precedes = '<', nbsp = '+' }
opt.fsync = false
opt.startofline = false
opt.shortmess = 'aoOTIcFA'
opt.tabpagemax = 50
opt.showtabline = 1
opt.number = true
opt.relativenumber = true
opt.splitright = true
opt.showcmd = false
opt.ruler = true

cmd [[ set diffopt& ]]
opt.diffopt:remove { 'iwhite' }
opt.diffopt:append { 'algorithm:histogram', 'indent-heuristic' }

-- Handle wildmenu matching
opt.wildcharm = fn.char2nr(termcode('<Tab>'))
opt.wildmode = { 'list:longest', 'list:full' }
opt.wildoptions:append { 'tagfile' }

-- Ignore the following file patterns when completing files.
opt.wildignore:append {
  '.hg', '.git', '.svn', '*.aux', '*.out', '*.toc', '*.jpg', '*.bmp', '*.gif', '*.png', '*.jpeg', '*.o', '*.obj',
  '*.exe', '*.dll', '*.manifest', '*.so', '*.dylib', '*.class', '*.beam', '*.spl', '*.sw?', '*~', '._*', '.DS_Store',
  '*.luac', '*.pyc', '*.rbc', '*.rbo', '*.gem', '*.zip', '*.tar.gz', '*.tar.bz2', '*.rar', '*.tar.xz',
  '*/vendor/gems/**', '*/vendor/cache/**', '*/.bundle/**', '*/.sass-cache/**', '*/_build/**', '*/node_modules/**',
}

-- Turn on the window title and make it a little more useful.
opt.title = true
opt.titlelen = 95

-- The the title to FILE FLAGS (CWD) - SERVER
--
-- - FILE: The minimum path to the file relative to the CWD.
-- - FLAGS: Modified and/or preview state of the file (may be empty)
-- - CWD: The (possibly) truncated current directory, relative to $HOME.
-- - SERVER: The current Vim server name (or VIM)
opt.titlestring = '%{expand("%:p:~:.")} %(%m%w%) %<' ..
  '(%{printf("%.*S", &columns - len(expand("%:p:~:."))' ..
  ', fnamemodify(getcwd(), ":~"))}) - %{v:servername}'

-- Folding settings.
opt.foldenable = false
-- opt.foldmethod = 'marker'
-- opt.foldcolumn = 1
-- opt.commentstring = '# %s'

opt.mouse = 'a'

-- -- Prefer ripgrep, pt or ag over grep for :grep.
local grepper
if fn.executable('rg') then
  grepper = 'rg --line-number --color never --no-heading $*'
elseif fn.executable('pt') then
  grepper = 'pt --nogroup --nocolor $*'
elseif fn.executable('ag') then
  grepper = 'ag --nogroup --nocolor $*'
else
  grepper = 'grep -inH $*'
end
opt.grepprg = grepper

opt.encoding = 'utf-8'

opt.tags:remove { './tags', './tags;' }
opt.tags:prepend { './tags;' }
opt.tags:append { 'gems.tags' }
opt.showfulltag = true

g.mapleader = [[ ]]
-- g.maplocalleader = [[,]]

-- Set linebreaking and wrapping rules.
if fn.has('linebreak') then
  opt.wrap = true
  opt.linebreak = true
  opt.showbreak = '↪'
  opt.whichwrap = 'bshl<>~[]'

  if fn.exists('+breakindent') then
    opt.breakindent = true
  end
else
  opt.wrap = false
end

opt.termguicolors = true
opt.background = 'dark'

opt.fillchars = { vert = '│', fold = '·', foldsep='│' }
opt.shada:prepend { '!' }

require('config.defaults.' .. fn['hz#platform']())

-- Prevent several default plug-ins from being loaded, because we don't want
-- them.

local disabled_built_ins = {
  '2html',
  'gzip',
  'man',
  'matchit',
  'matchparen',
  'netrwPlugin',
  'shada_plugin',
  'tarPlugin',
  'tutor_mode_plugin',
  'zipPlugin',
}

-- Disable various built-in plug-ins.
for _, v in ipairs(disabled_built_ins) do
  g['loaded_' .. v] = 1
end

vim.g.netrw_nogx = 1 -- disable netrw's gx mapping.
