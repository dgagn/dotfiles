return {
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  {
    "lambdalisue/vim-suda",
    lazy = false,
    enabled = true,
    init = function()
      vim.cmd [[ cnoreabbrev <expr> w!! getcmdline() ==# 'w!!' ? 'SudaWrite' : 'w!!' ]]
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    opts = function()
      return {
        options = {
          theme = {
            normal = {
              a = { fg = "#ffffff", bg = "None", gui = "bold" },
              b = { fg = "#ffffff", bg = "None" },
              c = { fg = "#ffffff", bg = "None" },
            },
            insert = {
              a = { fg = "#ffffff", bg = "None", gui = "bold" },
              b = { fg = "#ffffff", bg = "None" },
              c = { fg = "#ffffff", bg = "None" },
            },
            visual = {
              a = { fg = "#ffffff", bg = "None", gui = "bold" },
              b = { fg = "#ffffff", bg = "None" },
              c = { fg = "#ffffff", bg = "None" },
            },
            replace = {
              a = { fg = "#ffffff", bg = "None", gui = "bold" },
              b = { fg = "#ffffff", bg = "None" },
              c = { fg = "#ffffff", bg = "None" },
            },
            command = {
              a = { fg = "#ffffff", bg = "None", gui = "bold" },
              b = { fg = "#ffffff", bg = "None" },
              c = { fg = "#ffffff", bg = "None" },
            },
            inactive = {
              a = { fg = "#bbbbbb", bg = "None" },
              b = { fg = "#bbbbbb", bg = "None" },
              c = { fg = "#bbbbbb", bg = "None" },
            },
          },
          component_separators = "-",
          section_separators = "",
          icons_enabled = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "buffers",
              symbols = {
                alternate_file = "",
              },
              buffers_color = {
                active = { fg = "#96cbfe", bg = "None", gui = "bold" },
                inactive = { fg = "#bbbbbb", bg = "None" },
              },
            }
          },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
            "branch",
          },
          lualine_x = {
            "filetype",
          },
        },
      }
    end
  }
}
