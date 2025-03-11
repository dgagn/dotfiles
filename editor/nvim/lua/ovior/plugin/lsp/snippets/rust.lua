local rust = {}

local function get_last_valid_node()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()
  while node and node:type() == "ERROR" do
    node = node:parent()
  end
  return node
end

local function in_context(types)
  return function()
    local node = get_last_valid_node()
    if not node then
      return false
    end
    local type = node:type()
    print("type: " .. type)
    local value = false
    for i, t in ipairs(types) do
      if type == t then
        value = true
        break
      end
    end
    return value
  end
end


local function in_file_context(additional)
  local contexts = { "source_file", "declaration_list" }
  if additional then
    for _, v in ipairs(additional) do
      table.insert(contexts, v)
    end
  end
  return in_context(contexts)
end

function rust.setup()
  local ls = require("luasnip")
  local s, i, t = ls.s, ls.insert_node, ls.text_node
  local fmt = require("luasnip.extras.fmt").fmt

  ls.add_snippets("rust", {
    s("d", fmt("#[derive({})]", { i(1, "Debug") }), {
      condition = in_file_context(),
      show_condition = in_file_context(),
    }),
    s(
      "e",
      fmt(
        [[
        #[derive(Debug)]
        enum {} {{
            {}
        }}
        ]],
        { i(1, "Name"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "t",
      fmt(
        [[
        trait {} {{
            {}
        }}
        ]],
        { i(1, "Name"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "impl",
      fmt(
        [[
        impl {} {{
            {}
        }}
        ]],
        { i(1, "Name"), i(0) }
      ),
      {
        condition = in_file_context({ "impl_item" }),
        show_condition = in_file_context({ "impl_item" }),
      }
    ),
    s(
      "implf",
      fmt(
        [[
        impl {} for {} {{
            {}
        }}
        ]],
        { i(1, "Trait"), i(2, "Type"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "s",
      fmt(
        [[
        #[derive(Debug)]
        struct {} {{
            {}
        }}
        ]],
        { i(1, "Name"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "if",
      fmt(
        [[
        if {} {{
            {}
        }}
        ]],
        { i(1, "true"), i(0) }
      ),
      {
        condition = in_context({ "block", "if_expression" }),
        show_condition = in_context({ "block", "if_expression" }),
      }
    ),
    s(
      "if",
      fmt(
        [[
        if {} {{
            {}
        }}
        ]],
        { i(1, "true"), i(0) }
      ),
      {
        condition = in_context({ "block", "if_expression" }),
        show_condition = in_context({ "block", "if_expression" }),
      }
    ),
  })
end

return rust
