local colors = {
	token = "#ff73fd",
	include = "#6699cc",
	type = "#9ccfd8",
	func = "#96cbfe",

	-- string color
	string = "#f6c177",
	constant = "#f6c177",
	number = "#f6c177",
	boolean = "#ebbcba",

	-- purple
	proc = "#c4a7e7",

	-- self
	self = "#eb6f92",

	special = "#16baac",

	operator = "#908caa",
}

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "ovior"

local highlights = {
	Normal = { bg = "None" },
	DiagnosticUnderlineError = { undercurl = true, sp = "NvimLightRed" },
	DiagnosticUnderlineInfo = { undercurl = true, sp = "NvimLightCyan" },
	DiagnosticUnderlineHint = { undercurl = true, sp = colors.proc },
	DiagnosticUnderlineWarn = { undercurl = true, sp = "NvimLightYellow" },

	-- token
	Keyword = { fg = colors.token },
	["@keyword"] = { link = "Keyword" },
	["@lsp.type.formatSpecifier"] = { link = "Keyword" },

	-- operators
	Operator = { fg = colors.operator },
	Delimiter = { fg = colors.operator },
	["@tag.delimiter"] = { link = "Operator" },

	-- include
	Include = { fg = colors.include },
	["@module"] = { link = "Include" },

	-- string
	String = { fg = colors.string },
	["@string.special.url"] = { link = "String" },
	Constant = { fg = colors.constant },
	["@constant.builtin"] = { fg = colors.constant, bold = true },
	Number = { fg = colors.number },
	Boolean = { fg = colors.boolean },

	["@lsp.typemod.variable.mutable"] = { underline = true },

	-- type
	Type = { fg = colors.type },
	["@type.builtin"] = { fg = colors.type, bold = true },
	Property = { fg = colors.type },
	["@property"] = { link = "Property" },
	["@tag.builtin"] = { fg = colors.type },

	-- function
	Function = { fg = colors.func },

	-- proc
	["@lsp.type.decorator"] = { fg = colors.proc },
	["@lsp.typemod.attributeBracket.attribute"] = { fg = colors.proc },
	["@lsp.type.deriveHelper"] = { fg = colors.proc },
	["@variable.parameter"] = { fg = colors.proc },
	["@lsp.type.macro"] = { fg = colors.proc },
	["@tag.attribute"] = { fg = colors.proc },

	--
	["@variable.builtin"] = { fg = colors.self, bold = true },

	-- special
	["@lsp.type.typeAlias"] = { fg = colors.special },
	["@lsp.type.lifetime"] = { fg = colors.special },
	["@tag"] = { fg = colors.special },
}


for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end
