return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local on_attach = require("ovior.plugin.lsp.keymap").on_attach
      local function with_fmt_control(server_name)
        return function(client, bufnr)
          -- Disable formatting from servers that might try
          if
            server_name == "ts_ls"
            or server_name == "lua_ls"
            or server_name == "ruff"
            or server_name == "ruff_lsp"
            or server_name == "volar"
          then
            client.server_capabilities.documentFormattingProvider = false
          end
          if on_attach then
            on_attach(client, bufnr)
          end
        end
      end

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local mason_registry = require("mason-registry")
      local pid = tostring(vim.fn.getpid())
      local omnisharp_bin = mason_registry.get_package("omnisharp"):get_install_path() .. "/OmniSharp"
      local vue_ls = mason_registry.get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"

      local ruff_server = lspconfig["ruff"] and "ruff" or (lspconfig["ruff_lsp"] and "ruff_lsp" or nil)

      local servers = {
        rust_analyzer = {
          enable = true,
          capabilities = capabilities,
          cmd = {
            "rustup",
            "run",
            "stable",
            "rust-analyzer",
          },
          root_dir = util.root_pattern("Cargo.toml", ".git"),
          settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
              procMacro = { enable = true },
              cargo = {
                allFeatures = true,
                workspace = true,
              },
              diagnostics = {
                enable = true,
              },
            },
          },
        },
        omnisharp = {
          enable = true,
          cmd = { omnisharp_bin, "--languageserver", "--hostPID", pid },
          settings = {},
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
          filetypes = { "typescript", "typescriptreact", "javascriptreact", "typescriptreact", "vue" },
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = vue_ls,
                languages = { "vue" },
              },
            },
          },
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
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        [ruff_server or ""] = ruff_server and {
          enable = true,
          init_options = {
            settings = {
              organizeImports = true,
            },
          },
          root_dir = util.root_pattern("pyproject.toml", ".git"),
        } or nil,
        emmet_language_server = {
          enable = true,
          filetypes = { "html", "javascriptreact", "svelte", "typescriptreact", "vue" },
          settings = {},
          init_options = {
            includeLanguages = {
              vue = "html",
              ["vue-html"] = "html",
            },
          },
        },
      }

      for server, details in pairs(servers) do
        if details.enable then
          lspconfig[server].setup({
            on_attach = details.on_attach or with_fmt_control(server),
            settings = details.settings,
            capabilities = details.capabilities,
            cmd = details.cmd,
            filetypes = details.filetypes,
            init_options = details.init_options or {},
          })
        end
      end
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
      vim.g.rustfmt_command = "cargo fmt"
      vim.g.rustfmt_options = "--"
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
        "ts_ls",
        "clangd",
        "tailwindcss",
        "volar",
        "emmet_language_server",
        "ruff",
        "intelephense",
        "pyright",
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
          require("none-ls.code_actions.eslint_d"),
          require("none-ls.diagnostics.ruff"),
          require("none-ls.formatting.ruff"),
          require("none-ls.formatting.ruff_format"),
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.prettierd,
        },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>gF",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics",
      },
      {
        "<leader>gf",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },
}
