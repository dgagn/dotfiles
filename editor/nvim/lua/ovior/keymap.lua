local M = {}

function M.setup()
  vim.keymap.set("n", "s", "<nop>", { silent = true })
  vim.keymap.set("n", "<c-b>", "<nop>", { silent = true })
  vim.keymap.set("i", "<c-k>", "<nop>", { silent = true })
  vim.keymap.set("i", "<c-b>", "<nop>", { silent = true })
  vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
  vim.keymap.set("v", "u", "<nop>")
  vim.keymap.set("i", "<S-Tab>", "<c-d>")

  vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>")
  vim.keymap.set("n", "<leader>X", "<cmd>%bd|e#|bd#<cr>")

  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  vim.keymap.set("n", "<C-u>", "<C-u>zz")
  vim.keymap.set("i", "<C-u>", "<nop>")

  vim.keymap.set("n", "n", "nzzzv")
  vim.keymap.set("n", "N", "Nzzzv")

  vim.keymap.set("v", "<", "<gv")
  vim.keymap.set("v", ">", ">gv")

  vim.keymap.set("x", "<leader>p", '"_dP')
  vim.keymap.set("n", "<leader>p", '"+p')

  vim.keymap.set("n", "<leader>P", '"+gP')

  vim.keymap.set("n", "<leader>y", '"+y')
  vim.keymap.set("v", "<leader>y", '"+y')

  vim.keymap.set("n", "<leader>%", "<cmd>vsp<cr>")

  -- Buffer navigation
  vim.keymap.set("n", "gn", "<cmd>bnext<cr>")
  vim.keymap.set("n", "gp", "<cmd>bprev<cr>")
  vim.keymap.set("n", "g$", "<cmd>blast<cr>")
  vim.keymap.set("n", "g^", "<cmd>bfirst<cr>")

  vim.keymap.set("n", "<down>", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<up>", vim.diagnostic.goto_prev)

  vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

  vim.keymap.set("n", "<right>", "<cmd>cnext<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<left>", "<cmd>cprev<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<c-q>", "<cmd>cclose<cr>", { noremap = true, silent = true })
end

return M
