return {
  {
    "saghen/blink.cmp",
    version = "v0.13.1",
    dependencies = {
      "echasnovski/mini.icons",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
        end,
      },
    },
    opts = function()
      local emmet = require("ovior.plugin.lsp.emmet")
      local snip = require("ovior.plugin.lsp.snip")
      local tssnip = require("ovior.plugin.lsp.snippets.ts")
      local rustsnip = require("ovior.plugin.lsp.snippets.rust")
      local luasnip = require("ovior.plugin.lsp.snippets.lua")
      local pythonsnip = require("ovior.plugin.lsp.snippets.python")
      local csharpsnip = require("ovior.plugin.lsp.snippets.cs")
      local tex = require("ovior.plugin.lsp.snippets.tex")
      tssnip.setup()
      rustsnip.setup()
      luasnip.setup()
      pythonsnip.setup()
      csharpsnip.setup()
      tex.setup()

      return {
        snippets = { preset = "luasnip" },

        keymap = {
          preset = "default",
          ["<tab>"] = {
            emmet.expand_cmp,
            snip.expand_cmp,
            "fallback",
          },
          ["<S-Tab>"] = { "fallback" },
          ["<c-l>"] = { "snippet_forward", "fallback" },
          ["<c-h>"] = { "snippet_backward", "fallback" },
        },
        completion = {
          list = {
            selection = {
              preselect = true,
              auto_insert = false,
            },
          },
          menu = {
            draw = {
              components = {
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    local icons = require("mini.icons")
                    local kind = ctx.kind
                    if kind == "Snippet" then
                      kind = "Object"
                    end
                    local kind_icon, _, _ = icons.get("lsp", kind)
                    return kind_icon
                  end,
                  highlight = function(ctx)
                    local icons = require("mini.icons")
                    local kind = ctx.kind
                    if kind == "Snippet" then
                      kind = "Object"
                    end
                    local _, hl, _ = icons.get("lsp", kind)
                    return hl
                  end,
                },
              },
            },
          },
        },

        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "mono",
        },

        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        signature = { enabled = false },
      }
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "InsertEnter",
    opts = {
      filetypes = {
        markdown = true,
      },
      suggestion = {
        enable = true,
        auto_trigger = true,
        keymap = {
          accept = "<c-u>",
          next = "<c-g>",
          prev = "<c-f>",
          dismiss = "<c-e>",
        },
      },
      panel = {
        enable = false,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
}
