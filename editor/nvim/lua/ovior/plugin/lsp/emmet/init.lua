local emmet = {}

local client_name = "emmet_language_server"

local function current_abbreviation()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]
  local line = vim.api.nvim_get_current_line()

  local start_col = col
  while start_col > 0 do
    local char = line:sub(start_col, start_col)
    if not char:match("[%w_%.#:%-%>+%^%*%(%)[%]@%{%}%$=!]") then
      break
    end
    start_col = start_col - 1
  end

  local abbreviation = line:sub(start_col + 1, col)
  if abbreviation == "" then
    return nil
  end

  return {
    row = row,
    start_col = start_col,
    end_col = col,
    text = abbreviation,
  }
end

local function emmet_client(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr, name = client_name })) do
    return client
  end
end

local function cursor_after_opening_tag(lines)
  for row_offset, line in ipairs(lines) do
    local opening_end = line:find(">", 1, true)
    if opening_end and table.concat(lines, "\n"):find("</", opening_end + 1, true) then
      return row_offset - 1, opening_end
    end
  end
end

function emmet.expand_cmp(cmp)
  local bufnr = vim.api.nvim_get_current_buf()
  local client = emmet_client(bufnr)
  local abbr = current_abbreviation()
  if not client or not abbr then
    return
  end

  local result = client:request_sync("emmet/expandAbbreviation", {
    abbreviation = abbr.text,
    language = vim.bo[bufnr].filetype,
    options = {},
  }, 200, bufnr)

  if not result or type(result.result) ~= "string" or result.result == "" or result.result == abbr.text then
    return
  end

  local lines = vim.split(result.result, "\n", {
    plain = true,
  })
  local cursor_row_offset, cursor_col = cursor_after_opening_tag(lines)

  vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end

    cmp.hide()
    vim.api.nvim_buf_set_text(bufnr, abbr.row, abbr.start_col, abbr.row, abbr.end_col, lines)

    if cursor_row_offset and cursor_col then
      if cursor_row_offset == 0 then
        cursor_col = abbr.start_col + cursor_col
      end
      vim.api.nvim_win_set_cursor(0, { abbr.row + cursor_row_offset + 1, cursor_col })
    end
  end)
  return true
end

return emmet
