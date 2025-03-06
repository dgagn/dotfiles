local M = {}

function M.setup()
  local autocmd = require('ovior.autocmd')
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = autocmd.augroup("saveloc"),
    pattern = "*",
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        vim.api.nvim_win_set_cursor(0, mark)
      end
    end,
  })
end

return M
