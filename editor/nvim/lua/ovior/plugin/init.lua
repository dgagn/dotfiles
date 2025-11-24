return {
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "lambdalisue/vim-suda",
    lazy = false,
    enabled = true,
    init = function()
      vim.cmd([[ cnoreabbrev <expr> w!! getcmdline() ==# 'w!!' ? 'SudaWrite' : 'w!!' ]])
    end,
  },
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_forward_search_on_start = 0
      vim.g.vimtex_compiler_latexmk = {
        options = { "-shell-escape" },
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    opts = function()
      local timew_cache = ""
      local last_timew_check = 0

      local function parse_iso_duration(iso)
        -- ISO duration like "PT1H2M3S" -> "1:02:03" or "02:03"
        if not iso or iso == "" then
          return ""
        end

        local h = tonumber(iso:match("(%d+)H")) or 0
        local m = tonumber(iso:match("(%d+)M")) or 0
        local s = tonumber(iso:match("(%d+)S")) or 0

        if h > 0 then
          return string.format("%d:%02d:%02d", h, m, s)
        else
          return string.format("%02d:%02d", m, s)
        end
      end

      local function timew_status()
        -- Throttle expensive calls to at most ~1x per second
        local uv = vim.loop
        local now = uv and uv.now and uv.now() or (os.time() * 1000)

        if now - last_timew_check < 5000 then
          return timew_cache
        end
        last_timew_check = now

        -- Check if there is active tracking
        local ok_active, active = pcall(vim.fn.system, { "timew", "get", "dom.active" })
        if not ok_active then
          timew_cache = ""
          return ""
        end

        active = (active or ""):gsub("%s+", "")
        if active ~= "1" then
          timew_cache = ""
          return ""
        end

        -- Get tags (may be space- or newline-separated depending on timew version)
        local tags = vim.fn.systemlist({ "timew", "get", "dom.active.tags" })
        if not tags or #tags == 0 or tags[1] == "" then
          -- Fallback for older DOM variants: dom.active.tag.1, dom.active.tag.2, ...
          tags = {}
          local i = 1
          while true do
            local t = vim.fn.system({ "timew", "get", "dom.active.tag." .. i })
            t = (t or ""):gsub("%s+$", "")
            if t == "" then
              break
            end
            table.insert(tags, t)
            i = i + 1
          end
        end

        local tags_str = table.concat(tags, " ")
        tags_str = tags_str:gsub("%s+", " "):gsub("%s+$", "")

        -- Get elapsed duration
        local duration_iso = vim.fn.system({ "timew", "get", "dom.active.duration" })
        duration_iso = duration_iso:gsub("%s+", "")
        local duration = parse_iso_duration(duration_iso)

        if tags_str == "" and duration == "" then
          timew_cache = ""
          return ""
        end

        -- Final string in the statusline, e.g. [setup 12:34]
        timew_cache = string.format("[%s %s]", tags_str, duration)
        return timew_cache
      end
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
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
            "branch",
          },
          lualine_x = {
            timew_status,
            "filetype",
          },
        },
      }
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    opts = {},
  },
  "tpope/vim-sleuth",
  {
    "tpope/vim-surround",
    config = function()
      vim.keymap.set("x", "<Tab>", "S<", { remap = true, silent = true })
      vim.keymap.set("n", "sa", "<Plug>Ysurround", { remap = true, silent = true })
      vim.keymap.set("x", "s", "<Plug>VSurround", { remap = true, silent = true })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "vue",
      "javascriptreact",
      "typescriptreact",
      "html",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
