local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.notify("null-ls import failed", "error", { title = "plugin loader status" })
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = false,
  sources = {
    formatting.markdownlint,
    formatting.stylelint,
    formatting.stylua,
    formatting.eslint_d,
    -- diagnostics.eslint_d,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            timeout_ms = 4000, -- how many miliseconds to wait before time out
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})

null_ls.builtins.formatting.eslint.with({
  rules = { "semi", 0 },
  extra_args = { "--style", "{IndentWidth: 2 ,ColumnLimit: 80}" },
})
