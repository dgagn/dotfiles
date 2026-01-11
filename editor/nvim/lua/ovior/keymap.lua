local M = {}

function M.setup()
  vim.keymap.set("n", "s", "<nop>", { silent = true })
  vim.keymap.set("n", "<c-b>", "<nop>", { silent = true })
  vim.keymap.set("i", "<c-k>", "<nop>", { silent = true })
  vim.keymap.set("i", "<c-b>", "<nop>", { silent = true })
  vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
  vim.keymap.set("v", "u", "<nop>")
  vim.keymap.set("i", "<S-Tab>", "<c-d>")

  vim.keymap.set("n", "<leader><leader>l", "<cmd>source %<cr>")
  vim.keymap.set("n", "<leader>l", ":.lua<cr>")
  vim.keymap.set("v", "<leader>l", ":lua<cr>")

  vim.keymap.set("n", "<leader>x", "<cmd>bd!<cr>")
  vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>")
  vim.keymap.set("n", "<leader>X", "<cmd>%bd|e#|bd#<cr>")

  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  vim.keymap.set("n", "<C-u>", "<C-u>zz")
  vim.keymap.set("i", "<C-u>", "<nop>")

  vim.keymap.set("n", "n", "nzzzv")
  vim.keymap.set("n", "N", "Nzzzv")

  vim.keymap.set("v", "<", "<gv")
  vim.keymap.set("v", ">", ">gv")

  vim.keymap.set("v", "<leader>r", ':DB<cr>')

  vim.keymap.set("x", "<leader>p", '"_dP')
  vim.keymap.set("n", "<leader>p", '"+p')

  vim.keymap.set("n", "<leader>P", '"+gP')

  vim.keymap.set("n", "<leader>y", '"+y')
  vim.keymap.set("v", "<leader>y", '"+y')
  vim.keymap.set("n", "<leader>w", ":Run<CR>", { silent = true })

  vim.keymap.set('s', 'u', 'u', { noremap = true })

  vim.keymap.set("n", "<leader>t", '<cmd>Telescope timew<cr>')
  vim.keymap.set("n", "<leader>s", function()
    vim.fn.jobstart({ "timew", "stop" }, { detach = true })
  end, { desc = "Timewarrior stop" })
  vim.keymap.set("n", "<leader>n", function()
    vim.ui.input({ prompt = "Timew tags: " }, function(input)
      if input then
        vim.fn.jobstart({ "timew", "start", input }, { detach = true })
      else
        vim.notify("No tags given, not starting timew", vim.log.levels.INFO)
      end
    end)
  end, { desc = "Timewarrior start" })


  vim.keymap.set("n", "<leader>%", "<cmd>vsp<cr>")

  -- Buffer navigation
  vim.keymap.set("n", "gn", "<cmd>bnext<cr>")
  vim.keymap.set("n", "gp", "<cmd>bprev<cr>")
  vim.keymap.set("n", "g$", "<cmd>blast<cr>")
  vim.keymap.set("n", "g^", "<cmd>bfirst<cr>")

  vim.keymap.set("n", "<down>", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end)
  vim.keymap.set("n", "<up>", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end)

  vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

  vim.keymap.set("n", "<c-up>", "<cmd>cprev<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<c-down>", "<cmd>cnext<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<c-n>", "<cmd>cnext<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<c-p>", "<cmd>cprev<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<c-q>", "<cmd>cclose<cr>", { noremap = true, silent = true })
end

return M
