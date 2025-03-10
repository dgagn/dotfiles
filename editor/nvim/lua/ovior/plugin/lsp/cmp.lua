local emmet = require('ovior.plugin.lsp.emmet')

local M = {
  {
    'saghen/blink.cmp',
    version = 'v0.13.1',
    opts = {
      keymap = {
        preset = 'default',
        ['<tab>'] = {
          emmet.expand_cmp,
          'snippet_forward',
          'fallback',
        },
      },

      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          }
        },
        menu = {
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              }
            }
          }
        }
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono'
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      signature = { enabled = false }
    }
  }
}

return M
