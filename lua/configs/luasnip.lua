--[[ .config/nvim/my-snippets ]]
require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/nvim/my-snippets" } })
require("luasnip.loaders.from_vscode").lazy_load()
