return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    config = function()
      vim.keymap.set("n", "<leader>g", vim.cmd.Git)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>")
      vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>")
      vim.keymap.set("n", "gs", "<cmd>Gitsigns stage_buffer<cr>")
      vim.keymap.set("n", "gB", "<cmd>Gitsigns reset_buffer<cr>")
      vim.keymap.set("n", "gh", "<cmd>Gitsigns stage_hunk<cr>")
      vim.keymap.set("n", "gH", "<cmd>Gitsigns undo_stage_hunk<cr>")
      vim.keymap.set("n", "gP", "<cmd>Gitsigns preview_hunk<cr>")
    end,
  },
}
