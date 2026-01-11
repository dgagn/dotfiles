local csharp = {}

function csharp.setup()
  local ls = require("luasnip")
  local s, i, t = ls.s, ls.insert_node, ls.text_node
  local fmt = require("luasnip.extras.fmt").fmt

  ls.add_snippets("cs", {
    s("cw", fmt("Console.WriteLine({})", {
      i(0)
    })),
  })
end

return csharp
