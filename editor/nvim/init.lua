local ovior = require("ovior")

-- Safe execute‑command helper for WildWest LSP
local function quick_draw(file, line)
  local buf = vim.api.nvim_get_current_buf()
  file = file or vim.api.nvim_buf_get_name(buf)
  line = line or (vim.api.nvim_win_get_cursor(0)[1] - 1) -- 0‑based

  -- assume the only client is wildwest_lsp; otherwise filter as shown earlier
  local client = vim.lsp.get_active_clients({ bufnr = buf })[1]
  if not client then
    vim.notify("No LSP client attached", vim.log.levels.ERROR)
    return
  end

  client.request(
    "workspace/executeCommand",
    {
      command   = "wildwest.quickDraw",
      arguments = { file, line, "" },
    },
    function(err, result)
      if err then
        -- err.message may be nil → tostring() is safe
        vim.notify(
          ("quickDraw error (%s): %s")
            :format(err.code or "?", tostring(err.message)),
          vim.log.levels.ERROR)
        return
      end
      -- result is the cowboy message string
      vim.notify(result or "<empty result>", vim.log.levels.INFO)
    end,
    buf
  )
end

-- :QuickDraw [file] [line]
vim.api.nvim_create_user_command("QuickDraw", function(opts)
  quick_draw(opts.fargs[1], tonumber(opts.fargs[2]))
end, { nargs = "*" })

ovior.setup()
