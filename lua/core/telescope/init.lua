local telescope = require("telescope")
local actions = require("telescope.actions")
local hologram = require("core.telescope.hologram")

buffer_previewer.teardown = hologram.teardown

telescope.setup({
	defaults = {
		buffer_previewer_maker = hologram.buffer_previewer_maker,
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
})

require("telescope").load_extension("session-lens")
require("telescope").load_extension("notify")
-- require("telescope").load_extension("media_files")
require("telescope").load_extension("file_browser")
require("hologram").setup({
	auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
})
