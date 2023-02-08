local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				message = {
					enabled = true,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			format = {
				-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
				-- view: (default is cmdline view)
				-- opts: any options passed to the view
				-- icon_hl_group: optional hl_group for the icon
				-- title: set to anything or empty string to hide
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = "🔍 ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = "🔍 ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
				input = {}, -- Used by input()
				-- lua = false, -- to disable a format, set to `false`
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"Shatur/neovim-ayu",
		lazy = false,
		priority = 1000,
	},
	"airblade/vim-rooter",
	"ellisonleao/gruvbox.nvim",
	"glepnir/zephyr-nvim",
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm",
		},
	},
	-- fzf
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"junegunn/vim-easy-align",
	{
		"jcdickinson/wpm.nvim",
		config = function()
			require("wpm").setup({})
		end,
	},
	-- lualine with config
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		lazy = false,
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					--[[ theme = chooseRandomTheme(), ]]
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true, -- need set true
					refresh = {
						statusline = 1000,
						tablinetabline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						"mode",
					},
					lualine_b = { "branch", "diff", "diagnostics" },
					-- show the current filename and session name,
					lualine_c = { "filename", require("auto-session-library").current_session_name },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress", require("wpm").wpm, require("wpm").historic_graph },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {
					lualine_a = { "buffers" },
					lualine_b = { "branch" },
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "tabs" },
				},
				extensions = { "fzf", "neo-tree", "fugitive" },
			})
		end,
	},
	-- tabline with config
	{
		"kdheepak/tabline.nvim",
		lazy = false,
		config = function()
			require("tabline").setup({
				-- Defaults configuration options
				enable = true,
				options = {
					-- If lualine is installed tabline will use separators configured in lualine by default.
					-- These options can be used to override those settings.
					section_separators = { "", "" },
					component_separators = { "", "" },
					max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
					show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
					show_devicons = true, -- this shows devicons in buffer section
					show_bufnr = false, -- this appends [bufnr] to buffer section,
					show_filename_only = false, -- shows base filename only instead of relative path in filename
					modified_icon = "+ ", -- change the default modified icon
					modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
					show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
				},
			})
			vim.cmd([[
        set guioptions-=e " Use showtabline in gui vim
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]])
			vim.notify("init tabline", "info")
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		dependencies = { "antoinemadec/FixCursorHold.nvim" },
	},
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					preview = {
						mime_hook = function(filepath, bufnr, opts)
							local is_image = function(filepath)
								local image_extensions = { "png", "jpg", "jpeg" } -- Supported image formats
								local split_path = vim.split(filepath:lower(), ".", { plain = true })
								local extension = split_path[#split_path]
								return vim.tbl_contains(image_extensions, extension)
							end
							if is_image(filepath) then
								vim.notify("image dectected", "info")
								local term = vim.api.nvim_open_term(bufnr, {})
								local function send_output(_, data, _)
									for _, d in ipairs(data) do
										vim.api.nvim_chan_send(term, d .. "\r\n")
									end
								end

								vim.fn.jobstart({
									"catimg",
									filepath, -- Terminal image viewer command
								}, { on_stdout = send_output, stdout_buffered = true })
							else
								vim.notify("image not dectected", "error")
								require("telescope.previewers.utils").set_preview_message(
									bufnr,
									opts.winid,
									"Img Binary cannot be previewed"
								)
							end
						end,
					},
					-- Default configuration for telescope goes here:
					-- config_key = value,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim", -- add this value
					},
					--[[ buffer_previewer_maker = new_maker, ]]
					-- buffer_previewer_maker = hologram.buffer_previewer_maker,
					file_ignore_patterns = {
						"node_modules",
						"build",
						"dist",
						"yarn.lock",
						"core",
						".gitignore",
						".ignore",
						".rgignore",
					},
					mappings = {
						i = {
							-- map actions.which_key to <C-h> (default: <C-/>)
							-- actions.which_key shows the mappings for your picker,
							-- e.g. git_{create, delete, ...}_branch for the git_branches picker
							["<C-h>"] = "which_key",
							["<C-u>"] = false,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files" },
						mappings = {
							n = {
								["cd"] = function(prompt_bufnr)
									local selection = require("telescope.actions.state").get_selected_entry()
									local dir = vim.fn.fnamemodify(selection.path, ":p:h")
									require("telescope.actions").close(prompt_bufnr)
									-- Depending on what you want put `cd`, `lcd`, `tcd`
									vim.cmd(string.format("silent lcd %s", dir))
								end,
							},
						},
					},
				},
				extensions = {
					file_browser = {
						-- theme = "ivy",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {
							["i"] = {
								-- your custom insert mode mappings
							},
							["n"] = {
								-- your custom normal mode mappings
							},
						},
					},
					media_files = {
						-- filetypes whitelist
						-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
						filetypes = { "png", "webp", "jpg", "jpeg" },
						find_cmd = "rg", -- find command (defaults to `fd`)
					},
					-- Your extension configuration goes here:
					-- extension_name = {
					--   extension_config_key = value,
					-- }
					-- please take a look at the readme of the extension you want to configure
				},
			})
		end,
	},
	"nvim-telescope/telescope-file-browser.nvim",
	{
		"rmagatti/session-lens",
		dependencies = {
			"rmagatti/auto-session",
			"nvim-telescope/telescope.nvim",
		},
	},
	-- lsp-zero
	-- lsp related
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"lukas-reineke/lsp-format.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind-nvim",
		},
		config = function()
			local lsp = require("lsp-zero")
			lsp.preset("recommended")
			lsp.on_attach(function(client, bufnr)
				require("lsp-format").on_attach(client, bufnr)
			end)
			lsp.nvim_workspace()
			lsp.setup()
			vim.diagnostic.config({ virtual_text = true })
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		keys = {
			{ "gpr", "<cmd>Lspsaga lsp_finder<CR>", "n" },
			{ "<leader>lr", "<cmd>Lspsaga rename<CR>" },
			{ "<leader>la", "<cmd>Lspsaga code_action<CR>", "n, v" },
			{ "gpd", "<cmd>Lspsaga peek_definition<CR>" },
			{ "<leader>lsd", "<cmd>Lspsaga show_line_diagnostics<CR>" },
			{ "<leader>so", "<cmd>Lspsaga outline<CR>" },
			{ "K", "<cmd>Lspsaga hover_doc<CR>" },
		},
	},
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "vim", "lua", "rust", "vue", "typescript", "javascript", "html", "css", "help" },
				highlight = { enable = true },
				indent = {
					enable = true,
					disable = { "yaml" },
				},
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
		end,
	},
	-- neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	{ "akinsho/toggleterm.nvim", opts = { open_mapping = [[<c-\>]], direction = "tab" } },
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	},
	"numToStr/Comment.nvim",
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		},
	},
	{
		"rmagatti/session-lens",
		dependencies = {
			"rmagatti/auto-session",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},
	"jose-elias-alvarez/null-ls.nvim",
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				signcolumn = true,
				current_line_blame = true,
			})
		end,
	},
	{
		"zbirenbaum/neodim",
		opts = {
			alpha = 0.5,
			hide = {
				virtual_text = true,
				signs = true,
				underline = true,
			},
		},
		ft = { "vue", "javascript", "typescript", "svelte" },
	},
	{ "goolord/alpha-nvim", event = "VimEnter" },
	{
		"declancm/cinnamon.nvim",
		enabled = true,
		lazy = false,
		config = function()
			require("cinnamon").setup({
				-- KEYMAPS:
				default_keymaps = true, -- Create default keymaps.
				extra_keymaps = false, -- Create extra keymaps.
				extended_keymaps = false, -- Create extended keymaps.
				override_keymaps = false, -- The plugin keymaps will override any existing keymaps.
				-- OPTIONS:
				always_scroll = false, -- Scroll the cursor even when the window hasn't scrolled.
			})
		end,
	},
	"petertriho/nvim-scrollbar",
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		-- config = function()
		-- 	vim.opt.termguicolors = true
		-- 	vim.opt.list = true
		-- 	vim.opt.listchars:append("space:⋅")
		-- 	vim.opt.listchars:append("eol:↴")
		-- 	require("indent_blankline").setup({
		-- 		space_char_blankline = " ",
		-- 		show_current_context = true,
		-- 		show_current_context_start = true,
		-- 		char_highlight_list = {
		-- 			"IndentBlanklineIndent1",
		-- 			"IndentBlanklineIndent2",
		-- 			"IndentBlanklineIndent3",
		-- 			"IndentBlanklineIndent4",
		-- 			"IndentBlanklineIndent5",
		-- 			"IndentBlanklineIndent6",
		-- 		},
		-- 		show_end_of_line = true,
		-- 	})
		-- end,
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},
	-- active indent guide and indent text objects
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "BufReadPre",
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			autotag = {
				enable = true,
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
					java = false,
				},
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0, -- Offset from pattern match
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
		lazy = false,
	},
	"mattn/emmet-vim",
	{
		"norcalli/nvim-colorizer.lua",
		opts = {
			"*",
			css = { rgb_fn = true },
			html = { names = false },
		},
	},
	{ "easymotion/vim-easymotion", event = "VeryLazy" },
	"wellle/context.vim",
	"rmagatti/goto-preview",
	"tpope/vim-surround",
	"AndrewRadev/tagalong.vim",
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"koenverburg/peepsight.nvim",
		event = "VeryLazy",
		config = function()
			require("peepsight").setup({
				-- go
				"function_declaration",
				"method_declaration",
				"func_literal",

				-- typescript
				"class_declaration",
				"method_definition",
				"arrow_function",
				"function_declaration",
				"generator_function_declaration",
			})
		end,
	},
	{ "echasnovski/mini.nvim", version = false },
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		opts = function()
			require("treesj").setup({ --[[ your config ]]
			})
		end,
	},
	{
		"leafOfTree/vim-svelte-plugin",
		lazy = false,
		ft = { "svelte" },
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
})
