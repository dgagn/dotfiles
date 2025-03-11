local snip = {}

function snip.expand_cmp(cmp)
  local luasnip = require("luasnip")
  local items = cmp.get_items()
  local index = nil
  for idx, item in ipairs(items) do
    if item.source_id == "snippets" then
      index = idx
      break
    end
  end
  if not index then return end
  if luasnip.expandable() then
    return cmp.accept({ index = index })
  end
end

return snip
