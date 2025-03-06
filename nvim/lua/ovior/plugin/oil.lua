return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "echasnovski/mini.icons", opts = {} }
    },
    opts = {
      columns = { "icon" },
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".DS_Store" or name == "thumbs.db" or name == ".."
        end,
      },
    },
    config = function(opts)
      local oil = require('oil')
      local autocmd = require('ovior.autocmd')
      vim.api.nvim_create_autocmd("FileType", {
        group = autocmd.augroup("confirm_oil"),
        pattern = "oil_preview",
        callback = function(params)
          vim.keymap.set("n", "y", "o", { buffer = params.buf, remap = true, nowait = true })
        end,
      })
      oil.setup(opts)
    end,
    keys = {
      { "-", "<cmd>Oil<cr>" }
    }
  },
}
