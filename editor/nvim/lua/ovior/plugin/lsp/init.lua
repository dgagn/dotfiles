return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local util = require("lspconfig.util")
      local on_attach = require("ovior.plugin.lsp.keymap").on_attach
      local lsp_augroup = vim.api.nvim_create_augroup("ovior-lsp-start", { clear = true })

      local function with_fmt_control(server_name)
        return function(client, bufnr)
          if
            server_name == "ts_ls"
            or server_name == "lua_ls"
            or server_name == "ruff"
            or server_name == "ruff_lsp"
            or server_name == "vue_ls"
          then
            client.server_capabilities.documentFormattingProvider = false
          end
          if on_attach then
            on_attach(client, bufnr)
          end
        end
      end

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local vue_ls = vim.fn.expand("$MASON/packages/vue-language-server") .. "/node_modules/@vue/language-server"

      local servers = {
        rust_analyzer = {
          enable = true,
          capabilities = capabilities,
          cmd = { "rust-analyzer" },
          root_dir = util.root_pattern("Cargo.toml", ".git"),
          settings = {
            ["rust-analyzer"] = {
              check = { command = "clippy" },
              procMacro = { enable = true },
              cargo = {
                allFeatures = true,
                workspace = true,
                targetDir = true,
              },
              files = {
                watcher = "client",
                exclude = {
                  "target",
                  "dist",
                  "node_modules",
                },
              },
              diagnostics = {
                enable = true,
              },
            },
          },
        },

        vue_ls = {
          enable = true,
          settings = {},
        },

        ts_ls = {
          enable = true,
          settings = {},
          filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "vue",
          },
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

        ruff = {
          enable = true,
          init_options = {
            settings = {
              organizeImports = true,
            },
          },
          root_dir = util.root_pattern("pyproject.toml", ".git"),
        },

        lift_lsp = {
          enable = true,
          capabilities = capabilities,
          cmd = {
            "cargo",
            "run",
            "--manifest-path",
            "/home/ovior/work/qraft-monolith/Cargo.toml",
            "-p",
            "lift-lsp",
            "--quiet",
          },
          filetypes = { "lift" },
          root_dir = function(fname)
            return util.root_pattern(".git")(fname) or util.path.dirname(fname)
          end,
        },
      }

      for server, details in pairs(servers) do
        if details.enable then
          vim.lsp.config(server, {
            on_attach = details.on_attach or with_fmt_control(server),
            settings = details.settings,
            capabilities = details.capabilities,
            cmd = details.cmd,
            filetypes = details.filetypes,
            init_options = details.init_options or {},
            root_dir = details.root_dir,
          })

          local cfg = vim.lsp.config[server]
          local filetypes = details.filetypes or cfg.filetypes

          vim.api.nvim_create_autocmd("FileType", {
            group = lsp_augroup,
            pattern = filetypes,
            callback = function(args)
              local bufname = vim.api.nvim_buf_get_name(args.buf)
              local root_dir = cfg.root_dir

              if type(root_dir) == "function" then
                local resolved_root
                local ok, result = pcall(root_dir, args.buf, function(dir)
                  resolved_root = dir
                end)

                if ok and resolved_root ~= nil then
                  root_dir = resolved_root
                elseif ok then
                  local legacy_ok, legacy_result = pcall(root_dir, bufname)
                  if not legacy_ok then
                    return
                  end
                  root_dir = legacy_result
                else
                  local legacy_ok, legacy_result = pcall(root_dir, bufname)
                  if not legacy_ok then
                    return
                  end
                  root_dir = legacy_result
                end
              end

              if not root_dir then
                return
              end

              vim.lsp.start(vim.tbl_deep_extend("force", cfg, {
                name = server,
                root_dir = root_dir,
              }), {
                bufnr = args.buf,
              })
            end,
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
    "stevearc/overseer.nvim",
    opts = {},
  },
  {
    "seblyng/roslyn.nvim",
    opts = {},
  },
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
    config = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0
      vim.g.rust_clip_command = "xclip -selection clipboard"
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
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "rust_analyzer",
        "lua_ls",
        "ts_ls",
        "clangd",
        "tailwindcss",
        "vue_ls",
        "emmet_language_server",
        "ruff",
        "intelephense",
        "pyright",
      },
      automatic_enable = {
        exclude = {
          "rust_analyzer",
          "vue_ls",
          "ts_ls",
          "ruff",
        },
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
          require("none-ls.formatting.ruff"),
          require("none-ls.formatting.ruff_format"),
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.sqlfluff.with({
            extra_args = { "--dialect", "mysql" },
          }),
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
        "<leader>d",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics",
      },
      {
        "<leader>b",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },
}
