local M = {}

M.colors = {
	token = "#ffff60",
	string = "#87ffaf",
}

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "ovior"

local highlights = {
	Keyword = { fg = M.colors.token },
	Normal = { bg = "None" },
	String = { fg = M.colors.string },
}

for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end
