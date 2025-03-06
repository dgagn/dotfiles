return {
  {
    "echasnovski/mini.bufremove",
    opts = {},
    lazy = false,
    keys = {
      {
        "<leader>x",
        function()
          require("mini.bufremove").delete(0, false)
        end,
      },
      {
        "n",
        "<leader>X",
        function()
          local bufremove = require("mini.bufremove")
          local current_buf = vim.api.nvim_get_current_buf()

          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if buf ~= current_buf and not vim.startswith(vim.api.nvim_buf_get_name(buf), "term://") then
              bufremove.delete(buf, false)
            end
          end
        end
      }
    }
  }
}
