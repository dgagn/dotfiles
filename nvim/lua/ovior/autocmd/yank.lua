local M = {}

M.setup = function()
  -- I prefer to have yanked text highlighted.
  local autocmd = require('ovior.autocmd')
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = autocmd.augroup("yank"),
    callback = function()
      vim.highlight.on_yank()
    end,
    pattern = "*",
  })
end

return M
