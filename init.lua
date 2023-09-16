require("core.base")
require("core.keymaps")
require("core.options")
require("core.plugins")
require("ui")
require("core.lspsaga")
require("core.utils")
require("configs.null-ls")

local vim = vim

require("telescope").load_extension("session-lens")
require("telescope").load_extension("notify")
require("telescope").load_extension("file_browser")

vim.cmd([[colorscheme tokyonight-storm]])
vim.cmd([[hi Visual guifg=White guibg=LightBlue gui=none]])
