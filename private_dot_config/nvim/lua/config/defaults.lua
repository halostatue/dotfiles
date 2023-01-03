-- Set a bunch of sensible defaults. This is a combination of several sources:
--
-- - $VIMRUNTIME/defaults.vim (Vim 8+, not neovim);
-- - neovim defaults;
-- - tpope/vim-sensible;
-- - sheerun/vimrc; and
-- - my own preferences.
local termcode = require('config.utils').termcode

-- Do not ring the bell for error messages (`noerrorbells`), turn on visual
-- bell (`visualbell`).
vim.opt.belloff = 'all'
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Reasonably modern tab and indentation settings suitable for most languages
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Reasonable match settings.
vim.opt.cpoptions:remove('m')
vim.opt.matchpairs:append('<:>')
vim.opt.matchtime = 3
vim.opt.showmatch = true

-- Autoread changed files from disk if they do not conflict with a loaded
-- buffer; autowrite changed files to disk before executing certain commands.
vim.opt.autoread = true
vim.opt.autowrite = true

-- Turn off modeline detection.
vim.opt.modeline = false
-- One space after punctuation on line joins.
vim.opt.joinspaces = false
-- Start and stop selection using shift-cursor.
vim.opt.keymodel = { 'startsel', 'stopsel' }

-- Sensible scrolling behaviours:
vim.opt.scrolljump = 3
vim.opt.scrolloff = 1
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5

-- Display another buffer when current buffer isn't saved.
vim.opt.hidden = true
-- Ignore case on insert completion.
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.showmode = false
vim.opt.smartcase = true

-- Keymapping timeout.
vim.opt.timeout = true
vim.opt.timeoutlen = 600
-- Crash recovery write every second, and CursorHold event timeout.
vim.opt.updatetime = 1000

-- TODO
local xdg_path = vim.fn['hz#xdg_path']
local mkpath = vim.fn['hz#mkpath']

vim.opt.directory = mkpath(xdg_path('cache', 'swap//'), true)
vim.opt.undodir = mkpath(xdg_path('cache', 'undo//'), true)
vim.opt.backupdir = mkpath(xdg_path('cache', 'backup//'), true)
vim.opt.viewdir = mkpath(xdg_path('cache', 'view/'), true)

vim.opt.backup = false
vim.opt.sessionoptions:append { 'unix', 'slash' }
vim.opt.sessionoptions:remove { 'options' }
vim.opt.undofile = true
vim.opt.viewoptions:append { 'unix', 'slash' }
vim.opt.viewoptions:remove { 'options' }
vim.opt.writebackup = false

-- Enable virtualedit in visual block mode
vim.opt.virtualedit:append('block')

if vim.fn.has('conceal') then
  vim.opt.conceallevel = 2
  vim.opt.concealcursor = 'nc'
end

-- = Keyword completion options
-- == ins-completion search order: current buffer; other window buffers;
-- unloaded buffers; tags; current and included files; spell checking
-- dictionary; files in 'dictionary'; files in 'thesaurus'
vim.opt.complete:append { 'kspell', 'k', 's' }
vim.opt.complete:remove { 'w', 'b', 'u', 'i' }
vim.opt.completeopt:remove { 'preview' }
vim.opt.completeopt:append { 'menuone', 'noselect' }
vim.opt.pumheight = 20

vim.opt.equalalways = false
vim.opt.lazyredraw = false

-- Let windows be squeezed just their status bar (horizontal splits) or the
-- separator (vertical splits). Also make the help window a minimum of 10 rows
-- instead of 20.
vim.opt.helpheight = 10
vim.opt.winminheight = 0
vim.opt.winminwidth = 0

-- Use dash as word separator. -- this should be language-specific
vim.opt.iskeyword:append('-')

-- The file browser starts from the directory of the current directory, not the
-- current buffer.
vim.opt.browsedir = current
vim.opt.colorcolumn = { '+1', '+10', '+20' }
vim.opt.cscopeverbose = true
vim.opt.cursorline = true
vim.opt.display = 'lastline'
vim.opt.formatoptions = 'tcqr1nj'
vim.opt.fsync = false
vim.opt.history = 10000
vim.opt.laststatus = 2
vim.opt.listchars = { tab = '> ', trail = '-', extends = '>', precedes = '<', nbsp = '+' }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.shortmess = 'aoOTIcFA'
vim.opt.showcmd = false
vim.opt.showtabline = 1
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.tabpagemax = 50

vim.cmd([[ set diffopt& ]])
vim.opt.diffopt:remove { 'iwhite' }
vim.opt.diffopt:append { 'algorithm:histogram', 'indent-heuristic' }

-- Handle wildmenu matching
vim.opt.wildcharm = vim.fn.char2nr(termcode('<Tab>'))
vim.opt.wildmode = { 'list:longest', 'list:full' }
vim.opt.wildoptions:append { 'tagfile' }

-- Ignore the following file patterns when completing files.
vim.opt.wildignore:append {
  '.hg',
  '.git',
  '.svn',
  '*.aux',
  '*.out',
  '*.toc',
  '*.jpg',
  '*.bmp',
  '*.gif',
  '*.png',
  '*.jpeg',
  '*.o',
  '*.obj',
  '*.exe',
  '*.dll',
  '*.manifest',
  '*.so',
  '*.dylib',
  '*.class',
  '*.beam',
  '*.spl',
  '*.sw?',
  '*~',
  '._*',
  '.DS_Store',
  '*.luac',
  '*.pyc',
  '*.rbc',
  '*.rbo',
  '*.gem',
  '*.zip',
  '*.tar.gz',
  '*.tar.bz2',
  '*.rar',
  '*.tar.xz',
  '*/vendor/gems/**',
  '*/vendor/cache/**',
  '*/.bundle/**',
  '*/.sass-cache/**',
  '*/_build/**',
  '*/node_modules/**',
}

-- Turn on the window title and make it a little more useful.
vim.opt.title = true
vim.opt.titlelen = 95

-- The the title to FILE FLAGS (CWD) - SERVER
--
-- - FILE: The minimum path to the file relative to the CWD.
-- - FLAGS: Modified and/or preview state of the file (may be empty)
-- - CWD: The (possibly) truncated current directory, relative to $HOME.
-- - SERVER: The current Vim server name (or VIM)
vim.opt.titlestring = '%{expand("%:p:~:.")} %(%m%w%) %<'
  .. '(%{printf("%.*S", &columns - len(expand("%:p:~:."))'
  .. ', fnamemodify(getcwd(), ":~"))}) - %{v:servername}'

-- Folding settings.
vim.opt.foldenable = false
-- vim.opt.foldmethod = 'marker'
-- vim.opt.foldcolumn = 1
-- vim.opt.commentstring = '# %s'

vim.opt.mouse = 'a'

-- -- Prefer ripgrep, pt or ag over grep for :grep.
local grepper
if vim.fn.executable('rg') then
  grepper = 'rg --line-number --color never --no-heading $*'
elseif vim.fn.executable('ag') then
  grepper = 'ag --nogroup --nocolor $*'
else
  grepper = 'grep -inH $*'
end
vim.opt.grepprg = grepper

vim.opt.encoding = 'utf-8'

-- Add gems.tags to files searched for tags.
vim.opt.tags:remove { './tags', './tags;' }
vim.opt.tags:prepend { './tags;' }
vim.opt.tags:append { 'gems.tags' }
vim.opt.showfulltag = true

vim.g.mapleader = [[ ]]

-- Set linebreaking and wrapping rules.
if vim.fn.has('linebreak') then
  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.showbreak = '↪'
  vim.opt.whichwrap = 'bshl<>~[]'

  if vim.fn.exists('+breakindent') then vim.opt.breakindent = true end
else
  vim.opt.wrap = false
end

vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.opt.fillchars = { vert = '│', fold = '·', foldsep = '│' }
vim.opt.shada:prepend { '!' }

require('config.defaults.' .. vim.fn['hz#platform']())

vim.g.markdown_syntax_conceal = 0
vim.g.markdown_minlines = 100

vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.markdown_fenced_languages = {
  'bash=sh',
  'c++=cpp',
  'css',
  'elixir',
  'fish',
  'js=javascript',
  'python',
  'ruby',
  'viml=vim',
  'xml',
}

vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_json_frontmatter = 1
vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_no_extensions_in_markdown = 1
vim.g.vim_markdown_strikethrough = 1
vim.g.vim_markdown_toc_autofit = 1
vim.g.vim_markdown_toml_frontmatter = 1

vim.g.netrw_nogx = 1 -- disable netrw's gx mapping.
