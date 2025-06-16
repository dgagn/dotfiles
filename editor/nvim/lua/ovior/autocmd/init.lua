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
  vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "*" },
    callback = function()
      vim.opt.formatoptions = vim.opt.formatoptions + {
        o = false,
      }
    end,
    group = augroup("paste"),
    desc = "Disable auto-commenting on new lines",
  })
end

function M.setup()
  yank()
  save_old_loc()
  highlight_whitespace()
  mkdirp()
  comment()
end

return M
