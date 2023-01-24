local function chooseRandomTheme()
	local myThemeTable = {
		"powerline",
		"OceanicNext",
		"onelight",
		"papercolor_light",
		"solarized_light",
		"Tomorrow",
		"material",
		"dracula",
	}
	local rand = math.random(#myThemeTable)
	return myThemeTable[rand]
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		--[[ theme = "palenight", ]]
		theme = chooseRandomTheme(),
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			"mode",
		},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename", },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location", require("nvim-lightbulb").get_status_text() },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = { "fzf", "neo-tree", "fugitive" },
})

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])
