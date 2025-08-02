local M = {}

function M.on_attach(client, bufnr)
  local has_cmp, cmp = pcall(require, "cmp")

  local lspmap = function(mode, keys, func)
    vim.keymap.set(mode, keys, func, { buffer = bufnr })
  end

  local function close_floating_windows()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local cfg = vim.api.nvim_win_get_config(win)
      if cfg and cfg.relative and cfg.relative ~= "" then
        pcall(vim.api.nvim_win_close, win, true)
      end
    end
  end

  local function make_jump(fn)
    return function()
      if has_cmp and cmp.visible() then
        cmp.close()
      end
      close_floating_windows()
      fn()
    end
  end

  -- restart lsp
  vim.keymap.set("n", "<leader>z", "<cmd>LspRestart<cr>")

  lspmap("n", "<leader>fm", vim.lsp.buf.format)
  lspmap("n", "gd", make_jump(vim.lsp.buf.definition))
  lspmap("n", "gD", make_jump(vim.lsp.buf.declaration))
  lspmap("n", "gi", make_jump(vim.lsp.buf.implementation))
  lspmap("n", "gt", make_jump(vim.lsp.buf.type_definition))
  lspmap("n", "gf", vim.diagnostic.open_float)
  lspmap("n", "K", vim.lsp.buf.hover)
  lspmap("n", "gr", vim.lsp.buf.references)
  lspmap("n", "<leader>r", vim.lsp.buf.rename)
  lspmap("n", "<leader>ca", vim.lsp.buf.code_action)
end

return M
