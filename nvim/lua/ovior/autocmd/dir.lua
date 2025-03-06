local M = {}

function M.setup()
  local autocmd = require("ovior.autocmd")
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = autocmd.augroup("auto_create_dir"),
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
  })
end

return M
