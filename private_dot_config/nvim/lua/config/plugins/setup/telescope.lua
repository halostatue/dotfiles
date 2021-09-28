local map = require('config.utils').map

local silent = { silent = true }

-- Navigate buffers and repos
map('n', '<leader>pe', [[<cmd>Telescope find_files<cr>]], silent)
map('n', '<leader>pb', [[<cmd>Telescope buffers<cr>]], silent)
map('n', '<leader>pf', [[<cmd>Telescope frecency<cr>]], silent)
map('n', '<leader>pg', [[<cmd>Telescope live_grep<cr>]], silent)
map('n', '<leader>pG', [[<cmd>Telescope grep_string<cr>]], silent)
map('n', '<leader>ph', [[<cmd>Telescope help_tags<cr>]], silent)
map('n', '<leader>p.', [[<cmd>Telescope file_browser<cr>]], silent)
map('n', '<leader>pt', [[<cmd>Telescope treesitter<cr>]], silent)
map('n', '<leader>gf', [[<cmd>Telescope git_files<cr>]], silent)
map('n', '<leader>gc', [[<cmd>Telescope git_commits<cr>]], silent)
map('n', '<leader>bg', [[<cmd>Telescope git_bcommits<cr>]], silent)
map('n', '<leader>gb', [[<cmd>Telescope git_branches<cr>]], silent)
map('n', '<leader>gs', [[<cmd>Telescope git_status<cr>]], silent)
map('n', '<leader>gS', [[<cmd>Telescope git_stash<cr>]], silent)
map('n', '<leader>tt', [[<cmd>Telescope builtin<cr>]], silent)
