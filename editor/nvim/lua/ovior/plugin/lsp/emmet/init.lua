local emmet = {}

local function expand_abbr_index(items)
  local client_name = "emmet_language_server"
  local idx = nil
  for index, item in ipairs(items) do
    if item.client_name == client_name then
      idx = index
      break
    end
  end
  return idx
end

function emmet.expand_cmp(cmp)
  local items = cmp.get_items()
  local idx = expand_abbr_index(items)
  if not idx then
    return
  end
  return cmp.accept({ index = idx })
end

return emmet
