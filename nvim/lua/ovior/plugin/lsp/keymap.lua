local M = {}

function M.on_attach(client, bufnr)
  local lspmap = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  -- restart lsp
  vim.keymap.set("n", "<leader>z", "<cmd>LspRestart<cr>")

  vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
  end)

  lspmap("n", "gd", vim.lsp.buf.definition)
  lspmap("n", "gD", vim.lsp.buf.declaration)
  lspmap("n", "gi", vim.lsp.buf.implementation)
  lspmap("n", "gt", vim.lsp.buf.type_definition)
  lspmap("n", "K", vim.lsp.buf.hover)
  lspmap("n", "gr", vim.lsp.buf.references)
  lspmap("n", "<leader>r", vim.lsp.buf.rename)
  lspmap("n", "<leader>ca", vim.lsp.buf.code_action)
end

return M
