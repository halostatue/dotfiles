return {
  -- Languages
  --
  -- Polyglot provides syntax and indentation for the following syntaxes I
  -- care about: ansible, applescript, C/C++, Crystal, CSV, Cucumber/Gherkin,
  -- Dart, D, Dockerfile / Docker-Compose, Elixir, Elm, Erlang, Fish, Git,
  -- Gleam, GraphQL, HTML, JavaScript, jq, JSON, Julia, Kotlin, Lua, Markdown,
  -- Nim, Objective-C, Perl, PLpgSQL, PlantUML, Pony, Python, Raku, RAML,
  -- Reason, Ruby, Rust, SCSS, Shell, Svelte, SVG, Swift, Terraform, TOML,
  -- Vue, XML, and Zig.
  { -- https://github.com/sheerun/vim-polyglot
    'sheerun/vim-polyglot',
    event = { 'VeryLazy' },
    init = function()
      -- vim-polyglot: Disable languages or add-ins.
      -- - <name> disables the plugin from Polyglot entirely.
      -- - <name>.plugin disables the plugin except for filetype detection.
      -- - autoindent disables vim-sleuth like heuristics
      -- - sensible disables a copy of vim-sensible
      -- - ftdetect disables filetype detection
      vim.g.polyglot_disabled = { 'autoindent', 'bzl', 'go', 'cue', 'sensible' }
    end,
  },
  {
    'fatih/vim-go', -- go: https://github.com/fatih/vim-go
    ft = 'go',
    build = ':GoInstallBinaries',
  },
  {
    'amadeus/vim-mjml', -- MJML: https://github.com/amadeus/vim-mjml
    ft = 'mjml',
  },
  {
    'dmix/elvish.vim', -- Elvish shell: https://github.com/dmix/elvish.vim
    ft = 'elvish',
  },
  {
    'browserslist/vim-browserslist', -- Browserslist constraints: https://github.com/browserslist/vim-browserslist
    ft = 'browserslist',
  },
  {
    'janet-lang/janet.vim', -- Janet: https://github.com/janet-lang/janet.vim
    ft = 'janet',
  },
  {
    'evanleck/vim-svelte', -- Svelte 3: https://github.com/evanleck/vim-svelte
    ft = 'svelte',
    init = function()
      vim.g.vim_svelte_plugin_use_typescript = 1
      vim.g.vim_svelte_plugin_use_sass = 1
      vim.g.svelte_indent_script = 0
      vim.g.svelte_indent_style = 0
      vim.g.svelte_preprocessors = { 'typescript', 'scss' }
    end,
  },
  {
    'jlcrochet/vim-rbs', -- Ruby signatures: https://github.com/jlcrochet/vim-rbs
    ft = 'rbs',
  },
  {
    'hofstadter-io/cue.vim', -- Cue language: https://github.com/hofstadter-io/cue.vim
    ft = 'cue',
  },
  {
    'yasuhiroki/github-actions-yaml.vim', -- Github Actions (YAML): https://github.com/yasuhiroki/github-actions-yaml.vim
    ft = 'yaml',
  },
  { -- https://github.com/norcalli/nvim-colorizer.lua replaces https://github.com/gko/vim-coloresque
    'norcalli/nvim-colorizer.lua',
    event = { 'VeryLazy' },
    config = true,
  },
  { -- https://github.com/tpope/vim-apathy
    'tpope/vim-apathy',
    event = { 'VeryLazy' },
  },
  { -- https://github.com/lambdalisue/vim-backslash
    'lambdalisue/vim-backslash',
    ft = 'vim',
  },
  -- Language Utilities
  -- {
  --   'sbdchd/neoformat', -- https://github.com/sbdchd/neoformat
  --   config = function()
  --     vim.g.neoformat_enabled_c = { 'clangformat' } -- C: {"uncrustify", "clangformat", "astyle"}
  --     vim.g.neoformat_enabled_cpp = { 'clangformat' } -- C++: {"uncrustify", "clangformat", "astyle"}
  --     vim.g.neoformat_enabled_cs = { 'clangformat' } -- C#: {"uncrustify", "astyle", "clangformat"}
  --     vim.g.neoformat_enabled_d = { 'dfmt' } -- D: ["uncrustify", "dfmt"]
  --     vim.g.neoformat_enabled_html = { 'prettierd', 'prettier', 'prettydiff' } -- HTML: {"htmlbeautify", "prettierd", "prettier", "tidy", "prettydiff"}
  --     vim.g.neoformat_enabled_java = { 'clangformat', 'prettierd', 'prettier' } -- Java: {"uncrustify", "astyle", "clangformat", "prettierd", "prettier"}
  --     vim.g.neoformat_enabled_javascript = {
  --       'standard',
  --       'semistandard',
  --       'prettierd',
  --       'prettier',
  --       'denofmt',
  --     } -- JavaScript: {"jsbeautify", "standard", "semistandard", "prettierd", "prettier", "prettydiff", "clangformat", "esformatter", "prettiereslint", "eslint_d", "denofmt"}
  --     vim.g.neoformat_enabled_javascriptreact = {
  --       'standard',
  --       'semistandard',
  --       'prettierd',
  --       'prettier',
  --       'denofmt',
  --     } -- Javascript/React: {"jsbeautify", "standard", "semistandard", "prettierd", "prettier", "prettydiff", "esformatter", "prettiereslint", "eslint_d", "denofmt"}
  --     vim.g.neoformat_enabled_json = { 'prettierd', 'prettier', 'jq', 'denofmt' } -- JSON:  {"jsbeautify", "prettydiff", "prettierd", "prettier", "jq", "fixjson", "denofmt"}
  --     vim.g.neoformat_enabled_lua = { 'stylua', 'luaformatter', 'lua-fmt', 'lua-format' }
  --     vim.g.neoformat_enabled_markdown = { 'prettierd', 'prettier', 'denofmt' } -- Markdown: {"remark", "prettierd", "prettier", "denofmt"}
  --     vim.g.neoformat_enabled_objc = { 'clangformat' } -- Objective-C: ["uncrustify", "clangformat", "astyle"]
  --     vim.g.neoformat_enabled_ruby = { 'rufo', 'rubybeautify', 'standard', 'rubocop' } -- Ruby: ["rufo", "rubybeautify", "rubocop"]
  --     vim.g.neoformat_enabled_typescript = { 'prettierd', 'prettier', 'denofmt' } -- Typescript: {"tsfmt", "prettierd", "prettier", "prettiereslint", "tslint", "eslint_d", "clangformat", "denofmt"}
  --     vim.g.neoformat_enabled_typescriptreact = { 'prettierd', 'prettier', 'denofmt' } -- Typescript/React: {"tsfmt", "prettierd", "prettier", "prettiereslint", "tslint", "eslint_d", "clangformat", "denofmt"}
  --     vim.g.neoformat_enabled_xhtml = { 'prettydiff' } -- XHTML: ["tidy", "prettydiff"]
  --     vim.g.neoformat_enabled_xml = { 'prettierd', 'prettier' } -- XML: {"tidy", "prettydiff", "prettierd", "prettier"}

  --     -- vim.g.neoformat_basic_format_align = 1 -- Enable alignment
  --     -- vim.g.neoformat_basic_format_retab = 1 -- Enable tab to spaces conversion
  --     -- vim.g.neoformat_basic_format_trim = 1 -- Enable trimmming of trailing whitespace
  --     vim.g.neoformat_try_node_exe = 1 -- Try a formatter in `node_modules/.bin`

  --     vim.g.neoformat_ruby_standard = {
  --       exe = 'standardrb',
  --       args = {
  --         '--auto-correct',
  --         '--stdin',
  --         '"%:p"',
  --         '2>/dev/null',
  --         '|',
  --         "sed '1,/^====================$/d'",
  --       },
  --       stdin = 1,
  --       stderr = 1,
  --     }

  --     vim.api.nvim_create_autocmd('BufWritePre', {
  --       group = vim.api.nvim_create_augroup('neoformat_config', {}),
  --       pattern = '*',
  --       command = 'try | undojoin | Neoformat | catch /^Vim\\%((\\a\\+)\\)\\=:E790/ | finally | silent Neoformat | endtry',
  --     })
  --   end,
  -- },
}
