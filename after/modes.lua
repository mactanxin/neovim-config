local modes_status_ok, modes = pcall(require, "modes")
if not modes_status_ok then
	vim.notify("modes import failed", "error", { title = "plugin loader status" })
	return
end

modes.setup({
  colors = {
    normal = "#AFDF00",
    copy = "#f5c359",
    delete = "#dc2626",
    insert = "#2563eb",
    visual = "#d946ef",
  },

	-- Set opacity for cursorline and number background
	line_opacity = 0.15,

	-- Enable cursor highlights
	set_cursor = true,

	-- Enable cursorline initially, and disable cursorline for inactive windows
	-- or ignored filetypes
	set_cursorline = true,

	-- Enable line number highlights to match cursorline
	set_number = true,

	-- Disable modes highlights in specified filetypes
	-- Please PR commonly ignored filetypes
	ignore_filetypes = { "NvimTree", "TelescopePrompt" },
})
