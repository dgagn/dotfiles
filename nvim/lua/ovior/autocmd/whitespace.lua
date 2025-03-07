local M = {}

function M.setup()
  local autocmd = require('ovior.autocmd')
  vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "Red", bg = "Red" })
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = autocmd.augroup("whitespace"),
    pattern = "*",
    callback = function()
      if vim.fn.exists("b:current_syntax") == 1 then
        print(vim.bo.filetype)
        vim.api.nvim_call_function("matchadd", { "ExtraWhitespace", "\\s\\+$" })
      end
    end,
  })
end

return M
