local snip = {}

function snip.expand_cmp(cmp)
  local luasnip = require("luasnip")
  if luasnip.expandable() then
    vim.schedule(function()
      luasnip.expand()
    end)
    return true
  end
end

return snip
