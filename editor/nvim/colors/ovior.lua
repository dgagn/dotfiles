local palette1 = {
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

local function set_colors(palette)
  local highlights = {
    Normal = { bg = "None" },
    DiagnosticUnderlineError = { undercurl = true, sp = "NvimLightRed" },
    DiagnosticUnderlineInfo = { undercurl = true, sp = "NvimLightCyan" },
    DiagnosticUnderlineHint = { undercurl = true, sp = palette.proc },
    DiagnosticUnderlineWarn = { undercurl = true, sp = "NvimLightYellow" },

    -- token
    Keyword = { fg = palette.token },
    ["@keyword"] = { link = "Keyword" },
    ["@lsp.type.formatSpecifier"] = { link = "Keyword" },

    -- operators
    Operator = { fg = palette.operator },
    Delimiter = { fg = palette.operator },
    ["@tag.delimiter"] = { link = "Operator" },

    -- include
    Include = { fg = palette.include },
    ["@module"] = { link = "Include" },

    -- string
    String = { fg = palette.string },
    ["@string.special.url"] = { link = "String" },
    Constant = { fg = palette.constant },
    ["@constant.builtin"] = { fg = palette.constant, bold = true },
    Number = { fg = palette.number },
    Boolean = { fg = palette.boolean },

    ["@lsp.typemod.variable.mutable"] = { underline = true },

    -- type
    Type = { fg = palette.type },
    ["@type.builtin"] = { fg = palette.type, bold = true },
    Property = { fg = palette.type },
    ["@property"] = { link = "Property" },
    ["@tag.builtin"] = { fg = palette.type },
    ["Directory"] = { fg = palette.type },
    Special = { fg = palette.type },

    -- function
    Function = { fg = palette.func },
    ["@function.builtin"] = { fg = palette.func, bold = true },

    -- proc
    ["@lsp.type.decorator"] = { fg = palette.proc },
    ["@lsp.typemod.attributeBracket.attribute"] = { fg = palette.proc },
    ["@lsp.type.deriveHelper"] = { fg = palette.proc },
    ["@variable.parameter"] = { fg = palette.proc },
    ["@lsp.type.macro"] = { fg = palette.proc },
    ["@tag.attribute"] = { fg = palette.proc },
    Statement = { fg = palette.proc },

    --
    ["@variable.builtin"] = { fg = palette.self, bold = true },

    -- special
    ["@lsp.type.typeAlias"] = { fg = palette.special },
    ["@lsp.type.lifetime"] = { fg = palette.special },
    ["@tag"] = { fg = palette.special },

    -- sql
    ["sqlKeyword"] = { fg = palette.token },
    ["sqlStatement"] = { fg = palette.token },
    ["Quote"] = { fg = palette.string },
    -- ["sqlOperator"] = { fg = palette.type },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

set_colors(palette1)
