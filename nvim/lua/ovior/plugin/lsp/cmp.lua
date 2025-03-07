local M = {
  {
    'saghen/blink.cmp',
    version = 'v0.13.1',
    opts = {
      keymap = { preset = 'default' },

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
