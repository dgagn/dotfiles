local M = {}

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
  vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"

  -- no mouse please
  vim.opt.mouse = ""

  vim.g.loaded_matchparen = 1
  vim.opt.showmatch = true

  vim.opt.scrolloff = 8
  vim.opt.sidescrolloff = 8

  -- check here
  vim.o.completeopt = "menuone,noselect"

  vim.opt.colorcolumn = "80"

  vim.diagnostic.config({
    virtual_text = true,
    float = {
      source = true,
    },
  })
end

return M
