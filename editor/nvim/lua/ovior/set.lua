local M = {}

local function xdg_data_home(path)
  local value = os.getenv("XDG_DATA_HOME")

  if value == nil then
    return os.getenv("HOME") .. "/.local/share/" .. path
  else
    return value .. "/" .. path
  end
end

function M.setup()
  vim.opt.hlsearch = false

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  vim.opt.smartindent = true
  vim.opt.wrap = false

  vim.opt.signcolumn = "yes"

  vim.opt.swapfile = false
  vim.opt.undofile = true
  vim.opt.undolevels = 100000
  vim.opt.undodir = xdg_data_home("nvim/undo")

  -- no mouse please
  vim.opt.mouse = ""

  vim.g.loaded_matchparen = 1
  vim.opt.showmatch = true

  vim.opt.scrolloff = 8
  vim.opt.sidescrolloff = 8

  -- check here
  vim.o.completeopt = "menuone,noselect"

  vim.opt.colorcolumn = "80"

  -- set expandtab softtabtab=4 shiftwidth=4 tabstop=8
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4

  vim.diagnostic.config({
    virtual_text = true,
    float = {
      source = true,
    },
  })
end

return M
