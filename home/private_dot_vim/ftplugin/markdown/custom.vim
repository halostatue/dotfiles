vim9script

# Configure Vim's builtin markdown configuration.
g:markdown_fenced_languages = [
  'bash=sh',
  'console=sh',
  'c++=cpp',
  'css',
  'diff',
  'elixir',
  'erlang',
  'fish',
  'go',
  'html',
  'javascript',
  'js=javascript',
  'python',
  'ruby',
  'rust',
  'scss',
  'sql',
  'vim',
  'viml=vim',
  'ts=typescript',
  'typescript',
  'xml',
  'zsh=sh',
]
g:markdown_syntax_conceal = 0
g:markdown_minlines = 100
g:markdown_yaml_head = true

# In case I decide to use preservim/vim-markdown
g:vim_markdown_conceal = false
g:vim_markdown_conceal_code_blocks = false
g:vim_markdown_fenced_languages = deepcopy(g:markdown_fenced_languages)
g:vim_markdown_frontmatter = true
g:vim_markdown_folding_disabled = true
g:vim_markdown_json_frontmatter = true
g:vim_markdown_no_default_key_mappings = true
g:vim_markdown_no_extensions_in_markdown = true
g:vim_markdown_strikethrough = true
g:vim_markdown_toc_autofit = true
g:vim_markdown_toml_frontmatter = true

