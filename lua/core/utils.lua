local command = vim.api.nvim_create_user_command

function _G.recompile()
	if vim.bo.buftype == "" then
		if vim.fn.exists(":LspStop") ~= 0 then
			vim.cmd("LspStop")
		end

		for name, _ in pairs(package.loaded) do
			if name:match("^user") then
				package.loaded[name] = nil
			end
		end

		dofile(vim.env.MYVIMRC)
		vim.cmd("PackerCompile")
		vim.notify("Wait for Compile Done", vim.log.levels.INFO)
	else
		vim.notify("Not available in this window/buffer", vim.log.levels.INFO)
	end
end

command("Recompile", function()
	recompile()
end, { nargs = "*" })

function _G.ReloadConfig()
	for name, _ in pairs(package.loaded) do
		if name:match("^core") and not name:match("noice") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

command("ReloadConfig", function()
	ReloadConfig()
end, { nargs = "*" })
