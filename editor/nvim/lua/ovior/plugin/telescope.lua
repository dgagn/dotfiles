return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function(_, opts)
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      require("telescope").setup(opts)
    end,
    keys = function()
      local builtin = require("telescope.builtin")

      return {
        {
          "<leader>ff",
          builtin.find_files,
        },
        {
          "<leader>fg",
          builtin.live_grep,
        },
        {
          "<leader>fh",
          builtin.help_tags,
        },
      }
    end,
    opts = function()
      return {
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
          border = true,
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          sorting_strategy = "ascending",
          file_ignore_patterns = {
            "node_modules",
            "vendor",
            ".git/",
          },
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown({}),
            },
          },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
}
