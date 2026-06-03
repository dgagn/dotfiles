local M = {}

local function augroup(name)
  return vim.api.nvim_create_augroup("ovior_" .. name, { clear = true })
end

M.augroup = augroup

local function yank()
  -- I prefer to have yanked text highlighted.
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("yank"),
    callback = function()
      vim.highlight.on_yank()
    end,
    pattern = "*",
  })
end

local function save_old_loc()
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("saveloc"),
    pattern = "*",
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        vim.api.nvim_win_set_cursor(0, mark)
      end
    end,
  })
end

local function highlight_whitespace()
  vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#540000" })
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = augroup("whitespace"),
    pattern = "*",
    callback = function()
      if vim.fn.exists("b:current_syntax") == 1 then
        vim.api.nvim_call_function("matchadd", { "ExtraWhitespace", "\\s\\+$" })
      end
    end,
  })
end

local function mkdirp()
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
  })
end

local function comment()
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "*" },
    callback = function()
      vim.opt_local.formatoptions = vim.opt_local.formatoptions + {
        o = false,
      }
    end,
    group = augroup("paste"),
    desc = "Disable auto-commenting on new lines",
  })
end

local function format()
  local function use_builtin_gq(bufnr)
    if vim.bo[bufnr].textwidth == 0 then
      vim.bo[bufnr].textwidth = 80
    end

    vim.bo[bufnr].formatexpr = ""
  end

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "*" },
    callback = function(args)
      use_builtin_gq(args.buf)
    end,
    group = augroup("format"),
    desc = "Keep gq using the built-in formatter with a useful width",
  })

  vim.api.nvim_create_autocmd({ "LspAttach" }, {
    pattern = { "*" },
    callback = function(args)
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          use_builtin_gq(args.buf)
        end
      end)
    end,
    group = augroup("lsp_format"),
    desc = "Prevent LSP formatexpr from overriding gq",
  })
end

function M.setup()
  yank()
  save_old_loc()
  highlight_whitespace()
  mkdirp()
  comment()
  format()
end

return M
