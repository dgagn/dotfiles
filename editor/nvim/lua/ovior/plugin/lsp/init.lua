return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      local lspconfig = require('lspconfig')
      local on_attach = require('ovior.plugin.lsp.keymap').on_attach

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = {
        rust_analyzer = {
          enabled = true,
          capabalities = capabilities,
          cmd = {
            "rustup", "run", "stable", "rust-analyzer"
          },
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy"
              },
              cargo = {
                allFeatures = true,
              },
              diagnostics = {
                enable = true,
              }
            }
          }
        },
        clangd = {
          enabled = true,
          settings = {}
        },
        lua_ls = {
          enabled = true,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          }
        }
      }

      for server, details in pairs(servers) do
        if details.enabled then
          lspconfig[server].setup({
            on_attach = details.on_attach or on_attach,
            settings = details.settings,
            capabilities = details.capabilities,
            cmd = details.cmd
          })
        end
      end

      -- auto format
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end
        end
      })
    end
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
