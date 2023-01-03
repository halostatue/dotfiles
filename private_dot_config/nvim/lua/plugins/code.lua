local Snippets = {}

function Snippets:new(plugin)
	plugin = plugin or {}
	setmetatable(plugin, self)
	self.__index = self
	return plugin
end

function Snippets:spec()
	if self.plugin == "luasnip" then
		return { -- https://github.com/saadparwaiz1/cmp_luasnip
			"saadparwaiz1/cmp_luasnip",
			dependencies = {
				{ -- https://github.com/L3MON4D3/LuaSnip
					"L3MON4D3/LuaSnip",
				},
			},
		}
	elseif self.plugin == "vsnip" then
		return { -- https://github.com/hrsh7th/cmp-vsnip
			"hrsh7th/vim-vsnip",
			dependencies = {
				{ -- https://github.com/hrsh7th/cmp-vsnip
					"hrsh7th/cmp-vsnip",
				},
			},
		}
	elseif self.plugin == "ultisnips" then
		return { -- https://github.com/quangnguyen30192/cmp-nvim-ultisnips
			"quangnguyen30192/cmp-nvim-ultisnips",
			dependencies = {
				{ -- https://github.com/SirVer/ultisnips
					"SirVer/ultisnips",
				},
			},
		}
	elseif self.plugin == "snippy" then
		return { -- https://github.com/dcampos/cmp-snippy
			"dcampos/cmp-snippy",
			dependencies = {
				{ -- https://github.com/dcampos/nvim-snippy
					"dcampos/nvim-snippy",
				},
			},
		}
	end
end

function Snippets:expander()
	if self.plugin == "luasnip" then
		return function(args)
			require("luasnip").lsp_expand(args.body)
		end
	elseif self.plugin == "vsnip" then
		return function(args)
			vim.call("vsnip#anonymous", args.body)
		end
	elseif self.plugin == "ultisnips" then
		return function(args)
			vim.call("UltiSnips#Anon", args.body)
		end
	elseif self.plugin == "snippy" then
		return function(args)
			require("snippy").expand_snippet(args.body)
		end
	end
end

function Snippets:source()
	if self.plugin == "luasnip" or self.plugin == "vsnip" or self.plugin == "ultisnips" or self.plugin == "snippy" then
		return { name = self.plugin }
	end
end

local snippets_provider = Snippets:new({ plugin = "luasnip" })

return {
	{ -- https://github.com/Shougo/echodoc.vim
		"Shougo/echodoc.vim",
		event = { "VeryLazy" },
		init = function()
			vim.g["echodoc#enable_at_startup"] = true
			vim.g["echodoc#type"] = "floating" -- virtual, popup

			if vim.g["echodoc#type"] == "floating" then
				vim.cmd("highlight link EchoDocFloat Pmenu")
				vim.g["echodoc#floating_config"] = { border = "single" }
			elseif vim.g["echodoc#type"] == "popup" then
				vim.cmd("highlight link EchoDocPopup Pmenu")
			end
		end,
	},
	{ --  https://github.com/hrsh7th/nvim-cmp
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			{ -- https://github.com/hrsh7th/cmp-buffer
				"hrsh7th/cmp-buffer",
			},
			{ -- https://github.com/hrsh7th/cmp-cmdline
				"hrsh7th/cmp-cmdline",
			},
			{ -- https://github.com/hrsh7th/cmp-nvim-lsp
				"hrsh7th/cmp-nvim-lsp",
			},
			{ -- https://github.com/hrsh7th/cmp-nvim-lua
				"hrsh7th/cmp-nvim-lua",
			},
			{ -- https://github.com/hrsh7th/cmp-path
				"hrsh7th/cmp-path",
			},
			{ -- https://github.com/kristijanhusak/vim-dadbod-completion
				"kristijanhusak/vim-dadbod-completion",
			},
			snippets_provider:spec(),
		},
		config = function()
			local cmp = require("cmp")
			local termcode = require("config.utils").termcode

			local function check_backspace()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
			end

			cmp.setup({
				snippet = { expand = snippets_provider:expander() },
				sources = {
					{ name = "nvim_lsp" },
					snippets_provider:source(),
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
				},
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, { { name = "buffer" } }),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(
				{ "/", "?" },
				{ mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } }
			)

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})

			-- -- Set up lspconfig.
			-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
			-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {capabilities = capabilities}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					require("cmp").setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
						},
					})
				end,
			})
		end,
	},
	{ -- https://github.com/mattn/vim-lexiv
		"mattn/vim-lexiv",
		event = { "InsertEnter" },
	},
	{ -- https://github.com/preservim/tagbar
		"preservim/tagbar",
		cmd = "TagbarToggle",
		keys = {
			{ "<F8>", "<cmd>TagbarToggle<CR>", silent = true },
		},
		config = function()
			vim.g.tagbar_compact = 1
		end,
	},
	{ -- https://github.com/ludovicchabant/vim-gutentags
		"ludovicchabant/vim-gutentags",
		event = { "BufNewFile", "BufReadPost" },
		init = function()
			vim.g.gutentags_cache_dir = vim.call("hz#xdg_base", "cache", "gutentags")
		end,
	},
	{ -- https://github.com/tommcdo/vim-exchange
		"tommcdo/vim-exchange",
		event = { "VeryLazy" },
	},
	{ -- https://github.com/tpope/vim-commentary
		"tpope/vim-commentary",
		event = { "VeryLazy" },
	},
	{ -- https://github.com/tpope/vim-endwise
		"tpope/vim-endwise",
		event = { "InsertEnter" },
		init = function()
			vim.g.endwise_abbreviations = 1
		end,
	},
	{ -- https://github.com/tpope/vim-ragtag
		"tpope/vim-ragtag",
		event = { "InsertEnter" },
		init = function()
			vim.g.ragtag_global_maps = 1
		end,
	},
	{ -- https://github.com/alvan/vim-closetag
		"alvan/vim-closetag",
		event = { "InsertEnter" },
		init = function()
			vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.eex,*.vue"
			vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx"
			vim.g.closetag_filetypes = "html,xhtml,phtml,vue,eex.html"
			vim.g.closetag_xhtml_filetypes = "xhtml,jsx"
			vim.g.closetag_emptyTags_caseSensitive = 1
			vim.g.closetag_regions = {
				["typescript.tsx"] = "jsxRegion,tsxRegion",
				["javascript.jsx"] = "jsxRegion",
			}
			vim.g.closetag_shortcut = ">"
			vim.g.closetag_close_shortcut = "<leader>>"
		end,
	},
	{ -- https://github.com/pechorin/any-jump.vim
		"pechorin/any-jump.vim",
		event = { "VeryLazy" },
	},
	{ -- https://github.com/AndrewRadev/multichange.vim
		"AndrewRadev/multichange.vim",
		event = { "VeryLazy" },
		init = function()
			vim.g.multichange_mapping = "sm"
			vim.g.multichange_motion_mapping = "m"
		end,
	},
	{ -- https://github.com/machakann/vim-swap
		"machakann/vim-swap",
		event = { "VeryLazy" },
		init = function()
			vim.g.swap_no_default_key_mappings = 1
		end,
		config = function()
			vim.keymap.set("n", "g(", "<Plug>(swap-interactive)")
			vim.keymap.set("x", "g(", "<Plug>(swap-interactive)")
			vim.keymap.set("n", "g<", "<Plug>(swap-prev)")
			vim.keymap.set("n", "g>", "<Plug>(swap-next)")
			vim.keymap.set("o", "i,", "<Plug>(swap-textobject-i)")
			vim.keymap.set("x", "i,", "<Plug>(swap-textobject-i)")
			vim.keymap.set("o", "a,", "<Plug>(swap-textobject-a)")
			vim.keymap.set("x", "a,", "<Plug>(swap-textobject-a)")
		end,
	},
	{ -- https://github.com/AndrewRadev/tagalong.vim
		"AndrewRadev/tagalong.vim",
		event = { "VeryLazy" },
		init = function()
			vim.g.tagalong_additional_filetypes = { "eex.html", "jsx", "svelte", "tsx", "vue" }
		end,
	},
	{ -- https://github.com/AndrewRadev/splitjoin.vim
		"AndrewRadev/splitjoin.vim",
		cmd = { "SplitjoinJoin", "SplitjoinSplit" },
		ft = {
			"c",
			"clojure",
			"coffee",
			"cs",
			"css",
			"elixir",
			"elm",
			"eruby",
			"go",
			"haml",
			"handlebars",
			"html",
			"htmldjango",
			"java",
			"javascript",
			"javascriptreact",
			"json",
			"jsx",
			"less",
			"lua",
			"perl",
			"php",
			"python",
			"r",
			"ruby",
			"rust",
			"scss",
			"sh",
			"svelte",
			"tex",
			"tsx",
			"typescript",
			"typescriptreact",
			"vim",
			"vue",
			"xml",
			"yaml",
			"zsh",
		},
		init = function()
			vim.g.splitjoin_split_mapping = "<Leader>S"
			vim.g.splitjoin_join_mapping = "<Leader>J"
			vim.g.splitjoin_quiet = true
			vim.g.splitjoin_ruby_do_block_split = false
			vim.g.splitjoin_python_brackets_on_separate_lines = true
			vim.g.splitjoin_html_attributes_bracket_on_new_line = true
			vim.g.splitjoin_java_argument_split_first_newline = true
			vim.g.splitjoin_java_argument_split_last_newline = true
		end,
	},
}
