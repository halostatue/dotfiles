vim.g.vimsyn_embed = 'lmpPrt'
vim.g.endwise_abbreviations = 1

-- Load on demand. Yanked from junegunn/vim-plug.
-- function! s:on_demand(cmd, names) abort
--   execute printf(
--         \ 'command! -nargs=* -range -bang -complete=file %s call s:demand_run(%s, "<bang>", <line1>, <line2>, <q-args>, %s)',
--         \ a:cmd, string(a:cmd), string(a:names)
--         \ )
-- endfunction

-- function! s:demand_run(cmd, bang, l1, l2, args, names) abort
--   for l:name in a:names | packadd l:name | endfor
--   execute printf('%s%s%s %s', (a:l1 == a:l2 ? '' : (a:l1.','.a:l2)), a:cmd, a:bang, a:args)
-- endfunction

-- This is general configuration of packages. Some configuration is present in config/packages/before.vim; these
-- configurations are required to prevent certain defaults from being set.

vim.cmd [[
noremap n nzz
noremap N Nzz

]]

-- Utility
vim.g.direnv_silent_load = 1
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'fern://.*' }
-- vim.g.dadbod_manage_dbext = 1

-- call s:on_demand('Vitalize', ['vital.vim'])
-- call s:on_demand('RainbowParentheses')

-- Project navigation
-- https://github.com/tpope/vim-projectionist

-- Colorscheme options
vim.g.deepspace_italics = 1
vim.g.quantum_italics = 1
vim.g.quantum_black = 1

-- vim.g.badwolf_darkgutter = 1
-- vim.g.badwolf_css_props_highlight = 1

vim.g.neotrix_italicize_comments = 1
vim.g.neotrix_italicize_strings = 1
vim.g.neotrax_dark_contrast = 'galaxy' -- galaxy_hard, retro, retro_hard

-- vim.g.spacegray_underline_search = 1
vim.g.spacegray_use_italics = 1
-- vim.g.spacegray_low_contrast = 0

vim.g.falcon_italic = 1
vim.g.falcon_bold = 1

vim.g.ayucolor = "dark"

-- https://github.com/prabirshrestha/vim-lsp
-- https://github.com/mattn/vim-lsp-settings
-- https://github.com/prabirshrestha/asyncomplete.vim
-- https://github.com/prabirshrestha/asyncomplete-lsp.vim
-- https://github.com/hrsh7th/vim-vsnip-integ
-- https://github.com/mattn/vim-lexiv - cohama/lexima.vim?

if vim.fn.exists(':TagbarToggle') == 2 and vim.fn.mapcheck('<F8>', 'n') == '' then
  vim.g.tagbar_compact = 1
  vim.cmd 'nnoremap <silent> <F8> :TagbarToggle<CR>'
end

vim.g.ragtag_global_maps = 1

-- vim.g.thesaurus_path =
-- call hz#mkpath(hz#xdg_base('data', 'thesaurus'), v:true)

-- https://github.com/reedes/vim-pencil
-- https://github.com/reedes/vim-lexical
-- opt - https://github.com/junegunn/goyo.vim
-- opt - https://github.com/junegunn/limelight.vim
-- opt - https://github.com/vimwiki/vimwiki

-- opt - https://github.com/wellle/targets.vim
-- https://github.com/rhysd/clever-f.vim
-- https://github.com/edkolev/erlang-motions.vim
-- opt - https://github.com/mg979/vim-visual-multi
-- https://github.com/christoomey/vim-conflicted
-- https://github.com/rhysd/conflict-marker.vim
--
-- https://github.com/tpope/vim-dispatch
-- https://github.com/hauleth/asyncdo.vim
-- https://github.com/romainl/vim-qf
-- https://github.com/romainl/vim-qlist
-- https://github.com/Olical/vim-enmasse
-- https://github.com/igemnace/vim-makery
-- off - https://github.com/AndrewRadev/qftools.vim
-- off- https://github.com/AndrewRadev/linediff.vim
--
-- https://github.com/t9md/vim-choosewin
-- https://github.com/dhruvasagar/vim-zoom
--
-- Optional debug / test stuff {{{
-- opt - https://github.com/Vimjas/vint
-- opt - https://github.com/puremourning/vimspector
-- https://github.com/vim-test/vim-test
-- opt - https://github.com/junegunn/vader.vim
-- opt - https://github.com/tpope/vim-scriptease
-- opt - https://github.com/tweekmonster/exception.vim
-- opt - https://github.com/tweekmonster/helpful.vim
-- opt - https://github.com/mhinz/vim-lookup
-- opt - https://github.com/thinca/vim-themis
--
-- opt - https://github.com/mattn/gist-vim
-- opt - https://github.com/mbbill/undotree
--
-- Loaded only for specific filetypes on demand. Requires autocommands below.
-- opt - for js - https://github.com/kristijanhusak/vim-js-file-import
-- opt - for go - https://github.com/fatih/vim-go

-- ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
vim.g.markdown_fenced_languages = {
  'bash=sh', 'c++=cpp', 'css', 'elixir', 'fish', 'js=javascript', 'python',
  'ruby', 'viml=vim', 'xml'
}

vim.g.markdown_syntax_conceal = 0
vim.g.markdown_minlines = 100

vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_fenced_languages = { 'html', 'python', 'bash=sh' }
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_json_frontmatter = 1
vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_no_extensions_in_markdown = 1
vim.g.vim_markdown_strikethrough = 1
vim.g.vim_markdown_toc_autofit = 1
vim.g.vim_markdown_toml_frontmatter = 1

vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.html.eex,*.vue'
vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx'
vim.g.closetag_filetypes = 'html,xhtml,phtml,vue,eex.html'
vim.g.closetag_xhtml_filetypes = 'xhtml,jsx'
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_regions = { ['typescript.tsx'] = 'jsxRegion,tsxRegion', ['javascript.jsx']= 'jsxRegion' }
vim.g.closetag_shortcut = '>'
vim.g.closetag_close_shortcut = '<leader>>'

vim.g.tagalong_additional_filetypes = { 'eex.html', 'vue', 'jsx' }

vim.g.pencil_neutral_headings = 1
vim.g.pencil_gutter_color = 1
vim.g.pencil_terminal_italics = 1
vim.g['pencil#conceallevel'] = 0
