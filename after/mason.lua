require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"volar",
		"tsserver",
		"tailwindcss",
		"bashls",
		"cssls",
		"emmet_ls",
		"html",
		"jsonls",
		"pyright",
		"yamlls",
	},
})
