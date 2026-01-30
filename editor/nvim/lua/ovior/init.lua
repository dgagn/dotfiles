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
  -- If an old terminal buffer exists, wipe it so we can start fresh.
  if cmd_bufnr and vim.api.nvim_buf_is_valid(cmd_bufnr) then
    local bt = vim.bo[cmd_bufnr].buftype
    if bt == "terminal" then
      pcall(vim.api.nvim_buf_delete, cmd_bufnr, { force = true })
      cmd_bufnr = nil
    else
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == cmd_bufnr then
          vim.api.nvim_set_current_win(win)
          return cmd_bufnr
        end
      end
    end
  end

  vim.cmd("botright 10split")
  vim.cmd("enew") -- new empty buffer in the split
  cmd_bufnr = vim.api.nvim_get_current_buf()
  return cmd_bufnr
end

local function append_lines(bufnr, lines)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  vim.bo[bufnr].modifiable = true
  local last = vim.api.nvim_buf_line_count(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, last, last, false, lines)
  vim.bo[bufnr].modifiable = false
end

local function run_shell_cmd(cmd)
  local bufnr = open_cmd_window()

  local job_id = vim.fn.termopen(cmd, {
    on_exit = function(_, code, _)
      vim.schedule(function()
        append_lines(bufnr, { "", ("[exit %d]"):format(code) })
      end)
    end,
  })

  vim.schedule(function()
    append_lines(bufnr, { ("> " .. cmd), "" })
  end)

  vim.cmd("startinsert")
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
