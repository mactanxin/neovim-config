require("core.base")
require("core.keymaps")
require("core.options")
require("core.plugins")
require("core.nvim-cmp")
require("ui")
require("configs")
require("core.plugins")
-- require("core.nvim-cmp")
require("core.lspsaga")
require("core.utils")

local vim = vim

require("telescope").load_extension("session-lens")
require("telescope").load_extension("notify")
require("telescope").load_extension("file_browser")

vim.cmd([[colorscheme tokyonight-storm]])
vim.cmd([[hi Visual guifg=White guibg=LightBlue gui=none]])
