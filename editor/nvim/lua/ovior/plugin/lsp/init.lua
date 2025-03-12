return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local on_attach = require("ovior.plugin.lsp.keymap").on_attach

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
        rust_analyzer = {
          enable = true,
          capabilities = capabilities,
          cmd = {
            "rustup",
            "run",
            "nightly",
            "rust-analyzer",
          },
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
              },
              diagnostics = {
                enable = true,
              },
            },
          },
        },
        clangd = {
          enable = true,
          settings = {},
        },
        lua_ls = {
          enable = true,
          settings = {
            Lua = {
              format = {
                enable = false,
              },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
        ts_ls = {
          enable = true,
          settings = {},
        },
        intelephense = {
          enable = true,
          settings = {},
        },
        tailwindcss = {
          enable = true,
          settings = {},
        },
        pyright = {
          enable = true,
          filtetypes = { "python" },
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
              },
            },
          },
        },
        emmet_language_server = {
          enable = true,
          filetypes = { "html", "javascriptreact", "svelte", "typescriptreact", "vue" },
          settings = {},
        },
      }

      for server, details in pairs(servers) do
        if details.enable then
          lspconfig[server].setup({
            on_attach = details.on_attach or on_attach,
            settings = details.settings,
            capabilities = details.capabilities,
            cmd = details.cmd,
          })
        end
      end

      -- auto format
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
    config = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0
      vim.g.rust_clip_command = "wl-copy"
    end,
  },
  {
    "folke/lazydev.nvim",
    enabled = true,
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
      },
    },
  },
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    enabled = true,
    opts = {
      scope = "line",
      placement = "top",
      update_event = {
        "BufReadPost",
        "DiagnosticChanged",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          require("none-ls.formatting.ruff_format"),
          nls.builtins.formatting.stylua,
        },
      }
    end,
  },
}
