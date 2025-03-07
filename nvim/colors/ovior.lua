local M = {}

M.colors = {
	token = "#ffff60",
	string = "#f6c177",
	-- string = "#87ffaf",
	special = "#c4a7e7",
	special2 = "#ff73fd",
	type = "#4ec9b0",
	typer = "#81dbbf",
	alias = "#16baac",
}

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "ovior"

local highlights = {
	Keyword = { fg = M.colors.token },
	Normal = { bg = "None" },
	String = { fg = M.colors.string },
	["@lsp.type.formatSpecifier.rust"] = { fg = M.colors.special },
	["@variable.builtin.rust"] = { fg = M.colors.special2 },
	["@lsp.type.namespace.rust"] = { fg = M.colors.type },
	["@lsp.typemod.variable.mutable.rust"] = { underline = true },
	Type = { fg = M.colors.typer },
	["@lsp.type.lifetime.rust"] = { fg = M.colors.alias },
	["@lsp.type.typeParameter"] = { fg = M.colors.alias },
	["@lsp.type.typeAlias"] = { fg = M.colors.alias },
	["tsxTagName"] = { fg = M.colors.alias },
	DiagnosticUnderlineError = { undercurl = true, sp = "NvimLightRed" },
	DiagnosticUnderlineInfo = { undercurl = true, sp = "NvimLightCyan" },
	DiagnosticUnderlineHint = { undercurl = true, sp = "NvimLightBlue" },
	DiagnosticUnderlineWarn = { undercurl = true, sp = "NvimLightYellow" },
}


for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end
