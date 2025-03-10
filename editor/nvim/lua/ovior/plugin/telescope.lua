return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "live_grep_args")
    end,
    keys = function()
      local builtin = require("telescope.builtin")

      return {
        {
          "<leader>ff",
          builtin.find_files,
        },
        {
          "<leader>fF",
          function()
            builtin.find_files({
              previewer = false,
              find_command = { "fd", "--type", "f", "--hidden", "--follow", "--no-ignore" },
            })
          end,
        },
        {
          "<leader>fb",
          builtin.buffers,
        },
        {
          "<leader>fg",
          builtin.live_grep,
        },
        {
          "<leader>fA",
          function()
            builtin.live_grep({
              no_ignore = false,
              search_dirs = { vim.fn.expand("%:p:h") },
            })
          end,
        },
        {
          "<leader>fw",
          builtin.grep_string,
        },
        {
          "<leader>fD",
          builtin.diagnostics,
        },
        {
          "<leader>fh",
          builtin.help_tags,
        },
        {
          "<leader>?",
          builtin.oldfiles,
        },
        {
          "<leader>hh",
          builtin.help_tags,
        },
        {
          "<leader>fd",
          function()
            local cwd = vim.fn.expand("%:p:h")
            if vim.bo.filetype == "oil" then
              cwd = string.gsub(cwd, "^oil://", "")
            end
            builtin.find_files({
              cwd = cwd,
              find_command = { "fd", "--type", "d", "--hidden", "--follow", "--exclude", ".git" },
              previewer = false,
            })
          end,
        },
        {
          "<leader>fq",
          function()
            local cwd = vim.fn.expand("%:p:h")
            if vim.bo.filetype == "oil" then
              cwd = string.gsub(cwd, "^oil://", "")
            end
            builtin.find_files({
              cwd = cwd,
              find_command = { "fd", "--type", "d", "--hidden", "--follow", "--exclude", ".git" },
              previewer = false,
            })
          end,
        },
        {
          "<leader>fa",
          function()
            local cwd = vim.fn.expand("%:p:h")
            if vim.bo.filetype == "oil" then
              cwd = string.gsub(cwd, "^oil://", "")
            end
            builtin.find_files({
              cwd = cwd,
              previewer = false,
            })
          end,
        },
        {
          "<leader>/",
          function()
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
              winblend = 10,
              previewer = false,
            }))
          end,
          desc = "Find recently opened files",
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
