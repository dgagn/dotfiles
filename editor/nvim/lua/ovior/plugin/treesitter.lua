return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    },
    build = ":TSUpdate",
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.lift = {
        install_info = {
          url = "/home/ovior/work/qraft-monolith/crates/tree-sitter-lift",
          files = { "src/parser.c" },
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "lift",
      }

      require("nvim-treesitter.configs").setup(opts)

      -- Neovim 0.12 passes directive captures as lists of nodes. Some current
      -- nvim-treesitter directives still expect the old single-node shape,
      -- which breaks markdown/rustdoc hover injections such as ```rust blocks.
      local function first_node(capture)
        if type(capture) == "table" then
          return capture[1]
        end

        return capture
      end

      vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local node = first_node(match[pred[2]])
        if not node then
          return
        end

        local language = vim.treesitter.get_node_text(node, bufnr):lower()
        metadata["injection.language"] = language
      end, { force = true })
    end,
    opts = {
      ensure_installed = {
        "lua",
        "vue",
        "javascript",
        "typescript",
        "tsx",
        "rust",
        "markdown",
        "markdown_inline",
        "comment",
        "latex",
        "lift",
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "sql" },
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "+",
          node_incremental = "+",
          node_decremental = "s-",
        },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          f = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }, {}),
          a = ai.gen_spec.treesitter({
            i = "@parameter.inner",
            a = "@parameter.outer",
          }, {}),
        },
      }
    end,
  },
}
