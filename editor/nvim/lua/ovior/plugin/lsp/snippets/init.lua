local snippets = {}

local function get_last_valid_node()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()
  while node and node:type() == "ERROR" do
    node = node:parent()
  end
  return node
end

function snippets.in_context(types)
  return function()
    local node = get_last_valid_node()
    if not node then
      return false
    end
    local type = node:type()
    print("type: " .. type)
    local value = false
    for i, t in ipairs(types) do
      if t == "_expr" then
        if type:find("expression") then
          print("expression: " .. type)
          value = true
          break
        end
      end
      if type == t then
        value = true
        break
      end
    end
    return value
  end
end

return snippets
