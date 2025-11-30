local ovior = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

local cmd_bufnr

local function open_cmd_window()
  if cmd_bufnr and vim.api.nvim_buf_is_valid(cmd_bufnr) then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == cmd_bufnr then
        vim.api.nvim_set_current_win(win)
        return cmd_bufnr
      end
    end
  end

  vim.cmd("botright 10split")
  cmd_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, cmd_bufnr)

  vim.bo[cmd_bufnr].buftype = "nofile"
  vim.bo[cmd_bufnr].bufhidden = "hide"
  vim.bo[cmd_bufnr].swapfile = false
  vim.bo[cmd_bufnr].filetype = "CommandOutput"

  return cmd_bufnr
end

local function append_to_buf(bufnr, lines)
  if not lines or #lines == 0 then
    return
  end
  vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
  local existing = vim.api.nvim_buf_line_count(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, existing, existing, false, lines)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
  vim.api.nvim_buf_set_option(bufnr, "modified", false)
end

local function run_shell_cmd(cmd)
  local bufnr = open_cmd_window()

  vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "> " .. cmd, "" })
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

  local jobid = vim.fn.jobstart(cmd, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(_, data, _)
      if not data then
        return
      end
      vim.schedule(function()
        append_to_buf(bufnr, data)
      end)
    end,
    on_stderr = function(_, data, _)
      if not data then
        return
      end
      vim.schedule(function()
        append_to_buf(bufnr, data)
      end)
    end,
    on_exit = function(_, code, _)
      vim.schedule(function()
        append_to_buf(bufnr, { "", "[exit " .. code .. "]" })
      end)
    end,
  })

  if jobid <= 0 then
    vim.schedule(function()
      append_to_buf(bufnr, { "", "[failed to start: " .. tostring(jobid) .. "]" })
    end)
  end
end

vim.api.nvim_create_user_command("Run", function(opts)
  local cmd = opts.args
  if cmd ~= "" then
    run_shell_cmd(cmd)
  else
    vim.ui.input({ prompt = "!" }, function(input)
      if input and input ~= "" then
        run_shell_cmd(input)
      end
    end)
  end
end, { nargs = "*", complete = "shellcmd" })


function ovior.setup()
  local lazy = require("lazy")
  local aucmd = require("ovior.autocmd")
  local set = require("ovior.set")
  local keymap = require("ovior.keymap")

  vim.cmd.colorscheme("ovior")

  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  aucmd.setup()
  set.setup()
  keymap.setup()

  lazy.setup({
    spec = {
      { import = "ovior.plugin" },
      { import = "ovior.plugin.lsp.cmp" },
    },
    checker = { enabled = false },
  })
end

return ovior
