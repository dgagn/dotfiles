local M = {}

local function runtime_indent()
  if vim.bo.filetype == "typescriptreact" and vim.fn.exists("*GetTypescriptIndent") == 1 then
    return vim.fn.GetTypescriptIndent()
  end

  if vim.bo.filetype == "javascriptreact" and vim.fn.exists("*GetJavascriptIndent") == 1 then
    return vim.fn.GetJavascriptIndent()
  end

  return -1
end

local function is_jsx_tag_line(line)
  local trimmed = vim.trim(line)
  return trimmed:match("^<[/]?[%a][^>]*>%s*$") ~= nil
end

local function is_jsx_sibling_boundary(line)
  local trimmed = vim.trim(line)
  return trimmed:match("^</[%a][^>]*>%s*$") ~= nil or trimmed:match("^<[%a][^>]*/>%s*$") ~= nil
end

local function is_jsx_opening_boundary(line)
  local trimmed = vim.trim(line)
  if trimmed == ">" then
    return true
  end

  return trimmed:match("^<[%a][^>]*>%s*$") ~= nil
    and trimmed:match("/>%s*$") == nil
    and trimmed:find("</", 1, true) == nil
end

function M.react()
  local previous = vim.fn.prevnonblank(vim.v.lnum - 1)
  if previous > 0 and is_jsx_opening_boundary(vim.fn.getline(previous)) then
    return vim.fn.indent(previous) + vim.fn.shiftwidth()
  end

  if previous > 0 and is_jsx_sibling_boundary(vim.fn.getline(previous)) then
    return vim.fn.indent(previous)
  end

  if vim.trim(vim.fn.getline(vim.v.lnum)) ~= "" then
    return runtime_indent()
  end

  local indent = runtime_indent()
  if indent ~= 0 then
    return indent
  end

  if previous > 0 and is_jsx_tag_line(vim.fn.getline(previous)) then
    return vim.fn.indent(previous)
  end

  return indent
end

return M
