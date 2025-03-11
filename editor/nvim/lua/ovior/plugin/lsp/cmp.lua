return {
  {
    "saghen/blink.cmp",
    version = "v0.13.1",
    dependencies = {
      "echasnovski/mini.icons",
      {
        "L3MON4D3/LuaSnip",
        version = 'v2.*',
        config = function()
          require("luasnip.loaders.from_snipmate").load({ path = { "./snippets" } })
        end
      },
    },
    opts = function()
      local emmet = require("ovior.plugin.lsp.emmet")
      local snip = require("ovior.plugin.lsp.snip")

      return {
        snippets = { preset = 'luasnip' },

        keymap = {
          preset = "default",
          ["<tab>"] = {
            emmet.expand_cmp,
            snip.expand_cmp,
            "snippet_forward",
            "fallback",
          },
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

          providers = {
          },
        },

        signature = { enabled = false },
      }
    end,
  },
}
